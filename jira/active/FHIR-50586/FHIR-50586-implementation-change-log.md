# Implementation Change Log: FHIR-50586

## Summary
- Plan: jira/active/FHIR-50586/FHIR-50586-implementation-plan.md
- Ticket: jira/active/FHIR-50586/FHIR-50586.md
- Execution date: 2026-07-13

## Files Changed
- fhir-fork/source/datatypes.html
- jira/active/FHIR-50586/FHIR-50586-commit-message-fhir-fork.txt
- jira/active/FHIR-50586/FHIR-50586-commit-message-outer.txt
- jira/active/FHIR-50586/FHIR-50586-implementation-change-log.md

## Changes Applied
1. Moved ticket execution workspace from `jira/open/FHIR-50586` to `jira/active/FHIR-50586` per user choice for execute-plan artifact conventions.
2. Inserted a RelativeTime constraints block in `fhir-fork/source/datatypes.html` immediately after `[%dt RelativeTime 14%]`:
   - `<div class="use">`
   - `<p><b>Constraints</b></p>`
   - `[%dt.constraints RelativeTime%]`
   - `</div>`
3. Kept source edits limited to one planned hunk and preserved surrounding narrative.

## Validation Performed
- Execution gate (`Status: Resolved - change required`, `Resolution: Persuasive`): PASS
- RelativeTime constraints macro present (`[%dt.constraints RelativeTime%]`): PASS
- SampledData + RelativeTime constraints macro parity check: PASS
- fhir-fork scoped status check (`source/datatypes.html` only): PASS
- Source diff hunk count vs plan intent (single insertion hunk): PASS

## Plan Conformance
- Mapped hunks: 1/1 (source)
- source/datatypes.html:1787 -> Plan `Detailed Execution Steps` step 3 -> Evidence source: ticket `Resolution Description` (SampledData fixed, RelativeTime still broken) and selected Disposition A in resolution file

## Notes
- Owning source repository: `fhir-fork`; allowed path boundary respected (`fhir-fork/source/` only).
- No `fhir-extensions-fork` edits were needed.
- No new reusable multi-ticket editing pattern requiring instruction updates was identified in this one-hunk rendering fix.
