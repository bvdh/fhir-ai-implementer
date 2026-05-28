# Implementation Plan: FHIR-43804

## Scope Summary
- Workgroup/source: direct ticket planning request (single ticket).
- Tickets in scope: FHIR-43804.
- Primary fix pattern: wording/typo correction.

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-43804 | Typo | Resolved - change required | Primary: `fhir-fork/source/actordefinition/actordefinition-introduction.xml`; Secondary (verify-only): `fhir-fork/source/actordefinition/**` | wording/typo correction | Resolution: Persuasive. Correct `ExampleXcenario` back to canonical `ExampleScenario` in ActorDefinition narrative context. |

## Shared Implementation Approach
1. Use ActorDefinition narrative source as the authoritative edit surface for this ticket.
2. Apply only the literal typo correction requested by the ticket; do not refactor surrounding prose.
3. Keep all implementation edits constrained to `fhir-fork/source/` and avoid unrelated formatting or tooling changes.

## Target File Mapping
- Primary target: `fhir-fork/source/actordefinition/actordefinition-introduction.xml`
- Secondary target scope (verification-only unless match found): `fhir-fork/source/actordefinition/**`
- Mapping rationale: multiple related Jira tickets cite the same ActorDefinition sentence fragment (`Actors may also be referenced from ExampleXcenario.`), which maps to ActorDefinition narrative content.

## Execution Steps
1. Confirm the primary file exists and gather focused context.
   - `test -f fhir-fork/source/actordefinition/actordefinition-introduction.xml`
   - `rg -n "Actors may also be referenced from|ExampleXcenario|ExampleScenario|Boundaries and Relationships" fhir-fork/source/actordefinition/actordefinition-introduction.xml`
2. Locate exact typo occurrences in ActorDefinition source scope.
   - `rg -n "ExampleXcenario" fhir-fork/source/actordefinition/**`
3. Primary execution path (if typo is found):
   - Edit only matched file(s) in `fhir-fork/source/actordefinition/**`.
   - Replace each `ExampleXcenario` token with `ExampleScenario`.
   - Preserve markup, links, punctuation, and neighboring sentence structure.
4. Already-applied fallback (if typo is not found):
   - Treat ticket as already implemented in current branch state.
   - Capture no-op evidence by recording the zero-match search and nearby ActorDefinition context confirming canonical wording is already present.
5. Post-edit/no-op verification:
   - `rg -n "ExampleXcenario|ExampleScenario" fhir-fork/source/actordefinition/**`
   - `git -C fhir-fork diff -- source/actordefinition`

## Validation Checklist
- [ ] Ticket mapped to a concrete source location under `fhir-fork/source/`
- [ ] Planned edits remain limited to ActorDefinition typo correction scope
- [ ] No unrelated formatting, tooling, or non-ticket wording changes
- [ ] Validation search confirms no `ExampleXcenario` remains in mapped scope
- [ ] Canonical resource naming remains `ExampleScenario`
- [ ] Already-applied fallback is handled and documented when no match exists
- [ ] Plan is implementation-ready without reinterpretation

## Risks and Assumptions
- Risk: The typo may already be fixed in current source, yielding a verification-only/no-op implementation.
- Assumption: Ticket intent is limited to replacing the specific typo token and does not require broader ActorDefinition prose revision.
- Open questions: If no source occurrence exists in ActorDefinition files, should execution produce a no-op documentation commit or close with verification evidence only?