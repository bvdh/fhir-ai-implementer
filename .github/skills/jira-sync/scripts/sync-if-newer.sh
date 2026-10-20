#!/bin/bash
# Jira Sync - Always download a fresh full-content HTML export from Jira and
# parse it directly. Unlike jira-sync-from-excel, this skill never uses local
# Excel files; it fetches the Jira "full content" HTML view and parses it.
#
# By default this performs an INCREMENTAL sync: it only requests issues updated
# since one day before the last successful download (JQL `updated >= <date>`),
# and preserves existing ticket files that are not in the partial export.
#
# Options:
#   --full, --all       Download everything (no `updated` filter) and prune
#                       ticket directories no longer in the result set.
#   --week              Only issues updated in the last 7 days.
#   --month             Only issues updated in the last month.
#   --since YYYY-MM-DD  Only issues updated on/after the given date.
#   --all-batched       Download all matching tickets in monthly batches
#                       (starting with most recent) and prune old tickets.
#   --force             Alias for the default incremental behavior (kept for
#                       backward compatibility); does not change the filter.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../../../.." && pwd)"
JIRA_DIR="$REPO_ROOT/jira"
PARSER_SCRIPT="$SCRIPT_DIR/sync-jira-from-html.mjs"
STATE_FILE="$SCRIPT_DIR/../.last-sync"

# Base JQL (unencoded). The `updated >= ...` clause and ORDER BY are appended
# dynamically so the query can be filtered incrementally.
JQL_BASE='project = FHIR AND Specification = "FHIR Core (FHIR) [FHIR-core]" AND ((type = "Technical Correction" and status not in (Published)) OR status not in (Published, "Change Not Needed", "Resolved - No Change", Deferred ))'
JQL_ORDER='ORDER BY status DESC'
JIRA_BASE_URL="https://jira.hl7.org/sr/jira.issueviews:searchrequest-fullcontent/temp/SearchRequest.html"
TEMP_MAX=1000

MODE="incremental"   # incremental | full | batched
SINCE=""
BATCHED_QUERY=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        --full|--all)
            MODE="full"
            ;;
        --week)
            MODE="incremental"
            SINCE="$(date -d '-7 days' +%Y-%m-%d 2>/dev/null || date -v-7d +%Y-%m-%d)"
            ;;
        --month)
            MODE="incremental"
            SINCE="$(date -d '-1 month' +%Y-%m-%d 2>/dev/null || date -v-1m +%Y-%m-%d)"
            ;;
        --since)
            shift
            if [[ -z "${1:-}" ]]; then
                echo "ERROR: --since requires a YYYY-MM-DD date"
                exit 1
            fi
            MODE="incremental"
            SINCE="$1"
            ;;
        --all-batched)
            MODE="batched"
            ;;
        --force)
            # Backward-compatible no-op flag; default is already incremental.
            ;;
        *)
            echo "ERROR: unknown argument: $1"
            exit 1
            ;;
    esac
    shift
done

if [[ ! -d "$JIRA_DIR" ]]; then
    echo "ERROR: jira directory not found: $JIRA_DIR"
    exit 1
fi

if [[ ! -f "$PARSER_SCRIPT" ]]; then
    echo "ERROR: parser script not found: $PARSER_SCRIPT"
    exit 1
fi

if ! command -v node >/dev/null 2>&1; then
    echo "ERROR: Node.js is not installed"
    exit 1
fi

if ! command -v curl >/dev/null 2>&1; then
    echo "ERROR: curl is required to download Jira export but is not installed"
    exit 1
fi

if [[ ! -d "$SCRIPT_DIR/../node_modules/cheerio" ]]; then
    echo "Installing jira-sync dependencies (cheerio)..."
    ( cd "$SCRIPT_DIR/.." && npm install --no-audit --no-fund >/dev/null 2>&1 ) || {
        echo "ERROR: failed to install jira-sync dependencies"
        exit 1
    }
fi

# Resolve the incremental `since` date when not explicitly provided.
if [[ "$MODE" == "incremental" && -z "$SINCE" ]]; then
    if [[ -f "$STATE_FILE" ]]; then
        LAST_SYNC="$(head -n1 "$STATE_FILE" | tr -d '[:space:]')"
        if [[ "$LAST_SYNC" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
            SINCE="$(date -d "$LAST_SYNC -1 day" +%Y-%m-%d 2>/dev/null || date -j -v-1d -f %Y-%m-%d "$LAST_SYNC" +%Y-%m-%d)"
        fi
    fi
    if [[ -z "$SINCE" ]]; then
        MODE="full"
        echo "No previous sync recorded - performing a full seed download."
    fi
fi

# Function to download and parse a batch with a specific date range
download_batch() {
    local batch_start="$1"
    local batch_end="$2"
    local batch_jql="$3"
    local is_last_batch="$4"
    local prune_flag=""
    
    if [[ "$is_last_batch" == "true" ]]; then
        prune_flag="--prune"
    fi
    
    echo ""
    echo "Downloading batch: $batch_start to $batch_end"
    
    local batch_encoded="$(node -e 'process.stdout.write(encodeURIComponent(process.argv[1]))' "$batch_jql")"
    local batch_url="${JIRA_BASE_URL}?jqlQuery=${batch_encoded}&tempMax=${TEMP_MAX}"
    
    local batch_file="$(mktemp "${TMPDIR:-/tmp}/jira-batch-XXXXXX.html")"
    cleanup_batch() { rm -f "$batch_file"; }
    trap cleanup_batch EXIT
    
    set +e
    local http_code=$(curl "${curl_args[@]}" -w '%{http_code}' -o "$batch_file" "$batch_url")
    local curl_status=$?
    set -e
    
    if [[ $curl_status -ne 0 ]]; then
        echo "ERROR: curl failed for batch $batch_start to $batch_end (exit code $curl_status)"
        return 1
    fi
    
    if [[ "$http_code" != "200" ]]; then
        echo "ERROR: Failed to download batch $batch_start to $batch_end (HTTP ${http_code:-unknown})"
        return 1
    fi
    
    if [[ ! -s "$batch_file" ]]; then
        echo "WARNING: Downloaded batch is empty for $batch_start to $batch_end"
        return 0
    fi
    
    if ! grep -q 'class="formtitle"' "$batch_file"; then
        echo "ERROR: Batch response did not contain issue content"
        return 1
    fi
    
    local batch_bytes=$(stat -c %s "$batch_file" 2>/dev/null || stat -f %z "$batch_file" 2>/dev/null)
    echo "Downloaded batch: ${batch_bytes:-unknown} bytes"
    
    node "$PARSER_SCRIPT" --jira-dir "$JIRA_DIR" --html "$batch_file" $prune_flag
    
    rm -f "$batch_file"
    return 0
}

# Handle batched download mode
if [[ "$MODE" == "batched" ]]; then
    echo "Downloading all matching tickets in monthly batches (most recent first)..."
    
    # Setup curl args for batched downloads (done outside the loop)
    cookie_file="${JIRA_COOKIE_FILE:-}"
    jira_user="${JIRA_USER:-}"
    jira_token="${JIRA_API_TOKEN:-${JIRA_TOKEN:-}}"
    jira_bearer_token="${JIRA_BEARER_TOKEN:-}"
    declare -a curl_args
    
    curl_args=(
        -LsS
        --retry 3
        --retry-delay 2
        --retry-all-errors
        --connect-timeout 20
        --max-time 900
        --user-agent "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0 Safari/537.36"
        -H "Accept: text/html,application/xhtml+xml,*/*"
    )
    
    if [[ -t 2 ]]; then
        curl_args+=( --progress-bar )
    else
        curl_args+=( --no-progress-meter )
    fi
    
    if [[ -n "$cookie_file" ]]; then
        if [[ ! -f "$cookie_file" ]]; then
            echo "ERROR: JIRA_COOKIE_FILE is set but does not exist: $cookie_file"
            exit 1
        fi
        curl_args+=( -b "$cookie_file" -c "$cookie_file" )
    fi
    
    if [[ -n "$jira_bearer_token" ]]; then
        curl_args+=( -H "Authorization: Bearer ${jira_bearer_token}" )
    fi
    
    if [[ -n "$jira_user" && -n "$jira_token" ]]; then
        curl_args+=( -u "${jira_user}:${jira_token}" )
    elif [[ -n "$jira_user" || -n "$jira_token" ]]; then
        echo "ERROR: Both JIRA_USER and JIRA_API_TOKEN (or JIRA_TOKEN) must be set together"
        exit 1
    fi
    
    # Start from current date and go back
    local current_date=$(date +%Y-%m-%d)
    local batch_end="$current_date"
    local batch_start=""
    local total_batches=0
    local is_last=false
    
    # We'll keep downloading batches until we reach the cutoff date
    # Assume tickets date back to 2020 (adjust as needed)
    local start_year=$(date -d '6 years ago' +%Y 2>/dev/null || date -v-6y +%Y)
    local cutoff_date="${start_year}-01-01"
    
    while true; do
        # Calculate batch start (1 month back from batch_end)
        batch_start=$(date -d "$batch_end -1 month" +%Y-%m-%d 2>/dev/null || date -j -v-1m -f %Y-%m-%d "$batch_end" +%Y-%m-%d)
        
        # Check if we've gone back far enough
        if [[ "$batch_start" < "$cutoff_date" ]]; then
            batch_start="$cutoff_date"
            is_last=true
        fi
        
        ((total_batches++))
        
        local batch_query="$JQL_BASE AND updated >= \"$batch_start\" AND updated < \"$batch_end\" $JQL_ORDER"
        
        if download_batch "$batch_start" "$batch_end" "$batch_query" "$is_last"; then
            if [[ "$is_last" == "true" ]]; then
                break
            fi
            batch_end="$batch_start"
        else
            echo "WARNING: Batch download failed, but continuing with next batch"
            if [[ "$is_last" == "true" ]]; then
                break
            fi
            batch_end="$batch_start"
        fi
    done
    
    echo ""
    echo "Downloaded $total_batches batches total"
    date +%Y-%m-%d > "$STATE_FILE"
    echo "Jira sync (batched) completed successfully"
    exit 0
fi

# Build the effective JQL.
if [[ "$MODE" == "incremental" && -n "$SINCE" ]]; then
    JQL="$JQL_BASE AND updated >= \"$SINCE\" $JQL_ORDER"
else
    JQL="$JQL_BASE $JQL_ORDER"
fi

# URL-encode the JQL using node (portable, avoids shell escaping issues).
ENCODED_JQL="$(node -e 'process.stdout.write(encodeURIComponent(process.argv[1]))' "$JQL")"
JIRA_EXPORT_URL="${JIRA_BASE_URL}?jqlQuery=${ENCODED_JQL}&tempMax=${TEMP_MAX}"

HTML_FILE="$(mktemp "${TMPDIR:-/tmp}/jira-fullcontent-XXXXXX.html")"
cleanup() { rm -f "$HTML_FILE"; }
trap cleanup EXIT

cookie_file="${JIRA_COOKIE_FILE:-}"
jira_user="${JIRA_USER:-}"
jira_token="${JIRA_API_TOKEN:-${JIRA_TOKEN:-}}"
jira_bearer_token="${JIRA_BEARER_TOKEN:-}"
declare -a curl_args
http_code=""
curl_status=0
progress_mode=""

curl_args=(
    -LsS
    --retry 3
    --retry-delay 2
    --retry-all-errors
    --connect-timeout 20
    --max-time 900
    --user-agent "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0 Safari/537.36"
    -H "Accept: text/html,application/xhtml+xml,*/*"
)

if [[ -t 2 ]]; then
    progress_mode="interactive"
    curl_args+=( --progress-bar )
else
    progress_mode="non-interactive"
    curl_args+=( --no-progress-meter )
fi

if [[ -n "$cookie_file" ]]; then
    if [[ ! -f "$cookie_file" ]]; then
        echo "ERROR: JIRA_COOKIE_FILE is set but does not exist: $cookie_file"
        exit 1
    fi
    curl_args+=( -b "$cookie_file" -c "$cookie_file" )
fi

if [[ -n "$jira_bearer_token" ]]; then
    curl_args+=( -H "Authorization: Bearer ${jira_bearer_token}" )
fi

if [[ -n "$jira_user" && -n "$jira_token" ]]; then
    curl_args+=( -u "${jira_user}:${jira_token}" )
elif [[ -n "$jira_user" || -n "$jira_token" ]]; then
    echo "ERROR: Both JIRA_USER and JIRA_API_TOKEN (or JIRA_TOKEN) must be set together"
    exit 1
fi

echo "Downloading fresh Jira full-content export..."
echo "Source: $JIRA_EXPORT_URL"
if [[ "$MODE" == "incremental" && -n "$SINCE" ]]; then
    echo "Sync mode: incremental (updated >= $SINCE)"
else
    echo "Sync mode: full (all matching issues)"
fi
echo "Download mode: $progress_mode"
echo "This export can take several minutes for large Jira result sets."
if [[ -n "$cookie_file" ]]; then
    echo "Using Jira cookie file: $cookie_file"
fi
if [[ -n "$jira_user" ]]; then
    echo "Using Jira credentials from environment for user: $jira_user"
fi
if [[ -n "$jira_bearer_token" ]]; then
    echo "Using Jira bearer token from environment"
fi

set +e
http_code=$(curl "${curl_args[@]}" -w '%{http_code}' -o "$HTML_FILE" "$JIRA_EXPORT_URL")
curl_status=$?
set -e

if [[ $curl_status -ne 0 ]]; then
    echo "ERROR: curl failed while downloading Jira export (exit code $curl_status)"
    exit 1
fi

if [[ "$http_code" != "200" ]]; then
    if [[ "$http_code" == "403" ]]; then
        echo "ERROR: Jira export request returned HTTP 403 (forbidden)."
        echo "Set one of these auth options and retry:"
        echo "  1) JIRA_COOKIE_FILE=/path/to/jira-cookies.txt"
        echo "  2) JIRA_USER=<username> and JIRA_API_TOKEN=<token>"
        echo "  3) JIRA_BEARER_TOKEN=<token>"
    else
        echo "ERROR: Failed to download Jira export (HTTP ${http_code:-unknown})"
    fi
    exit 1
fi

if [[ ! -s "$HTML_FILE" ]]; then
    echo "ERROR: Downloaded Jira export is empty"
    exit 1
fi

if ! grep -q 'class="formtitle"' "$HTML_FILE"; then
    echo "ERROR: Jira response did not contain issue content (likely auth or redirect page)"
    echo "Set JIRA_COOKIE_FILE, JIRA_USER/JIRA_API_TOKEN, or JIRA_BEARER_TOKEN and retry"
    exit 1
fi

DOWNLOAD_BYTES=$(stat -c %s "$HTML_FILE" 2>/dev/null || stat -f %z "$HTML_FILE" 2>/dev/null)
echo "Downloaded Jira full-content export: ${DOWNLOAD_BYTES:-unknown} bytes"
echo ""

if [[ "$MODE" == "full" ]]; then
    node "$PARSER_SCRIPT" --jira-dir "$JIRA_DIR" --html "$HTML_FILE" --prune
else
    node "$PARSER_SCRIPT" --jira-dir "$JIRA_DIR" --html "$HTML_FILE"
fi

# Record the successful download date for the next incremental run.
date +%Y-%m-%d > "$STATE_FILE"

echo ""
echo "Jira sync completed successfully"
