# Implementation Plan: FHIR-47049

## Scope Summary
- Workgroup/source: currentTickets.md batch planning run (unimplemented tickets only).
- Tickets in scope: FHIR-47049.
- Primary fix pattern: technical correction.

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-47049 | version management paragraph mentions R5 FMM processes | Applied | `fhir-fork/source/versions.html` (primary), `fhir-fork/source/versioning.html` (fallback check) | technical correction | Resolution: Persuasive. Remove/adapt legacy R5-only FMM implementation note in Version Management Policy content. |

## Shared Implementation Approach
1. Start from `fhir-fork/source/versions.html` (Version Management Policy page) and verify whether the quoted R5-only FMM note still exists.
2. If present, apply minimal text correction/removal aligned with ticket intent and terminology conventions.
3. Keep changes traceable and avoid unrelated formatting or tooling changes.

## Execution Steps
1. Confirm target files and section anchors:
	- `cd fhir-fork`
	- `rg -n "Version Management Policy|The FHIR Maturity Model" source/versions.html source/versioning.html`
2. Detect the exact legacy paragraph from the ticket text:
	- `rg -n "For this release \(R5\), please note|rules for FMM levels will be reviewed|internal process requirements|Once review is complete, FMM levels will be reflected in the CI-build" source/versions.html source/versioning.html`
3. Primary execution path (if matches are found):
	- Edit only `source/versions.html` to remove or adapt the R5-specific implementation note for R6 context.
	- Keep surrounding FMM rules and policy statements intact.
4. Already-applied fallback (if no matches are found):
	- Treat ticket as already implemented in current branch state.
	- Record in execution notes that targeted legacy strings are absent from `source/versions.html` and `source/versioning.html`.
5. Localized readback check (planned post-edit verification):
	- `rg -n "FMM 1|FMM 2|FMM 3|FMM 4|FMM 5|FMM 6" source/versions.html`
	- Confirm only intended paragraph changed and maturity-level definitions remain coherent.

## Validation Checklist
- [ ] Ticket mapped to concrete source files: `fhir-fork/source/versions.html` (primary) and `fhir-fork/source/versioning.html` (fallback check)
- [ ] Planned edits stay within `fhir-fork/source/`
- [ ] No unrelated formatting/tooling/build changes
- [ ] Terminology and abbreviations are consistent with ticket intent
- [ ] Legacy R5-only note check executed:
	- `rg -n "For this release \(R5\), please note|rules for FMM levels will be reviewed|internal process requirements|Once review is complete, FMM levels will be reflected in the CI-build" source/versions.html source/versioning.html`
- [ ] Already-applied fallback handled when grep returns no matches (documented as no-op implementation)
- [ ] Plan is review-ready and implementation-specific

## Risks and Assumptions
- Risk: Similar R5 wording may appear in other historical/context sections and be mistaken for the ticket target.
- Assumption: The intended correction scope is the Version Management Policy maturity/implementation-note paragraph only.
- Open questions: If the exact quoted text is already absent, should this ticket be closed as already applied based on grep evidence alone?
