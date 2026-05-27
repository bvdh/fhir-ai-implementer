# Implementation Plan: FHIR-44486

## Scope Summary
- Workgroup/source: Direct ticket input from jira/active/FHIR-44486/FHIR-44486.md
- Tickets in scope: FHIR-44486
- Primary fix pattern: Spelling correction (editorial technical correction)
- Ticket status: Resolved - change required (Persuasive)

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-44486 | Correct spelling procss | Resolved - change required | fhir-fork/source/examplescenario/structuredefinition-ExampleScenario.xml (short label text) | Typo/spelling correction | Replace "procss" with "process" only; no semantic changes |

## Target File Mapping
| Ticket | Role | File | Target pattern | Planned replacement |
|---|---|---|---|---|
| FHIR-44486 | Primary source file | fhir-fork/source/examplescenario/structuredefinition-ExampleScenario.xml | `<short value="Label for procss"/>` | `<short value="Label for process"/>` |

Target selection rule for implementation:
- Apply the edit only to the first exact match of `Label for procss` within the mapped primary source file above.
- Do not expand scope to other files for this ticket unless a new issue is raised.

## Shared Implementation Approach
1. Use explicit target-file mapping as authoritative scope.
2. Perform one exact string replacement in the mapped primary source file: `Label for procss` -> `Label for process`.
3. Preserve XML shape and semantics (element name, attributes, and surrounding structure unchanged).
4. Keep all implementation edits strictly within fhir-fork/source/.

## Execution Steps
1. Confirm ticket details in jira/active/FHIR-44486/FHIR-44486.md.
2. Verify the exact target pattern exists in the mapped primary file:
   - `rg -n 'Label for procss' fhir-fork/source/examplescenario/structuredefinition-ExampleScenario.xml`
3. Confirm there is exactly one intended in-file match before editing:
   - `rg -n 'Label for procss' fhir-fork/source/examplescenario/structuredefinition-ExampleScenario.xml | wc -l`
   - Expected result: `1`
4. Edit fhir-fork/source/examplescenario/structuredefinition-ExampleScenario.xml:
   - Before: <short value="Label for procss"/>
   - After: <short value="Label for process"/>
5. Post-edit validation in mapped file:
   - `rg -n 'Label for procss|Label for process' fhir-fork/source/examplescenario/structuredefinition-ExampleScenario.xml`
   - Expected: no `Label for procss`, one `Label for process`
6. Optional cross-source safety check to confirm no remaining typo in source tree:
   - `rg -n 'procss' fhir-fork/source/`
7. Review diff scope and cardinality:
   - `git diff -- fhir-fork/source/examplescenario/structuredefinition-ExampleScenario.xml`
   - Expected: one-line editorial change only.
8. Commit with ticket key in the title once approved for implementation.

## Validation Checklist
- [ ] Ticket FHIR-44486 is represented in the plan and mapped to a concrete source file
- [ ] Primary target file is explicitly defined in a target mapping table
- [ ] Exact target pattern to replace is explicitly defined
- [ ] Planned edits stay within fhir-fork/source/
- [ ] Only editorial typo correction is included
- [ ] No structural/semantic/resource-model changes are introduced
- [ ] Validation commands and expected outcomes are specified
- [ ] Search validation confirms typo is corrected in targeted source
- [ ] Plan is ready for workgroup review and implementation

## Risks and Assumptions
- Risk: Very low; accidental edits to generated/structured XML context could expand scope if not carefully reviewed.
- Assumption: The ticket typo refers to the exact mapped pattern `<short value="Label for procss"/>` in ExampleScenario.
- Open questions: None currently; if additional occurrences are identified later, handle in separately scoped updates.

## Acceptance Criteria
- The ExampleScenario short label reads: <short value="Label for process"/>.
- The commit contains only the intended editorial correction for FHIR-44486.
- No files outside fhir-fork/source/ are modified for implementation.
