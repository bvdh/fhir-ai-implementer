# Implementation Plan: FHIR-44470

## Scope Summary
- Ticket: FHIR-44470
- Summary: Add more missing words in introduction
- Status: Resolved - change required
- Resolution: Persuasive
- Planning scope: Define the minimal specification text correction for the ActorDefinition introduction wording issue.
- Implementation boundary: Limit edits to `fhir-fork/source/` during execution.

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-44470 | Add more missing words in introduction | Resolved - change required | `fhir-fork/source/actordefinition/actordefinition-introduction.xml` (ActorDefinition introduction/scope text rendered on actordefinition page) | Missing-word grammar correction | Insert missing word `to` in the sentence pattern "...will refer the actors..." so it reads "...will refer to the actors...". |

## Shared Implementation Approach
1. Locate the exact ActorDefinition introduction sentence referenced by the ticket in `fhir-fork/source/actordefinition/actordefinition-introduction.xml`.
2. Apply the smallest possible wording change by inserting only the missing preposition (`to`) in the targeted sentence.
3. Avoid unrelated copy-editing in surrounding introduction text unless separately authorized.

## Execution Steps
1. Open `fhir-fork/source/actordefinition/actordefinition-introduction.xml`.
2. Search for the ticket-referenced sentence fragment around "other business process languages" and/or "will refer ... the actors".
3. Update only the missing-word defect so the phrase becomes "will refer to the actors".
4. If the exact legacy sentence has already shifted wording, locate the equivalent semantic sentence in the same introduction context and apply the same minimal insertion there.
5. Confirm no other text changes were introduced in the file.
6. Run a focused search in `fhir-fork/source/actordefinition/` for the incorrect phrase fragment `will refer the actors` to verify it is absent.

## Validation Checklist
- [ ] The plan maps FHIR-44470 to a concrete file in `fhir-fork/source/`.
- [ ] Planned edit is restricted to `fhir-fork/source/actordefinition/actordefinition-introduction.xml`.
- [ ] Edit scope is minimal (missing-word insertion only).
- [ ] No unrelated wording normalization, formatting, tooling, or build changes are included.
- [ ] Post-edit verification confirms the incorrect phrase `will refer the actors` is not present.
- [ ] Corrected phrase appears as `will refer to the actors` in the targeted introduction context.

## Risks and Assumptions
- Risk: The exact sentence from Jira may have drifted since ticket filing, requiring semantic location of the intended clause.
- Assumption: Ticket intent is limited to adding the missing word in ActorDefinition introduction text and not broader editorial cleanup.
- Open question: None at planning stage.
