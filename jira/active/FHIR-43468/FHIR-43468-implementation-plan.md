# Implementation Plan: FHIR-43468

## Scope Summary
- Ticket: FHIR-43468
- Summary: Typo in Scope
- Status: Resolved - change required
- Resolution: Persuasive
- Planning scope: Define the minimal specification edit needed to correct the Scope sentence for ActorDefinition.
- Implementation boundary: Limit edits to `fhir-fork/source/` during execution.

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-43468 | Typo in Scope | Resolved - change required | `fhir-fork/source/actordefinition/actordefinition-introduction.xml` (Scope and Usage paragraph) | Typographical wording correction | Correct the ActorDefinition scope sentence per ticket intent by inserting the missing linking verb (`is`) in the affected sentence if still present in current source text. |

## Shared Implementation Approach
1. Locate the ActorDefinition Scope and Usage sentence in `fhir-fork/source/actordefinition/actordefinition-introduction.xml`.
2. Apply the smallest possible wording edit that resolves the ticket-reported typo.
3. Keep surrounding narrative unchanged and avoid style rewrites unrelated to the typo.

## Execution Steps
1. Open `fhir-fork/source/actordefinition/actordefinition-introduction.xml`.
2. In the Scope and Usage section, identify the sentence corresponding to the ticket text (the sentence beginning with "The ActorDefinition Resource ...").
3. If the sentence still lacks the linking verb after "Resource", insert `is` so the sentence is grammatically complete while preserving the approved wording pattern.
4. Do not modify other sentences or list items in the section.
5. Run a focused search in `fhir-fork/source/actordefinition/` for `The ActorDefinition Resource an actor` to verify the typo form is not present after the edit.
6. Confirm the corrected sentence remains present in the Scope and Usage paragraph.

## Validation Checklist
- [ ] The plan maps FHIR-43468 to at least one concrete file in `fhir-fork/source/`.
- [ ] Planned edit scope is restricted to `fhir-fork/source/actordefinition/actordefinition-introduction.xml`.
- [ ] Planned change is minimal and limited to typo correction in the targeted sentence.
- [ ] No unrelated formatting/tooling/build/spec-structure changes are included.
- [ ] Post-edit search confirms the typo phrase is absent in the target folder.
- [ ] Scope and Usage sentence remains coherent after correction.

## Risks and Assumptions
- Risk: Source wording may already differ from the Jira quote due to upstream drift, making exact phrase matching fail.
- Assumption: Ticket intent is to correct the missing linking verb in the ActorDefinition Scope sentence, not to perform broader prose cleanup.
- Open question: If the sentence is already corrected in current source, should execution record FHIR-43468 as already satisfied with no content change?