# Implementation Plan: FHIR-44496

## Scope Summary
- Ticket: FHIR-44496
- Summary: Add missing "of"
- Status: Resolved - change required
- Resolution: Persuasive
- Planning scope: Define the minimal specification wording correction for the ExampleScenario process title definition.
- Implementation boundary: Limit edits to fhir-fork/source/ during execution.

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-44496 | Add missing "of" | Resolved - change required | fhir-fork/source/examplescenario/structuredefinition-ExampleScenario.xml (ExampleScenario.process.title definition text) | Wording correction (missing preposition) | Update sentence from "A short descriptive label the process to be used in tables or diagrams." to "A short descriptive label of the process to be used in tables or diagrams." |

## Shared Implementation Approach
1. Locate the ExampleScenario process title definition in the canonical structure definition source.
2. Apply the smallest possible text edit by inserting the missing word "of" after "label".
3. Keep all other wording, punctuation, and formatting unchanged.

## Execution Steps
1. Open fhir-fork/source/examplescenario/structuredefinition-ExampleScenario.xml.
2. Find the definition string for ExampleScenario.process.title currently reading: "A short descriptive label the process to be used in tables or diagrams."
3. Update only this sentence to: "A short descriptive label of the process to be used in tables or diagrams."
4. Confirm no adjacent metadata, cardinality, or constraints were changed.
5. Run a focused search in fhir-fork/source/ for the exact old sentence to verify the incorrect wording is removed from the canonical source text.
6. If generated artifacts are refreshed during normal publication workflow, verify they reflect the corrected wording; do not manually broaden edits beyond ticket intent.

## Validation Checklist
- [ ] The plan maps FHIR-44496 to a concrete file in fhir-fork/source/.
- [ ] Planned edit is restricted to fhir-fork/source/examplescenario/structuredefinition-ExampleScenario.xml.
- [ ] Edit scope is minimal (single-word insertion: "of").
- [ ] No unrelated formatting/tooling/build changes are included.
- [ ] Post-edit search confirms the incorrect sentence is no longer present in canonical source content.
- [ ] Corrected sentence appears exactly as approved by ticket intent.

## Risks and Assumptions
- Risk: Automated formatting or broad replacement could alter nearby narrative text unintentionally.
- Assumption: Ticket intent is limited to inserting the missing word "of" and does not require additional stylistic rewrites.
- Open question: Whether downstream generated SVG/HTML artifacts should be committed in the same implementation change depends on the repository's normal publication/update practice.