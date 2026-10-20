# Implementation Change Log: FHIR-42961

## Summary

- Plan: jira/active/FHIR-42961/FHIR-42961-implementation-plan.md
- Ticket: jira/active/FHIR-42961/FHIR-42961.md
- Execution date: 2026-10-20

## Files Changed

- fhir-repo/source/bundle/bundle-notes.xml

## Changes Applied

1. Replaced the obsolete claim that Bundle currently includes a `signature` element with text that it was deprecated and subsequently removed.
2. Linked readers to the existing `Signing Bundles` guidance, which describes signing through Provenance resources.
3. Left the `signatures.html` ballot note and worked example unchanged, as they are excluded from this resolution.
4. Left `bundle.svg` unchanged; no reference to it was found in the Bundle publication page or source references, so it was not established as a live publication input.

## Validation Performed

- FHIR build (`./gradlew publish` via `build-if-needed.sh`): PASS; `BUILD SUCCESSFUL`.
- Published Bundle page contains the updated lifecycle text and `signatures.html#Bundles` link: PASS.
- Published Signatures page contains the `Bundles` anchor: PASS.
- Obsolete Bundle-signature assertion in the published Bundle page: PASS; no match.
- Bundle publication references to `bundle.svg`: PASS; no match.
- `fhir-repo` source diff scope and `git diff --check`: PASS; only `source/bundle/bundle-notes.xml` changed, with no whitespace errors.

## Plan Conformance

- Mapped hunks: 1/1
- `fhir-repo/source/bundle/bundle-notes.xml`: hunk replaces the stale current-state description and links to established Provenance guidance -> execution step 2 -> FHIR-42961 resolution text and approved FHIR-53722 removal.
- No SVG hunk: source and generated Bundle page searches found no publication reference to `bundle.svg`; the plan's conditional edit was not applicable.
- No `signatures.html` hunk: worked-example rework is explicitly excluded by the plan.

## Notes

- The intentional deprecation and subsequent removal were preserved; `Bundle.signature` was not restored and its cardinality was not changed.
- No edits were made outside `fhir-repo/source/` for specification implementation.
- No commit was created.
