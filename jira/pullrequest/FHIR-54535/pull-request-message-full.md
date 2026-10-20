## Scope
Clarify DocumentReference `_content` search behavior according to the approved resolution for [FHIR-54535](https://jira.hl7.org/browse/FHIR-54535).

## Tickets Addressed
- [FHIR-54535](https://jira.hl7.org/browse/FHIR-54535)

## Per-Ticket Change Summary
- [FHIR-54535](https://jira.hl7.org/browse/FHIR-54535): Make searching decoded attachment data optional using MAY and remove the requirement to search attachment URLs.

## Notes on Overlaps
- No overlapping ticket implementations; this PR addresses one ticket.

## Commit Coverage Check
- Branch: `FHIR-54535`; base: `origin/master`.
- [FHIR-54535](https://jira.hl7.org/browse/FHIR-54535): Covered by `26e383455a6659d1763bb8446dca0a73fdfdc470` (FHIR core source commit).
- Coverage: PASS, 1/1 tickets; no additional ticket commits in the branch range.

## Validation Notes
- [FHIR-54535](https://jira.hl7.org/browse/FHIR-54535): Ticket, approved plan, implementation change log, and source commit message are present.
- FHIR specification build: `BUILD SUCCESSFUL in 11m 9s`.
- The build reported a branch-specific terminology cache HTTP 404 but completed successfully.
- Source change is limited to `source/documentreference/documentreference-notes.xml`.
- Staged source-boundary validation and CRLF-aware whitespace check passed before committing.
- The pre-existing `.project` modification was excluded from the commit with explicit user approval.
