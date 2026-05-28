# Implementation Plan: FHIR-47296

## Scope Summary
- Workgroup/source: currentTickets.md batch planning run (unimplemented tickets only).
- Tickets in scope: FHIR-47296.
- Primary fix pattern: wording/typo correction.

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-47296 | Invariant contains misspelled "SAHLL" | Resolved - change required | `fhir-fork/source/datatypes/sampleddata.xml` (primary), `fhir-fork/source/datatypes.html` (optional verification) | wording/typo correction | Resolution: Persuasive. Ticket text: "A SampledData SAHLL have either an interval and offsets but not both". |

## Shared Implementation Approach
1. Start from `fhir-fork/source/datatypes/sampleddata.xml` and locate the SampledData invariant row containing the typo token.
2. Apply the minimal correction (`SAHLL` -> `SHALL`) only if the typo is still present in the primary file.
3. Optionally verify rendered/reference context in `fhir-fork/source/datatypes.html` without editing it.
4. Keep changes traceable and avoid unrelated formatting or tooling changes.

## Execution Steps
1. Confirm concrete target files and locate candidate text:
	- `cd fhir-fork`
	- `rg -n "SampledData SAHLL|SampledData SHALL have either an interval and offsets but not both|interval and offsets but not both" source/datatypes/sampleddata.xml source/datatypes.html`
2. Primary execution path (if typo is found in primary file):
	- Edit only `source/datatypes/sampleddata.xml` to correct `SAHLL` to `SHALL`.
	- Keep wording, punctuation, and invariant meaning unchanged aside from the typo fix.
3. Optional secondary verification path (no edit):
	- `rg -n "SampledData SHALL have either an interval and offsets but not both" source/datatypes.html`
	- Use as a post-change visibility check only; do not edit `source/datatypes.html` in this ticket.
4. Already-applied fallback (if typo is not found):
	- Verify `source/datatypes/sampleddata.xml` contains the corrected `SHALL` form and no `SAHLL` token:
	- `rg -n "SAHLL|SampledData SHALL have either an interval and offsets but not both" source/datatypes/sampleddata.xml`
	- If `SAHLL` is absent and `SHALL` is present, mark ticket as already applied in current branch state (no-op implementation).
	- If neither form is found, run bounded discovery before deciding skip:
	- `rg -n "SampledData.*interval.*offsets|SAHLL" source/datatypes/ source/datatypes.html`

## Validation Checklist
- [ ] Ticket mapped to concrete target file: `fhir-fork/source/datatypes/sampleddata.xml` (primary)
- [ ] Optional verification file identified: `fhir-fork/source/datatypes.html`
- [ ] Planned edits stay within `fhir-fork/source/`
- [ ] No unrelated formatting/tooling/build changes
- [ ] Terminology and abbreviations are consistent with ticket intent
- [ ] Targeted typo detection check defined:
	- `rg -n "SampledData SAHLL|SampledData SHALL have either an interval and offsets but not both|interval and offsets but not both" source/datatypes/sampleddata.xml source/datatypes.html`
- [ ] Already-applied fallback is explicit and executable when typo is absent
- [ ] Plan is review-ready and implementation-specific

## Risks and Assumptions
- Risk: The invariant phrase may be transformed in generated pages, so the canonical edit location should remain the datatype source XML.
- Assumption: `source/datatypes/sampleddata.xml` is the authoritative source for this SampledData invariant text.
- Open questions: If `SAHLL` is absent and corrected text is already present, is documenting a no-op execution sufficient for ticket closure in this batch?
