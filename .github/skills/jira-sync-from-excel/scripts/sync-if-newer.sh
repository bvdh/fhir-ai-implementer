#!/bin/bash
# Jira Sync from Excel - Conditional sync using newest Excel file in jira/

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../../../.." && pwd)"
JIRA_DIR="$REPO_ROOT/jira"
CURRENT_TICKETS_FILE="$REPO_ROOT/currentTickets.md"
FORCE_SYNC=false
JIRA_EXPORT_URL="https://jira.hl7.org/sr/jira.issueviews:searchrequest-fullcontent/temp/SearchRequest.html?jqlQuery=project+%3D+FHIR+AND+Specification+%3D+%22FHIR+Core+%28FHIR%29+%5BFHIR-core%5D%22+AND+%28%28type+%3D+%22Technical+Correction%22+and+status+not+in+%28Published%29%29+OR+status+not+in+%28Published%2C+%22Change+Not+Needed%22%2C+%22Resolved+-+No+Change%22%2C+Deferred+%29%29+AND+%22Work+Group%22+%3D+%22FHIR+Infrastructure+%5Bfhir-i%5D%22+ORDER+BY+status+DESC&tempMax=1000"

download_excel_from_jira() {
    if ! command -v curl >/dev/null 2>&1; then
        echo "ERROR: curl is required to download Jira export but is not installed"
        return 1
    fi

    local timestamp
    local out_file
    timestamp=$(date +"%Y%m%d-%H%M%S")
    out_file="$JIRA_DIR/fhir-core-fhir-i-${timestamp}.xlsx"
    local cookie_file="${JIRA_COOKIE_FILE:-}"
    local jira_user="${JIRA_USER:-}"
    local jira_token="${JIRA_API_TOKEN:-${JIRA_TOKEN:-}}"
    local jira_bearer_token="${JIRA_BEARER_TOKEN:-}"
    local -a curl_args
    local http_code
    local curl_status=0
    local progress_mode

    curl_args=(
        -LsS
        --retry 3
        --retry-delay 2
        --retry-all-errors
        --connect-timeout 20
        --max-time 900
        --user-agent "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0 Safari/537.36"
        -H "Accept: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,application/octet-stream,*/*"
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
            return 1
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
        return 1
    fi

    echo "No new Excel export found locally. Attempting download from Jira..."
    echo "Source: $JIRA_EXPORT_URL"
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
    http_code=$(curl "${curl_args[@]}" -w '%{http_code}' -o "$out_file" "$JIRA_EXPORT_URL")
    curl_status=$?
    set -e

    if [[ $curl_status -ne 0 ]]; then
        rm -f "$out_file"
        echo "ERROR: curl failed while downloading Jira export (exit code $curl_status)"
        return 1
    fi

    if [[ "$http_code" != "200" ]]; then
        rm -f "$out_file"
        if [[ "$http_code" == "403" ]]; then
            echo "ERROR: Jira export request returned HTTP 403 (forbidden)."
            echo "Set one of these auth options and retry:"
            echo "  1) JIRA_COOKIE_FILE=/path/to/jira-cookies.txt"
            echo "  2) JIRA_USER=<username> and JIRA_API_TOKEN=<token>"
            echo "  3) JIRA_BEARER_TOKEN=<token>"
        else
            echo "ERROR: Failed to download Jira export (HTTP ${http_code:-unknown})"
        fi
        return 1
    fi

    if [[ ! -s "$out_file" ]]; then
        rm -f "$out_file"
        echo "ERROR: Downloaded Jira export is empty"
        return 1
    fi

    if file "$out_file" | grep -qiE 'html|text'; then
        rm -f "$out_file"
        echo "ERROR: Jira response was not an Excel file (likely auth or redirect page)"
        echo "Set JIRA_COOKIE_FILE, JIRA_USER/JIRA_API_TOKEN, or JIRA_BEARER_TOKEN and retry"
        return 1
    fi

    echo "Downloaded Jira export: $out_file"
    EXCEL_FILE="$out_file"
    EXCEL_FILES=("$out_file")
    EXCEL_MTIME=$(stat -c %Y "$EXCEL_FILE" 2>/dev/null || stat -f %m "$EXCEL_FILE" 2>/dev/null)
    EXCEL_DATE=$(stat -c '%y' "$EXCEL_FILE" 2>/dev/null | cut -d. -f1 || stat -f '%Sm -t %Y-%m-%d\ %H:%M:%S' "$EXCEL_FILE" 2>/dev/null)
}

for arg in "$@"; do
    if [[ "$arg" == "--force" ]]; then
        FORCE_SYNC=true
    fi
done

if [[ ! -d "$JIRA_DIR" ]]; then
    echo "ERROR: jira directory not found: $JIRA_DIR"
    exit 1
fi

EXCEL_FILES=()
while IFS= read -r file; do
    EXCEL_FILES+=("$file")
done < <(find "$JIRA_DIR" -maxdepth 1 -type f -name "*.xlsx" -printf '%T@ %p\n' | sort -rn | awk '{ $1=""; sub(/^ /, ""); print }')

if ! command -v node >/dev/null 2>&1; then
    echo "ERROR: Node.js is not installed"
    exit 1
fi

EXCEL_FILE=""
EXCEL_MTIME=0
EXCEL_DATE="not found"
if [[ ${#EXCEL_FILES[@]} -eq 0 ]]; then
    if ! download_excel_from_jira; then
        exit 1
    fi
else
    EXCEL_FILE="${EXCEL_FILES[0]}"
    if [[ ${#EXCEL_FILES[@]} -gt 1 ]]; then
        echo "WARNING: Found ${#EXCEL_FILES[@]} Excel files in jira/:"
        for file in "${EXCEL_FILES[@]}"; do
            echo "  - $(basename "$file")"
        done
        echo "Using most recent: $(basename "$EXCEL_FILE")"
        echo ""
    fi

    EXCEL_MTIME=$(stat -c %Y "$EXCEL_FILE" 2>/dev/null || stat -f %m "$EXCEL_FILE" 2>/dev/null)
    EXCEL_DATE=$(stat -c '%y' "$EXCEL_FILE" 2>/dev/null | cut -d. -f1 || stat -f '%Sm -t %Y-%m-%d\ %H:%M:%S' "$EXCEL_FILE" 2>/dev/null)
fi

CURRENT_TICKETS_MTIME=0
CURRENT_TICKETS_DATE="not found"
if [[ -f "$CURRENT_TICKETS_FILE" ]]; then
    CURRENT_TICKETS_MTIME=$(stat -c %Y "$CURRENT_TICKETS_FILE" 2>/dev/null || stat -f %m "$CURRENT_TICKETS_FILE" 2>/dev/null)
    CURRENT_TICKETS_DATE=$(stat -c '%y' "$CURRENT_TICKETS_FILE" 2>/dev/null | cut -d. -f1 || stat -f '%Sm -t %Y-%m-%d\ %H:%M:%S' "$CURRENT_TICKETS_FILE" 2>/dev/null)
fi

echo "Excel file: $EXCEL_FILE"
echo "Excel modification time: $EXCEL_DATE"
echo "currentTickets file: $CURRENT_TICKETS_FILE"
echo "currentTickets modification time: $CURRENT_TICKETS_DATE"

OLDEST_DIR_MTIME=0

for root in "$JIRA_DIR/open" "$JIRA_DIR/active" "$JIRA_DIR/closed" "$JIRA_DIR"; do
    for dir in "$root"/FHIR-*/; do
        if [[ -d "$dir" ]]; then
            DIR_MTIME=$(stat -c %Y "$dir" 2>/dev/null || stat -f %m "$dir" 2>/dev/null)
            if [[ $OLDEST_DIR_MTIME -eq 0 ]] || [[ $DIR_MTIME -lt $OLDEST_DIR_MTIME ]]; then
                OLDEST_DIR_MTIME=$DIR_MTIME
            fi
        fi
    done
done

if [[ $FORCE_SYNC == true ]]; then
    SHOULD_SYNC=true
    echo "Force sync enabled: YES - syncing..."
elif [[ $OLDEST_DIR_MTIME -eq 0 ]]; then
    SHOULD_SYNC=true
    echo "No existing ticket directories - syncing to create them..."
elif [[ $CURRENT_TICKETS_MTIME -gt $OLDEST_DIR_MTIME ]]; then
    SHOULD_SYNC=true
    echo "currentTickets is newer: YES - syncing..."
elif [[ $EXCEL_MTIME -gt $OLDEST_DIR_MTIME ]]; then
    SHOULD_SYNC=true
    echo "Excel is newer: YES - syncing..."
else
    if download_excel_from_jira; then
        SHOULD_SYNC=true
        echo "Downloaded a fresh Jira export: YES - syncing..."
    else
        SHOULD_SYNC=false
        echo "Excel/currentTickets newer: NO - skipping sync"
    fi
fi

if [[ $SHOULD_SYNC == true ]]; then
    echo ""
    node "$SCRIPT_DIR/sync-jira-tickets.mjs" --jira-dir "$JIRA_DIR" --excel "$EXCEL_FILE"
    echo ""
    echo "Jira sync completed successfully"
else
    echo ""
    echo "No updates needed - ticket files are already current"
fi
