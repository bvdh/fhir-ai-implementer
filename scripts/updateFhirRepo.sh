#!/usr/bin/env bash

set -euo pipefail

FORK_REPO_SSH="git@github.com:bvdh/fhir-bvdh.git"
UPSTREAM_REPO_HTTPS="https://github.com/HL7/fhir.git"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
TARGET_DIR="$PROJECT_ROOT/fhir-fork"

echo "Ensuring FHIR fork exists at: $TARGET_DIR"

if [[ -d "$TARGET_DIR/.git" ]]; then
	echo "Repository already exists. Updating remotes and pulling latest changes..."

	git -C "$TARGET_DIR" remote set-url origin "$FORK_REPO_SSH"

	if git -C "$TARGET_DIR" remote get-url upstream >/dev/null 2>&1; then
		git -C "$TARGET_DIR" remote set-url upstream "$UPSTREAM_REPO_HTTPS"
	else
		git -C "$TARGET_DIR" remote add upstream "$UPSTREAM_REPO_HTTPS"
	fi

	git -C "$TARGET_DIR" fetch origin
	git -C "$TARGET_DIR" fetch upstream
	git -C "$TARGET_DIR" pull --ff-only
else
	if [[ -e "$TARGET_DIR" ]]; then
		echo "Error: $TARGET_DIR exists but is not a git repository."
		exit 1
	fi

	echo "Repository not found. Cloning into fhir-fork..."
	git clone "$FORK_REPO_SSH" "$TARGET_DIR"
	git -C "$TARGET_DIR" remote add upstream "$UPSTREAM_REPO_HTTPS"
fi

echo "Done."
