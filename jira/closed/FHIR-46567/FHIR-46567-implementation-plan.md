# Implementation Plan: FHIR-46567

## Scope Summary
- Workgroup/source: Single ticket input (FHIR-46567)
- Tickets in scope: FHIR-46567
- Primary fix pattern: Typographical wording correction in Mapping Language narrative text

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-46567 | Typo - "the" should be "there" | Resolved - change required | Mapping Language simple section (`mapping-language.html#simple`) under source for Mapping Language narrative content | Typo/text correction | Update sentence from "if the is only one" to "if there is only one" |

## Shared Implementation Approach
1. Locate the Mapping Language source page in `fhir-fork/source/` that renders `mapping-language.html#simple`.
2. Find the first sentence quoted in the ticket and verify the exact typo context.
3. Apply the minimal text-only correction to replace `the` with `there` in the affected sentence.
4. Keep surrounding punctuation/capitalization unchanged unless required for grammatical consistency.

## Execution Steps
1. Identify the canonical source file in `fhir-fork/source/` for the Mapping Language "simple" section.
2. Search for the phrase fragment `if the is only one` (or the full sentence starting `If no dependent rules are specified...`).
3. Confirm the match is the sentence referenced by FHIR-46567 and not a different context.
4. Edit the sentence to: `If no dependent rules are specified, and if there is only one ...`.
5. Perform a local consistency pass to ensure no duplicate typo remains in the same page/section.
6. Review diff to confirm only intended wording change is included.

## Validation Checklist
- [ ] Ticket FHIR-46567 is mapped to at least one specific source page/file.
- [ ] Planned edit is constrained to `fhir-fork/source/`.
- [ ] The typo correction exactly matches ticket intent (`the` -> `there`).
- [ ] No unrelated formatting, tooling, or structural changes are introduced.
- [ ] Post-edit review confirms no additional occurrences in the same section were missed.
- [ ] Plan remains implementation-ready with unambiguous execution order.

## Risks and Assumptions
- Risk: The rendered anchor (`#simple`) may correspond to a source fragment included from another file, which can make initial file targeting non-obvious.
- Assumption: The typo exists in a single sentence occurrence in Mapping Language "simple" section and requires only one text replacement.
- Open questions: None at planning stage; if multiple matching occurrences are found during implementation, confirm whether all should be corrected or only the sentence explicitly referenced by the ticket.
