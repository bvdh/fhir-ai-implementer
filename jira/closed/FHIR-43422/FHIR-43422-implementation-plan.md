# Implementation Plan: FHIR-43422

## Scope Summary
- Workgroup/source: direct ticket request (single ticket).
- Tickets in scope: FHIR-43422.
- Primary fix pattern: wording/typo corrections on ActorDefinition page narrative text.

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-43422 | Small typos on ActorDefinition resource page | Resolved - change required | Primary: `fhir-fork/source/actordefinition/actordefinition-introduction.xml`; Secondary (verify-only): `fhir-fork/source/actordefinition/structuredefinition-ActorDefinition.xml` | wording/typo correction | Resolution: Persuasive. Jira cites section 5.11.1/5.11.2 wording fixes (`is an actor`, `play`, `refer to`, `associated`, `ExampleScenario`). |

## Shared Implementation Approach
1. Treat ActorDefinition narrative XML as the source of truth for section text rendered on the ActorDefinition page.
2. Apply only literal typo/grammar corrections requested by the ticket; do not rewrite surrounding prose.
3. If the typo tokens are not present, classify as already-applied and capture evidence via targeted search/readback.

## Execution Steps
1. Open `fhir-fork/source/actordefinition/actordefinition-introduction.xml` and locate sentence blocks corresponding to section 5.11.1 (Scope and Usage) and section 5.11.2 content.
2. Apply the requested wording corrections where present:
   - `an actor that can plays the role` -> `an actor that can play the role`
   - `will refer the actors` -> `will refer to the actors`
   - `asociated` -> `associated`
   - `ExampleXcenario` -> `ExampleScenario`
3. If one or more source literals are not found in this file, perform a focused search in `fhir-fork/source/actordefinition/**` to locate alternate canonical source text locations before concluding no-op.
4. Verify related definitional text in `fhir-fork/source/actordefinition/structuredefinition-ActorDefinition.xml` for matching typo tokens and apply the same minimal corrections only if present.
5. Run targeted searches across `fhir-fork/source/actordefinition/**` to confirm typo tokens no longer exist in ActorDefinition content.
6. Read back localized context around each touched line (or the matched corrected lines in no-op case) to confirm no unrelated wording or formatting changes.

## Validation Checklist
- [ ] Ticket mapped to at least one canonical source file in `fhir-fork/source/`
- [ ] Planned edits are limited to requested typo/grammar fixes
- [ ] Search verifies typo tokens are absent after implementation (or documents already-applied state)
- [ ] No unrelated formatting, structural, or tooling changes
- [ ] Terminology remains aligned with ActorDefinition page intent
- [ ] Plan is review-ready and executable without reinterpretation

## Risks and Assumptions
- Risk: The cited typo strings may already be corrected in this branch, creating an expected no-op implementation.
- Assumption: ActorDefinition section prose is authored from `actordefinition-introduction.xml` and related `actordefinition/*` source files.
- Open questions: If all tokens are already corrected, should implementation record explicit no-op evidence in ticket artifacts or still produce a minimal verification-only commit?