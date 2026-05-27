# Implementation Plan: FHIR-43803

## Scope Summary

- Ticket: FHIR-43803
- Summary: Typo
- Status: Resolved - change required
- Resolution: Persuasive
- Planning scope: Define the minimal technical correction required for the ActorDefinition wording typo.
- Implementation boundary: Limit execution edits to `fhir-fork/source/` only.

## Ticket Matrix

- Ticket: FHIR-43803
- Summary: Typo
- Status: Resolved - change required
- Target page(s): `fhir-fork/source/actordefinition/actordefinition-introduction.xml` (Scope and Usage paragraph)
- Change type: Grammar/typo correction
- Notes: Correct `can plays` to `can play` in the ActorDefinition introductory sentence.

## Shared Implementation Approach

1. Locate the ActorDefinition introduction sentence in the Scope and Usage section.
2. Apply the smallest possible text change to correct the verb form (`plays` -> `play`) only where the ticket applies.
3. Keep surrounding wording, formatting, and structure unchanged.

## Execution Steps

1. Confirm ticket intent from `jira/active/FHIR-43803/FHIR-43803.md`.
2. Open `fhir-fork/source/actordefinition/actordefinition-introduction.xml` and locate the sentence beginning with `The ActorDefinition Resource`.
3. If the sentence still reads `can plays`, update only that token to `can play`.
4. If the sentence already reads `can play`, record this as already aligned with ticket intent and make no source edits.
5. Run focused searches in `fhir-fork/source/`:
   - `rg -n "can plays the role of a participant" source/actordefinition source/*.xml`
   - `rg -n "The ActorDefinition Resource" source/actordefinition/actordefinition-introduction.xml`
6. Review diff (if any) to ensure no unrelated text changed.

## Validation Checklist

- [ ] FHIR-43803 is mapped to a concrete source file under `fhir-fork/source/`.
- [ ] Planned execution stays within `fhir-fork/source/`.
- [ ] Typo correction is limited to the ticketed phrase (`can plays` -> `can play`).
- [ ] No unrelated wording, formatting, tooling, or build files are changed.
- [ ] Search confirms no remaining targeted incorrect phrase in the edited scope.
- [ ] If no edit is needed, evidence is captured that current source already matches intended wording.

## Risks and Assumptions

- Risk: The exact old phrase may no longer be present if upstream changes already corrected it.
- Assumption: The ticket applies to ActorDefinition introductory prose and not broader narrative rewrites.
- Open questions: None at planning stage.
