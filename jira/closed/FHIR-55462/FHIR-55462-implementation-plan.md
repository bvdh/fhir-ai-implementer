# Implementation Plan: FHIR-55462

## Scope Summary
- Workgroup/source: FHIR Infrastructure; ticket file jira/active/FHIR-55462/FHIR-55462.md
- Tickets in scope: FHIR-55462
- Primary fix pattern: Update reference guidance so additional resources can be referenced using normal references when declared in StructureDefinition

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-55462 | Reference to additional resources should be normal references and not alternate reference | Resolved - change required (Resolution: Persuasive) | references.html#additional (source: fhir-fork/source/references.html around lines 315-329) | Normative/behavioral guidance clarification | Current text prescribes alternate-reference extension; resolution indicates normal references should be allowed when declared in additional-resource StructureDefinition |

## Shared Implementation Approach
1. Use the ticket resolution statement as the source of truth for intended behavior.
2. Update the Additional References subsection in `fhir-fork/source/references.html` with minimal textual changes.
3. Preserve version-transition guidance while removing strict dependence on alternate-reference for additional resources.

## Execution Steps
1. Open `fhir-fork/source/references.html` and navigate to the Additional References subsection around lines 315-329.
2. Update the sentence(s) that currently state alternate-reference is the solution for additional resources.
3. Add/adjust wording so references to additional resources can use normal `Reference.reference` when such targets are declared in the relevant additional-resource `StructureDefinition`.
4. Keep separate mention of alternate-reference only for cases where normal targets are still not permitted by constraints.
5. Ensure migration wording remains coherent when additional resources later become core resources.
6. Review nearby paragraphs for consistency in terminology (`additional resource`, `alternate-reference`, `Reference.reference`) without broad rewriting.

## Likely Impacted Files and Lines
- Primary edit target: `fhir-fork/source/references.html`
  - Additional resource target discussion: lines ~315-316
  - alternate-reference guidance block: lines ~320-323
  - migration note referencing `Reference.reference`: lines ~326-329
- Verification context only: `fhir-fork/source/resource/resource-introduction.xml` (cross-reference semantics only; no edit expected)

## Validation Checklist
- [ ] Ticket eligibility confirmed (`Resolution` present and `Status` = `Resolved - change required`)
- [ ] Updated references guidance explicitly allows normal references for additional resources when declared in StructureDefinition
- [ ] Alternate-reference guidance remains only where still appropriate
- [ ] Text remains internally consistent in `references.html#additional`
- [ ] Diff scope remains minimal and limited to planned section in `fhir-fork/source/references.html`
- [ ] No unrelated edits outside planned files

## Risks and Assumptions
- Risk: Existing references section may encode two distinct scenarios (future-version targets vs additional resources); over-merging them could reduce clarity.
- Risk: Changing normative wording could affect implementer interpretation and may require exact phrasing fidelity to work group decision record.
- Assumption: Ticket resolution intent is to relax requirement to use alternate-reference for additional resources when declared in StructureDefinition.
- Open questions:
  - Should the final text explicitly name both the extension and normal reference path, with a precedence rule?
  - Should this clarification also be echoed in search guidance or only in references section?
