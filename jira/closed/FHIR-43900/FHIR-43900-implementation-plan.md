# Implementation Plan: FHIR-43900

## Scope Summary
- Workgroup/source: direct ticket planning request.
- Tickets in scope: FHIR-43900.
- Primary fix pattern: wording/typo correction.

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-43900 | ActorDefinition typo | Resolved - change required | `fhir-fork/source/actordefinition/actordefinition-introduction.xml` | wording/typo correction | Resolution: Persuasive. Correct typo `ExampleXcenario` to canonical `ExampleScenario` in ActorDefinition narrative text. |

## Shared Implementation Approach
1. Use the ActorDefinition narrative source as the single source of truth for this correction.
2. Apply only the minimal text correction needed for the typo while preserving sentence meaning and surrounding structure.
3. Keep all edits within `fhir-fork/source/` and avoid unrelated formatting/tooling changes.

## Target File Mapping
- Primary target: `fhir-fork/source/actordefinition/actordefinition-introduction.xml`
- Mapping rationale: this file carries the ActorDefinition narrative where references to ExampleScenario are maintained.

## Execution Steps
1. Confirm target file exists and identify relevant context:
	- `test -f fhir-fork/source/actordefinition/actordefinition-introduction.xml`
	- `rg -n "Scope and Usage|Boundaries and Relationships|ActorDefinitions can be referenced|ExampleXcenario|ExampleScenario|ExampleScenarios" fhir-fork/source/actordefinition/actordefinition-introduction.xml`
2. Locate the exact typo instance from the ticket text:
	- `rg -n "ExampleXcenario|Actors may also be referenced from" fhir-fork/source/actordefinition/actordefinition-introduction.xml`
3. Primary execution path (if typo is found):
	- Edit only `source/actordefinition/actordefinition-introduction.xml` and replace `ExampleXcenario` with `ExampleScenario`.
	- Preserve neighboring narrative text, links, and markup.
4. Already-applied fallback (if typo is not found):
	- Treat ticket as already implemented in the current branch state.
	- Document that `ExampleXcenario` and the quoted sentence fragment are absent from the mapped source file.
5. Localized readback and diff check after any edit:
	- `rg -n "ExampleXcenario|ExampleScenario|ExampleScenarios" fhir-fork/source/actordefinition/actordefinition-introduction.xml`
	- `git -C fhir-fork diff -- source/actordefinition/actordefinition-introduction.xml`

## Validation Checklist
- [ ] Ticket mapped to a concrete source file in `fhir-fork/source/`
- [ ] Planned edits constrained to `fhir-fork/source/actordefinition/actordefinition-introduction.xml`
- [ ] No unrelated formatting/tooling/build changes
- [ ] Canonical resource naming is preserved where resource name references are intended (`ExampleScenario`)
- [ ] Validation search shows no remaining `ExampleXcenario` in mapped files
- [ ] Already-applied fallback handled and documented if no target typo exists
- [ ] Plan is review-ready and implementation-specific

## Risks and Assumptions
- Risk: The typo may already be corrected in current source, resulting in a no-op implementation path.
- Assumption: The intended correction scope is limited to ActorDefinition narrative text and does not require broader terminology normalization.
- Open questions: If no typo instance exists in source, should the ticket be marked as already applied without additional edits?