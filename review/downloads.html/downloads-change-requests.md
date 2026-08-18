# Non-Technical FHIR Review Report

## Metadata
- Date: 2026-08-17
- Mode: page
- Target input: downloads.html
- Status: BLOCKED

## Build Evidence
- Build check command: ./.github/skills/build-fhir/scripts/build-if-needed.sh --repo ./fhir-repo --mode check
- Build check result: BUILD_NEEDED: yes (source files changed since last build artifact)

## Blocking Issues
- Local FHIR build output is stale or missing.
- Rebuild was declined. Run ./gradlew publish from fhir-repo, then rerun this review.
