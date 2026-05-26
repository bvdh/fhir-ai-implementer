#!/bin/bash
# Jira Sync from Excel - Conditional sync using newest Excel file in jira/

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../../../.." && pwd)"
JIRA_DIR="$REPO_ROOT/jira"
CURRENT_TICKETS_FILE="$REPO_ROOT/currentTickets.md"
FORCE_SYNC=false

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

if [[ ${#EXCEL_FILES[@]} -eq 0 ]]; then
    echo "ERROR: No Excel files found in $JIRA_DIR"
    exit 1
fi

EXCEL_FILE="${EXCEL_FILES[0]}"
if [[ ${#EXCEL_FILES[@]} -gt 1 ]]; then
    echo "WARNING: Found ${#EXCEL_FILES[@]} Excel files in jira/:"
    for file in "${EXCEL_FILES[@]}"; do
        echo "  - $(basename "$file")"
    done
    echo "Using most recent: $(basename "$EXCEL_FILE")"
    echo ""
fi

if ! command -v node >/dev/null 2>&1; then
    echo "ERROR: Node.js is not installed"
    exit 1
fi

EXCEL_MTIME=$(stat -c %Y "$EXCEL_FILE" 2>/dev/null || stat -f %m "$EXCEL_FILE" 2>/dev/null)
EXCEL_DATE=$(stat -c '%y' "$EXCEL_FILE" 2>/dev/null | cut -d. -f1 || stat -f '%Sm -t %Y-%m-%d\ %H:%M:%S' "$EXCEL_FILE" 2>/dev/null)

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
    SHOULD_SYNC=false
    echo "Excel/currentTickets newer: NO - skipping sync"
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
