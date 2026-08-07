#!/usr/bin/env bash

set -euo pipefail

FHIR_REPO_SSH="git@github.com:HL7/fhir.git"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
TARGET_DIR="$PROJECT_ROOT/fhir-repo"

echo "Ensuring FHIR repo exists at: $TARGET_DIR"

if [[ -d "$TARGET_DIR/.git" ]]; then
	echo "Repository already exists. Updating origin and pulling latest changes..."

	git -C "$TARGET_DIR" remote set-url origin "$FHIR_REPO_SSH"
	git -C "$TARGET_DIR" fetch origin
	git -C "$TARGET_DIR" pull --ff-only origin master
else
	if [[ -e "$TARGET_DIR" ]]; then
		echo "Error: $TARGET_DIR exists but is not a git repository."
		exit 1
	fi

	echo "Repository not found. Cloning into fhir-repo..."
	git clone "$FHIR_REPO_SSH" "$TARGET_DIR"
fi

echo "Done."
