#!/usr/bin/env bash

set -euo pipefail

if [[ "${1:-}" == "--help" || "${1:-}" == "-h" ]]; then
  printf 'Usage: %s\n' "$0"
  printf 'Sync <number>-status.md, including description and comments, for bvdh in HL7/fhir into pr/<status>/<number>-<pr-name>/.\n'
  exit 0
fi

if [[ $# -gt 0 ]]; then
  printf 'Error: unexpected argument: %s\n' "$1" >&2
  printf 'Use --help for usage.\n' >&2
  exit 2
fi

for tool in gh jq node; do
  if ! command -v "$tool" >/dev/null 2>&1; then
    printf 'Error: required command not found: %s\n' "$tool" >&2
    exit 1
  fi
done

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(git -C "$script_dir" rev-parse --show-toplevel)"
output_dir="$repo_root/pr"
jira_sync_dir="$repo_root/.github/skills/jira-sync"

jira_sync_is_fresh() {
  node - "$jira_sync_dir/.last-sync" <<'JS'
const fs = require('node:fs');
const file = process.argv[2];
if (!fs.existsSync(file)) process.exit(1);
const age = Date.now() - fs.statSync(file).mtimeMs;
process.exit(age >= 0 && age <= 3600000 ? 0 : 1);
JS
}

if ! jira_sync_is_fresh; then
  printf 'Jira sync is missing or older than one hour; running jira-sync first.\n'
  if ! bash "$jira_sync_dir/scripts/sync-if-newer.sh"; then
    printf 'Error: Jira refresh failed; stopping PR sync rather than reporting stale ticket discrepancies.\n' >&2
    exit 1
  fi
  if ! jira_sync_is_fresh; then
    printf 'Error: Jira sync did not produce a successful sync marker within the last hour; stopping PR sync.\n' >&2
    exit 1
  fi
else
  printf 'Jira sync completed within the last hour; using the current local snapshot.\n'
fi

max_results=1000
response_file="$(mktemp)"
work_dir="$(mktemp -d)"
cleanup() {
  rm -f "$response_file" "$work_dir/discussion.json" "$work_dir/reviews.json" \
    "$work_dir/inline.json" "$work_dir/status.md" "$work_dir/description.md" "$work_dir/comments.md"
  rmdir "$work_dir"
}
trap cleanup EXIT

if ! gh pr list \
  --repo HL7/fhir \
  --author bvdh \
  --state all \
  --limit "$max_results" \
  --json number,title,body,url,state,isDraft,mergedAt,closedAt,updatedAt,createdAt,baseRefName,headRefName,reviewDecision,statusCheckRollup \
  >"$response_file"; then
  printf 'Error: failed to retrieve pull requests from HL7/fhir. Check GitHub CLI authentication and repository access.\n' >&2
  exit 1
fi

if ! jq -e 'type == "array"' "$response_file" >/dev/null; then
  printf 'Error: GitHub CLI returned an unexpected pull request response.\n' >&2
  exit 1
fi

pr_count="$(jq 'length' "$response_file")"
if (( pr_count >= max_results )); then
  printf 'Error: GitHub returned %s PRs, reaching the %s-result limit; no records were written because the result may be incomplete.\n' "$pr_count" "$max_results" >&2
  exit 1
fi

sync_time="$(date -u '+%Y-%m-%dT%H:%M:%SZ')"
mkdir -p "$output_dir/merged" "$output_dir/closed" "$output_dir/open" "$output_dir/draft"

render_content() {
  local comment_type endpoint
  for comment_type in discussion reviews inline; do
    case "$comment_type" in
      discussion) endpoint="repos/HL7/fhir/issues/$number/comments" ;;
      reviews) endpoint="repos/HL7/fhir/pulls/$number/reviews" ;;
      inline) endpoint="repos/HL7/fhir/pulls/$number/comments" ;;
    esac
    if ! gh api "$endpoint?per_page=100" --paginate --slurp >"$work_dir/$comment_type.json"; then
      printf 'Error: failed to retrieve %s comments for PR #%s; sync is incomplete.\n' "$comment_type" "$number" >&2
      exit 1
    fi
  done

  jq -r '.body // "" | if . == "" then "No PR description provided." else . end' \
    <<<"$pr_json" >"$work_dir/description.md"
  jq -nr --arg number "$number" \
    --slurpfile discussion "$work_dir/discussion.json" \
    --slurpfile reviews "$work_dir/reviews.json" \
    --slurpfile inline "$work_dir/inline.json" '
    ([$discussion[0][][] | . + {kind: "Discussion comment"}] +
     [$reviews[0][][] | . + {kind: "Review"}] +
     [$inline[0][][] | . + {kind: "Inline review comment"}]
     | sort_by(.created_at // .submitted_at // "", .id)) as $comments |
    "# Comments for HL7/fhir#\($number)\n\n" +
    (if ($comments | length) == 0 then "No comments or reviews reported.\n"
     else [$comments[] |
       "### \(.kind) by \(.user.login // "deleted-user")\n\n" +
       "- Date: \(.created_at // .submitted_at // "not reported")\n" +
       "- Link: \(.html_url)\n" +
       (if .state then "- Review state: \(.state)\n" else "" end) +
       (if .path then "- File: `\(.path)`\n- Line: \(.line // .original_line // "not reported")\n" else "" end) +
       (if .in_reply_to_id then "- In reply to: review comment \(.in_reply_to_id)\n" else "" end) +
       "\n" + (if (.body // "") == "" then "_No comment text._" else .body end)
     ] | join("\n\n---\n\n") + "\n" end)
  ' >"$work_dir/comments.md"
}

while IFS= read -r pr_json; do
  number="$(jq -r '.number' <<<"$pr_json")"
  pr_name="$(jq -r '.title | ascii_downcase | gsub("[^a-z0-9]+"; "-") | gsub("(^-+|-+$)"; "") | .[0:80] | gsub("-+$"; "")' <<<"$pr_json")"
  if [[ -z "$pr_name" ]]; then
    pr_name="untitled"
  fi
  category="$(jq -r 'if .state == "MERGED" then "merged" elif .state == "CLOSED" then "closed" elif .isDraft then "draft" else "open" end' <<<"$pr_json")"
  legacy_dir="$output_dir/$number-$pr_name"
  destination_dir="$output_dir/$category/$number-$pr_name"
  existing_dirs=()

  if [[ -d "$legacy_dir" ]]; then
    existing_dirs+=("$legacy_dir")
  fi
  for status in merged closed open draft; do
    while IFS= read -r existing_dir; do
      existing_dirs+=("$existing_dir")
    done < <(find "$output_dir/$status" -mindepth 1 -maxdepth 1 -type d -name "$number-*" -print)
  done

  if (( ${#existing_dirs[@]} > 1 )); then
    printf 'Error: multiple existing directories found for PR #%s; refusing to move or overwrite them:\n' "$number" >&2
    printf '  %s\n' "${existing_dirs[@]}" >&2
    exit 1
  fi
  if (( ${#existing_dirs[@]} == 1 )) && [[ "${existing_dirs[0]}" != "$destination_dir" && -e "$destination_dir" ]]; then
    printf 'Error: PR #%s source and destination directories both exist; refusing to overwrite either:\n  %s\n  %s\n' "$number" "${existing_dirs[0]}" "$destination_dir" >&2
    exit 1
  fi
done < <(jq -c '.[]' "$response_file")

merged_count=0
closed_count=0
open_count=0
draft_count=0
while IFS= read -r pr_json; do
  number="$(jq -r '.number' <<<"$pr_json")"
  render_content
  pr_name="$(jq -r '.title | ascii_downcase | gsub("[^a-z0-9]+"; "-") | gsub("(^-+|-+$)"; "") | .[0:80] | gsub("-+$"; "")' <<<"$pr_json")"
  if [[ -z "$pr_name" ]]; then
    pr_name="untitled"
  fi
  category="$(jq -r 'if .state == "MERGED" then "merged" elif .state == "CLOSED" then "closed" elif .isDraft then "draft" else "open" end' <<<"$pr_json")"
  pr_dir="$output_dir/$category/$number-$pr_name"
  existing_dirs=()
  legacy_dir="$output_dir/$number-$pr_name"
  if [[ -d "$legacy_dir" ]]; then
    existing_dirs+=("$legacy_dir")
  fi
  for status in merged closed open draft; do
    while IFS= read -r existing_dir; do
      existing_dirs+=("$existing_dir")
    done < <(find "$output_dir/$status" -mindepth 1 -maxdepth 1 -type d -name "$number-*" -print)
  done
  if (( ${#existing_dirs[@]} == 1 )) && [[ "${existing_dirs[0]}" != "$pr_dir" ]]; then
    mv "${existing_dirs[0]}" "$pr_dir"
  fi
  mkdir -p "$pr_dir"
  status_file="$work_dir/status.md"

  jq -r --arg synced "$sync_time" '
    def value_or_na: if . == null or . == "" then "not reported" else tostring end;
    "# PR #\(.number): \(.title)\n\n" +
    "- Repository: [HL7/fhir](https://github.com/HL7/fhir)\n" +
    "- Pull request: [#\(.number)](\(.url))\n" +
    "- Status: `\(.state)`\n" +
    "- Draft: \(.isDraft)\n" +
    "- Branches: `\(.headRefName)` → `\(.baseRefName)`\n" +
    "- Review decision: \(.reviewDecision | value_or_na)\n" +
    "- Created: \(.createdAt | value_or_na)\n" +
    "- Updated: \(.updatedAt | value_or_na)\n" +
    "- Closed: \(.closedAt | value_or_na)\n" +
    "- Merged: \(.mergedAt | value_or_na)\n" +
    "- Synced: \($synced)\n\n" +
    "## Checks\n\n" +
    (if (.statusCheckRollup // [] | length) == 0 then
      "No check results reported.\n"
    else
      "| Check | Status | Conclusion |\n|---|---|---|\n" +
      ([.statusCheckRollup[] |
        "| \(.name // .workflowName // "Check") | \(.status // .state // "not reported") | \(.conclusion // "not reported") |"
      ] | join("\n")) + "\n"
    end)
  ' <<<"$pr_json" >"$status_file"

  {
    printf '\n## Description\n\n'
    cat "$work_dir/description.md"
    printf '\n## Comments\n\n'
    sed '1,2d' "$work_dir/comments.md"
  } >>"$status_file"

  mv -f "$status_file" "$pr_dir/$number-status.md"
  rm -f "$pr_dir/status.md" "$pr_dir/description.md" "$pr_dir/comments.md"
  case "$category" in
    merged) ((merged_count += 1)) ;;
    closed) ((closed_count += 1)) ;;
    open) ((open_count += 1)) ;;
    draft) ((draft_count += 1)) ;;
  esac
done < <(jq -c '.[]' "$response_file")

node "$script_dir/report-jira.mjs" "$response_file" "$repo_root"

printf 'Synchronized %s pull request(s) from HL7/fhir into %s:\n' "$pr_count" "$output_dir"
printf '  merged: %s\n  closed: %s\n  open: %s\n  draft: %s\n' "$merged_count" "$closed_count" "$open_count" "$draft_count"
