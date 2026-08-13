#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
CHECK_CMD="$ROOT_DIR/.github/skills/build-fhir/scripts/build-if-needed.sh --repo $ROOT_DIR/fhir-repo --mode check"

check_output="$($CHECK_CMD 2>&1 || true)"

echo "$check_output"

if echo "$check_output" | grep -q "BUILD_NEEDED: no"; then
  exit 0
fi

echo "BLOCKED: FHIR build output is stale or missing."
echo "Run: ./.github/skills/build-fhir/scripts/build-if-needed.sh --repo ./fhir-repo --mode build"
exit 2
