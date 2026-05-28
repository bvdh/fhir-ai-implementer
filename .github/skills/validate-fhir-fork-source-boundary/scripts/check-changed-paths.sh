#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../../../.." && pwd)"
FORK_DIR="$REPO_ROOT/fhir-fork"
CHECK_MODE="all"

for arg in "$@"; do
  case "$arg" in
    --staged)
      CHECK_MODE="staged"
      ;;
    *)
      echo "ERROR: unknown argument: $arg" >&2
      echo "Usage: $0 [--staged]" >&2
      exit 2
      ;;
  esac
done

if [[ ! -d "$FORK_DIR/.git" ]]; then
  echo "ERROR: fhir-fork repository not found at $FORK_DIR" >&2
  exit 2
fi

changed_paths=()

if [[ "$CHECK_MODE" == "staged" ]]; then
  while IFS= read -r p; do
    [[ -n "$p" ]] && changed_paths+=("$p")
  done < <(git -C "$FORK_DIR" diff --cached --name-only)
else
  while IFS= read -r p; do
    [[ -n "$p" ]] && changed_paths+=("$p")
  done < <(git -C "$FORK_DIR" diff --name-only HEAD)

  while IFS= read -r p; do
    [[ -n "$p" ]] && changed_paths+=("$p")
  done < <(git -C "$FORK_DIR" ls-files --others --exclude-standard)
fi

if [[ ${#changed_paths[@]} -eq 0 ]]; then
  echo "PASS: No pending changes detected in fhir-fork ($CHECK_MODE mode)."
  exit 0
fi

# De-duplicate while preserving simple deterministic order.
unique_sorted_paths=$(printf '%s\n' "${changed_paths[@]}" | awk '!seen[$0]++' | sort)
violations=()

while IFS= read -r p; do
  [[ -z "$p" ]] && continue
  if [[ "$p" != source/* ]]; then
    violations+=("$p")
  fi
done <<< "$unique_sorted_paths"

if [[ ${#violations[@]} -gt 0 ]]; then
  echo "FAIL: Found changes outside fhir-fork/source/ ($CHECK_MODE mode):"
  for p in "${violations[@]}"; do
    echo "  - $p"
  done
  exit 1
fi

echo "PASS: All changed files are under fhir-fork/source/ ($CHECK_MODE mode)."
