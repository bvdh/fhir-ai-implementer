# Implementation Plan: FHIR-33050

## Scope Summary
- Workgroup/source: currentTickets.md batch planning run (unimplemented tickets only).
- Tickets in scope: FHIR-33050.
- Primary fix pattern: terminology/code-list technical correction for FHIRVersion.

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-33050 | FHIRVersion value set is missing codes | Published | `fhir-fork/source/capabilitystatement/codesystem-FHIR-version.xml` (primary), `fhir-fork/source/terminologies/bindings.xml` (secondary verification) | technical correction | Resolution: Persuasive. Jira grouping R4B indicates expected focus on R4B-era version codes. |

## Concrete Target File Mapping
- Primary edit file:
	- `fhir-fork/source/capabilitystatement/codesystem-FHIR-version.xml`
	- Reason: authoritative source for CodeSystem `FHIR-version`, includes canonical concept list backing `ValueSet/FHIR-version`.
- Secondary verification files:
	- `fhir-fork/source/terminologies/bindings.xml`
	- Reason: contains `FHIRVersion` binding row (`#FHIR-version`) and the `FHIR-version` worksheet where code rows should remain aligned with the code system content.

## Shared Implementation Approach
1. Start with the canonical FHIRVersion code list in the primary file and confirm whether ticket-expected missing code(s) are absent.
2. Add only missing concept entries (and required parent/child structure) in the primary file.
3. Verify `bindings.xml` consistency for `FHIRVersion` references and worksheet rows, updating only if mismatch is found.
4. Keep diff minimal and confined to terminology content related to this ticket.

## Execution Steps
1. Open `fhir-fork/source/capabilitystatement/codesystem-FHIR-version.xml` and inspect existing `<concept>` entries for R4B-era versions (at minimum check for `4.3` and `4.3.0`, which are typical candidates for this ticket).
2. If a required code is missing, insert the missing concept in the correct hierarchy:
	 - Parent concept pattern: major/minor release node (example: `4.3`).
	 - Child concept pattern: concrete release node (example: `4.3.0`) nested under parent.
3. Preserve ordering with neighboring version concepts (do not reorder unrelated historical codes).
4. Open `fhir-fork/source/terminologies/bindings.xml` and verify both:
	 - The `FHIRVersion` binding row references `#FHIR-version`.
	 - The `FHIR-version` worksheet includes corresponding code rows for any newly added concepts.
5. Only if a mismatch exists, apply minimal alignment edits in `bindings.xml` for the affected code rows; otherwise leave file unchanged.
6. Re-read edited regions to confirm XML structure integrity and consistent code/display/definition formatting.

## Validation Checklist
- [ ] Primary target file confirmed: `fhir-fork/source/capabilitystatement/codesystem-FHIR-version.xml`
- [ ] Secondary verification file confirmed: `fhir-fork/source/terminologies/bindings.xml`
- [ ] Search check passes for expected ticket codes in primary file (for example: `rg '<code value="4.3"|<code value="4.3.0"' fhir-fork/source/capabilitystatement/codesystem-FHIR-version.xml`)
- [ ] If codes were added, corresponding `bindings.xml` worksheet rows are present/updated and consistent
- [ ] No file changes outside `fhir-fork/source/` and no unrelated formatting/tooling/build edits
- [ ] Final diff is limited to FHIRVersion value set/code system content relevant to FHIR-33050

## Risks and Assumptions
- Risk: Ticket summary does not enumerate exact missing codes; implementer must confirm missing set from R4B historical context before editing.
- Assumption: `codesystem-FHIR-version.xml` remains the canonical editable source for this value set content in this branch.
- Open questions: If all candidate codes are already present (no-op), should ticket execution record a "verified already resolved upstream" note instead of applying edits?
