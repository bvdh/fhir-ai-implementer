---
name: build-fhir
description: 'Build FHIR spec only when needed. Use when checking whether fhir-repo has been built before, or when source files changed since the last successful build; runs ./gradlew publish only if required.'
argument-hint: 'Optional: repo path (default ./fhir-repo), mode (check|build), and force rebuild'
user-invocable: true
---

# Build FHIR If Needed

## What This Skill Does
This skill determines whether the FHIR spec needs rebuilding and runs a build only when required.

A build is required when either condition is true:
- no prior build artifacts exist under `publish/` or `output/`
- one or more files under `source/` are newer than the latest file in `publish/` or `output/`

## When To Use
- You want a quick answer: "Do I need to rebuild now?"
- You want to avoid unnecessary `./gradlew publish` runs
- You changed files under `fhir-repo/source/` and need a conditional build

## Inputs
- Repository path:
  - default: `./fhir-repo`
  - override: custom path to a FHIR repo
- Mode:
  - `check`: report whether a build is needed
  - `build`: run build only if needed
- Optional force flag:
  - force rebuild even if no changes are detected

## Procedure
1. Resolve repository root and verify required paths:
   - `<repo>/source/`
   - `<repo>/gradlew`
2. Infer last successful build timestamp from the newest artifact file in this order:
  - prefer `<repo>/publish/`
  - fallback to `<repo>/output/`
3. Decide build necessity:
  - If both `publish/` and `output/` have no files: build required.
  - Else: check for files under `source/` newer than the newest discovered artifact.
4. If mode is `check`, output one of:
   - `BUILD_NEEDED: yes (<reason>)`
   - `BUILD_NEEDED: no`
5. If mode is `build`:
   - If build needed (or forced), run `./gradlew publish` in repo root.
  - On success, rely on newly written `output/` file timestamps.
  - On failure, return non-zero.

## Script
Use [build-if-needed.sh](./scripts/build-if-needed.sh).

Examples:
- Check only:
  - `./.github/skills/build-fhir/scripts/build-if-needed.sh --repo ./fhir-repo --mode check`
- Build if needed:
  - `./.github/skills/build-fhir/scripts/build-if-needed.sh --repo ./fhir-repo --mode build`
- Force rebuild:
  - `./.github/skills/build-fhir/scripts/build-if-needed.sh --repo ./fhir-repo --mode build --force`

## Completion Criteria
- In `check` mode: clear needed/not-needed result with reason.
- In `build` mode:
  - build runs only when required unless `--force` is set
  - freshness is inferred from artifact timestamps (`publish/` preferred, `output/` fallback)
