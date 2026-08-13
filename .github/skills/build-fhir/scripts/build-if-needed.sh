#!/usr/bin/env bash
set -euo pipefail

REPO="./fhir-repo"
MODE="build"
FORCE=0

usage() {
  cat <<'EOF'
Usage: build-if-needed.sh [--repo <path>] [--mode check|build] [--force]

Options:
  --repo   Path to the FHIR repo (default: ./fhir-repo)
  --mode   check = report only; build = run ./gradlew publish when needed
  --force  Force a rebuild in build mode
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --repo)
      REPO="$2"
      shift 2
      ;;
    --mode)
      MODE="$2"
      shift 2
      ;;
    --force)
      FORCE=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage
      exit 2
      ;;
  esac
done

if [[ "$MODE" != "check" && "$MODE" != "build" ]]; then
  echo "Invalid --mode: $MODE (expected check|build)" >&2
  exit 2
fi

REPO_ABS="$(cd "$REPO" && pwd)"
SOURCE_DIR="$REPO_ABS/source"
GRADLEW="$REPO_ABS/gradlew"
ARTIFACT_CANDIDATES=("$REPO_ABS/publish" "$REPO_ABS/output")

if [[ ! -d "$SOURCE_DIR" ]]; then
  echo "Missing source directory: $SOURCE_DIR" >&2
  exit 2
fi

if [[ ! -x "$GRADLEW" ]]; then
  echo "Missing executable gradlew: $GRADLEW" >&2
  exit 2
fi

NEED_BUILD=0
REASON=""
NEWEST_BUILD_FILE=""
FRESHNESS_ARTIFACT_DIR=""

for artifact_dir in "${ARTIFACT_CANDIDATES[@]}"; do
  [[ -d "$artifact_dir" ]] || continue

  newest_line="$(find "$artifact_dir" -type f -printf '%T@ %p\n' | sort -nr | head -n1 || true)"
  [[ -n "$newest_line" ]] || continue

  candidate_file="${newest_line#* }"
  if [[ -z "$NEWEST_BUILD_FILE" || "$candidate_file" -nt "$NEWEST_BUILD_FILE" ]]; then
    NEWEST_BUILD_FILE="$candidate_file"
    FRESHNESS_ARTIFACT_DIR="$artifact_dir"
  fi
done

if [[ "$FORCE" -eq 1 ]]; then
  NEED_BUILD=1
  REASON="forced"
elif [[ -z "$NEWEST_BUILD_FILE" ]]; then
  NEED_BUILD=1
  REASON="no build artifacts found in publish/ or output/"
else
  if find "$SOURCE_DIR" -type f -newer "$NEWEST_BUILD_FILE" -print -quit | grep -q .; then
    NEED_BUILD=1
    REASON="source files changed since last build artifact"
  fi
fi

if [[ "$MODE" == "check" ]]; then
  if [[ "$NEED_BUILD" -eq 1 ]]; then
    echo "BUILD_NEEDED: yes ($REASON)"
  else
    echo "BUILD_NEEDED: no"
  fi
  exit 0
fi

if [[ "$NEED_BUILD" -eq 0 ]]; then
  echo "BUILD_NEEDED: no"
  echo "Skipping build."
  exit 0
fi

echo "BUILD_NEEDED: yes ($REASON)"
echo "Running build: ./gradlew publish"
(
  cd "$REPO_ABS"
  ./gradlew publish
)

echo "Build completed. Freshness is inferred from $FRESHNESS_ARTIFACT_DIR timestamps."
