#!/bin/bash
# Generate a Jira filter URL from currentTickets.md
# Usage: ./generate-jira-filter.sh [output_format]
# Output formats: url (default), jql, both

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../../../../" && pwd)"
CURRENT_TICKETS="$REPO_ROOT/currentTickets.md"
JIRA_BASE_URL="${JIRA_BASE_URL:-https://jira.hl7.org}"
JIRA_FILTER_ID="${JIRA_FILTER_ID:-22928}"
OUTPUT_FORMAT="${1:-url}"

# Verify currentTickets.md exists
if [[ ! -f "$CURRENT_TICKETS" ]]; then
    echo "Error: currentTickets.md not found at $CURRENT_TICKETS" >&2
    exit 1
fi

# Extract ticket IDs from currentTickets.md (each on its own line, format: FHIR-XXXXX)
TICKETS=$(grep -E '^FHIR-[0-9]+$' "$CURRENT_TICKETS" | tr '\n' ',' | sed 's/,$//')

if [[ -z "$TICKETS" ]]; then
    echo "Error: No FHIR tickets found in currentTickets.md" >&2
    exit 1
fi

# Count tickets
TICKET_COUNT=$(echo "$TICKETS" | tr ',' '\n' | wc -l)

# Build JQL query
JQL="project = FHIR AND Specification = \"FHIR Core (FHIR) [FHIR-core]\" AND key in ( $TICKETS )"

# URL-encode the JQL query
# Simple URL encoding: space->%20, parentheses->%28/%29, quotes->%22, comma->%2C, equals->%3D, and->%20AND%20
ENCODED_JQL=$(printf %s "$JQL" | jq -sRr @uri)

# Build filter URL - using /issues endpoint with optional filter and JQL parameters
if [[ -n "$JIRA_FILTER_ID" ]]; then
    FILTER_URL="${JIRA_BASE_URL}/issues/?filter=${JIRA_FILTER_ID}&jql=${ENCODED_JQL}"
else
    FILTER_URL="${JIRA_BASE_URL}/issues/?jql=${ENCODED_JQL}"
fi

# Output based on format
case "$OUTPUT_FORMAT" in
    jql)
        echo "$JQL"
        ;;
    url)
        echo "$FILTER_URL"
        ;;
    both)
        echo "=== Jira Filter Information ==="
        echo ""
        echo "Ticket Count: $TICKET_COUNT"
        echo ""
        echo "JQL Query:"
        echo "$JQL"
        echo ""
        echo "Filter URL:"
        echo "$FILTER_URL"
        echo ""
        echo "=== To Use ===" 
        echo "1. Click the URL above to open in Jira, OR"
        echo "2. Go to Filters > Advanced Issue Search and paste the JQL query"
        ;;
    *)
        echo "Error: Unknown output format '$OUTPUT_FORMAT'. Use: jql, url, or both" >&2
        exit 1
        ;;
esac
