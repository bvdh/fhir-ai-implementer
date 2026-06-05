# Implementation Plan: FHIR-54058

## Scope Summary
- Workgroup/source: Direct ticket scope (FHIR-54058)
- Tickets in scope: FHIR-54058
- Primary fix pattern: Timing example table correction and augmentation (add endOffset example, correct startOffset-related every-second-day example semantics)

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-54058 | Update Timing example table for start/endOffset | Resolved - change required | datatypes (Timing section 2.1.30.17) | Wording/example-table structural correction | Primary edit surface: fhir-fork/source/datatypes.html around the Timing example table at current rows near lines 1667-1687, especially rows near lines 1674-1675 and nearby explanatory paragraph around lines 1689-1692. |

## Shared Implementation Approach
1. Locate the Timing criteria example table under fhir-fork/source.
2. Adjust only the minimal rows/cells needed to represent intended semantics for every-second-day examples.
3. Add one explicit endOffset-based example row and keep style consistent with existing table conventions.
4. Keep all edits constrained to fhir-fork/source and preserve surrounding formatting patterns.

## Execution Steps
1. Confirm baseline ticket intent from jira/active/FHIR-54058/FHIR-54058.md and preserve exact scope:
   - Add an endOffset example in the Timing criteria table.
   - Correct the current startOffset-related example so it does not read as every day.
2. Edit primary table in fhir-fork/source/datatypes.html:
   - Locate header row with startOffset column near line 1667.
   - Locate example rows:
     - Every second day (near line 1674)
     - Every second day starting on Day 2 (near line 1675)
   - Update values so the examples clearly communicate alternating-day behavior and the startOffset use case.
3. Insert a new example row for endOffset in the same table region (between related rows if possible) with values that demonstrate endOffset distinctly from startOffset.
4. Verify local consistency with immediately following explanatory text in fhir-fork/source/datatypes.html around lines 1689-1692 that references startOffset and endOffset.
5. Run a focused review pass for table integrity:
   - Column alignment remains intact.
   - No accidental changes outside the target table and immediate explanatory paragraph.
6. Optionally generate/publish docs to visually inspect rendered table behavior if needed for confidence (only after source edit step, not during planning).

## Validation Checklist
- [ ] FHIR-54058 is mapped to at least one concrete edit surface under fhir-fork/source.
- [ ] Planned source edits remain within fhir-fork/source only.
- [ ] Timing example table in fhir-fork/source/datatypes.html includes at least one explicit endOffset example.
- [ ] Corrected startOffset example no longer implies every-day behavior when describing every-second-day intent.
- [ ] Table structure remains valid with no broken columns/rows.
- [ ] Adjacent explanatory text for offset vs startOffset/endOffset remains consistent with updated examples.
- [ ] No unrelated formatting, tooling, or non-ticket content changes are introduced.

## Risks and Assumptions
- Risk: Table-cell semantics for alternating schedules can still be interpreted ambiguously if period/frequency/startOffset/endOffset combinations are not internally consistent.
- Risk: Minor HTML table formatting mistakes (extra/missing cell delimiters) can shift columns and distort rendered examples.
- Assumption: fhir-fork/source/datatypes.html is the canonical source location for Timing example table updates for this ticket.
- Assumption: No parallel update is required in other source pages for this ticket unless discovered during implementation validation.
- Open questions: Should the new endOffset example use a symmetric offset window (for example startOffset plus endOffset) or an endOffset-only scenario to maximize clarity for readers?
