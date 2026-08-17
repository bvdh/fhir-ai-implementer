#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../../.." && pwd)"
BUILD_CHECK_SCRIPT="$ROOT_DIR/.github/skills/build-fhir/scripts/build-if-needed.sh"
BUILD_SCRIPT="$ROOT_DIR/.github/skills/build-fhir/scripts/build-if-needed.sh"
FHIR_OUTPUT_DIR="$ROOT_DIR/fhir-repo/output"
FHIR_PUBLISH_DIR="$ROOT_DIR/fhir-repo/publish"
REPORT_DIR="$ROOT_DIR/review"

usage() {
  cat <<'EOF'
Usage: review-page.sh <target-page>

Examples:
  review-page.sh patient.html
  review-page.sh fhir-repo/output/patient.html
EOF
}

ask_rebuild() {
  local answer=""
  printf 'Build is stale or missing. Rebuild now with ./gradlew publish? [y/N]: ' >&2
  read -r answer || true
  case "$answer" in
    y|Y|yes|YES)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

if [[ $# -lt 1 ]]; then
  usage
  exit 2
fi

TARGET_INPUT="$1"
mkdir -p "$REPORT_DIR"

BUILD_RESULT="$($BUILD_CHECK_SCRIPT --repo "$ROOT_DIR/fhir-repo" --mode check)"

if [[ "$BUILD_RESULT" == "BUILD_NEEDED: yes (output directory missing)" ]]; then
  if [[ -d "$FHIR_PUBLISH_DIR" ]] && find "$FHIR_PUBLISH_DIR" -type f -name '*.html' -print -quit | grep -q .; then
    BUILD_RESULT="BUILD_NEEDED: no (publish directory fallback)"
  fi
fi

resolve_output_file() {
  local input="$1"
  local candidate=""

  if [[ -f "$input" ]]; then
    candidate="$(cd "$(dirname "$input")" && pwd)/$(basename "$input")"
    printf '%s\n' "$candidate"
    return 0
  fi

  if [[ -f "$ROOT_DIR/$input" ]]; then
    candidate="$(cd "$(dirname "$ROOT_DIR/$input")" && pwd)/$(basename "$ROOT_DIR/$input")"
    printf '%s\n' "$candidate"
    return 0
  fi

  local name
  name="$(basename "$input")"
  local resolved=""
  if [[ -d "$FHIR_OUTPUT_DIR" ]]; then
    resolved="$(find "$FHIR_OUTPUT_DIR" -type f -name "$name" | LC_ALL=C sort | head -n1)"
  fi

  if [[ -z "$resolved" && -d "$FHIR_PUBLISH_DIR" ]]; then
    resolved="$(find "$FHIR_PUBLISH_DIR" -type f -name "$name" | LC_ALL=C sort | head -n1)"
  fi

  printf '%s\n' "$resolved"
}

OUTPUT_FILE="$(resolve_output_file "$TARGET_INPUT")"
PAGE_SLUG="$(basename "$TARGET_INPUT")"
PAGE_SLUG="${PAGE_SLUG%.html}"
PAGE_SLUG="${PAGE_SLUG%.htm}"
PAGE_SLUG="${PAGE_SLUG//[^A-Za-z0-9._-]/-}"
if [[ -z "$PAGE_SLUG" ]]; then
  PAGE_SLUG="unknown-target"
fi
REPORT_DIR="$REPORT_DIR/${PAGE_SLUG}.html"
mkdir -p "$REPORT_DIR"
REPORT_PATH="$REPORT_DIR/${PAGE_SLUG}-change-requests.md"
TECH_REPORT_PATH="$REPORT_DIR/${PAGE_SLUG}-technical-corrections.md"
CURRENT_DATE="$(date +%F)"

if [[ -z "$OUTPUT_FILE" || ! -f "$OUTPUT_FILE" ]]; then
  cat > "$REPORT_PATH" <<EOF
# Non-Technical FHIR Review Report

## Metadata
- Date: $CURRENT_DATE
- Mode: page
- Target input: $TARGET_INPUT
- Status: BLOCKED

## Build Evidence
- Build check command: ./.github/skills/build-fhir/scripts/build-if-needed.sh --repo ./fhir-repo --mode check
- Build check result: not-run (target resolution failed first)

## Blocking Issues
- Could not resolve target to a local page under fhir-repo/output or fhir-repo/publish.
EOF
  cat > "$TECH_REPORT_PATH" <<EOF
# Technical Corrections Review Report

## Metadata
- Date: $CURRENT_DATE
- Mode: page
- Target input: $TARGET_INPUT
- Status: BLOCKED

## Build Evidence
- Build check command: ./.github/skills/build-fhir/scripts/build-if-needed.sh --repo ./fhir-repo --mode check
- Build check result: not-run (target resolution failed first)

## Blocking Issues
- Could not resolve target to a local page under fhir-repo/output or fhir-repo/publish.
EOF
  echo "Report written: $REPORT_PATH"
  echo "Report written: $TECH_REPORT_PATH"
  exit 0
fi

OUTPUT_FILE="$(resolve_output_file "$TARGET_INPUT")"
PAGE_SLUG="$(basename "$TARGET_INPUT")"
PAGE_SLUG="${PAGE_SLUG%.html}"
PAGE_SLUG="${PAGE_SLUG%.htm}"
PAGE_SLUG="${PAGE_SLUG//[^A-Za-z0-9._-]/-}"
if [[ -z "$PAGE_SLUG" ]]; then
  PAGE_SLUG="unknown-target"
fi

REPORT_PATH="$REPORT_DIR/${PAGE_SLUG}-change-requests.md"
TECH_REPORT_PATH="$REPORT_DIR/${PAGE_SLUG}-technical-corrections.md"
CURRENT_DATE="$(date +%F)"

if [[ "$BUILD_RESULT" == BUILD_NEEDED:\ yes* ]]; then
  if ask_rebuild; then
    if ! "$BUILD_SCRIPT" --repo "$ROOT_DIR/fhir-repo" --mode build; then
      cat > "$REPORT_PATH" <<EOF
# Non-Technical FHIR Review Report

## Metadata
- Date: $CURRENT_DATE
- Mode: page
- Target input: $TARGET_INPUT
- Resolved output page: $OUTPUT_FILE
- Status: BLOCKED

## Build Evidence
- Build check command: ./.github/skills/build-fhir/scripts/build-if-needed.sh --repo ./fhir-repo --mode check
- Build check result: $BUILD_RESULT
- Rebuild attempt: failed

## Blocking Issues
- Rebuild was requested but did not complete successfully.
EOF
  cat > "$TECH_REPORT_PATH" <<EOF
# Technical Corrections Review Report

## Metadata
- Date: $CURRENT_DATE
- Mode: page
- Target input: $TARGET_INPUT
- Resolved output page: $OUTPUT_FILE
- Status: BLOCKED

## Build Evidence
- Build check command: ./.github/skills/build-fhir/scripts/build-if-needed.sh --repo ./fhir-repo --mode check
- Build check result: $BUILD_RESULT
- Rebuild attempt: failed

## Blocking Issues
- Rebuild was requested but did not complete successfully.
EOF
      echo "Report written: $REPORT_PATH"
  echo "Report written: $TECH_REPORT_PATH"
      exit 0
    fi
    BUILD_RESULT="$($BUILD_CHECK_SCRIPT --repo "$ROOT_DIR/fhir-repo" --mode check)"
  else
  cat > "$REPORT_PATH" <<EOF
# Non-Technical FHIR Review Report

## Metadata
- Date: $CURRENT_DATE
- Mode: page
- Target input: $TARGET_INPUT
- Status: BLOCKED

## Build Evidence
- Build check command: ./.github/skills/build-fhir/scripts/build-if-needed.sh --repo ./fhir-repo --mode check
- Build check result: $BUILD_RESULT

## Blocking Issues
- Local FHIR build output is stale or missing.
- Rebuild was declined. Run ./gradlew publish from fhir-repo, then rerun this review.
EOF
  cat > "$TECH_REPORT_PATH" <<EOF
# Technical Corrections Review Report

## Metadata
- Date: $CURRENT_DATE
- Mode: page
- Target input: $TARGET_INPUT
- Status: BLOCKED

## Build Evidence
- Build check command: ./.github/skills/build-fhir/scripts/build-if-needed.sh --repo ./fhir-repo --mode check
- Build check result: $BUILD_RESULT

## Blocking Issues
- Local FHIR build output is stale or missing.
- Rebuild was declined. Run ./gradlew publish from fhir-repo, then rerun this review.
EOF
  echo "Report written: $REPORT_PATH"
  echo "Report written: $TECH_REPORT_PATH"
  exit 0
  fi
fi

cat > "$REPORT_PATH" <<EOF
# Non-Technical FHIR Review Report

## Metadata
- Date: $CURRENT_DATE
- Mode: page
- Target input: $TARGET_INPUT
- Resolved output page: $OUTPUT_FILE
- Status: READY-FOR-RULE-AGENTS

## Build Evidence
- Build check command: ./.github/skills/build-fhir/scripts/build-if-needed.sh --repo ./fhir-repo --mode check
- Build check result: $BUILD_RESULT

## Inputs Used
- Output file:
  - $OUTPUT_FILE
- Source context files:
  - Resolve and record under fhir-repo/source/** during agent review.

## Agent Input Payload
- target_input: $TARGET_INPUT
- resolved_output_page: $OUTPUT_FILE
- source_context_hint: fhir-repo/source/**

## Rule 1 Findings: Normative Language on Informative Pages
- None yet.

## Rule 2 Findings: Normative Language in note/summary/comment Fields
- None yet.

## Rule 3 Findings: Regulatory Expressions vs Description
- None yet.

## Rule 4 Findings: FHIRPath Expressions vs Description
- None yet.

## Rule 5 Findings: Contradictions on Page
- None yet.

## Rule 6 Findings: subject Field Requires patient and/or subject Search Parameter
- None yet.

## Cross-Rule Synthesis
- None yet.

## Blocking Issues
- None.
EOF

cat > "$TECH_REPORT_PATH" <<EOF
# Technical Corrections Review Report

## Metadata
- Date: $CURRENT_DATE
- Mode: page
- Target input: $TARGET_INPUT
- Resolved output page: $OUTPUT_FILE
- Status: READY-FOR-TECHNICAL-CHECKS

## Build Evidence
- Build check command: ./.github/skills/build-fhir/scripts/build-if-needed.sh --repo ./fhir-repo --mode check
- Build check result: $BUILD_RESULT

## Inputs Used
- Source files:
  - Resolve and record under fhir-repo/source/** during technical review.
- Output files:
  - $OUTPUT_FILE

## Technical Findings: W3C Style (Sections 7.2, 7.3, 11, 13)
- None yet.

## Technical Findings: Link Target Validation
- None yet.

## Technical Findings: Link Description Alignment
- None yet.

## Technical Findings: Spelling
- None yet.

## Technical Findings: Other Technical Corrections
- None yet.

## Patch-Ready Changes
- None yet.

## Blocking Issues
- None.
EOF

echo "Report written: $REPORT_PATH"
echo "Report written: $TECH_REPORT_PATH"
