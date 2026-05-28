# Implementation Plan: FHIR-44050

## Scope Summary
- Ticket: FHIR-44050
- Summary: Wording change needed for 'the FHIR'
- Status: Resolved - change required
- Resolution: Persuasive
- Planning scope: Define the minimal specification text edit required to remove the article in the identified sentence.
- Implementation boundary: Limit edits to `fhir-fork/source/` during execution.

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-44050 | Wording change needed for 'the FHIR' | Resolved - change required | `fhir-fork/source/services.html` (`#considerations`, sentence beginning "Rollback is not expressly specified...") | Wording/terminology cleanup | Replace `the FHIR` with `FHIR` in the specified sentence only. |

## Shared Implementation Approach
1. Locate the exact sentence in `fhir-fork/source/services.html`: "Rollback is not expressly specified as part of the FHIR."
2. Apply the smallest possible text edit to remove only the article `the` before `FHIR`.
3. Preserve punctuation, capitalization, line wrapping style, and all surrounding wording.

## Execution Steps
1. Open `fhir-fork/source/services.html` and navigate to the `Architectural Considerations` section (`#considerations`).
2. Find the sentence: "Rollback is not expressly specified as part of the FHIR."
3. Change only `the FHIR` to `FHIR`, resulting in: "Rollback is not expressly specified as part of FHIR."
4. Confirm no adjacent wording changes were introduced in the paragraph.
5. Run a focused search in `fhir-fork/source/` for `part of the FHIR` to verify the targeted phrase has been removed at this location and to identify any unrelated occurrences for separate ticket handling.

## Validation Checklist
- [ ] The plan maps FHIR-44050 to at least one concrete file in `fhir-fork/source/`.
- [ ] Planned edit is restricted to `fhir-fork/source/services.html`.
- [ ] Edit scope is minimal (single wording change: `the FHIR` -> `FHIR`).
- [ ] No unrelated formatting/tooling/build changes are included.
- [ ] Post-edit search verifies the targeted phrase is removed from the intended sentence.
- [ ] Updated sentence remains grammatically correct and aligned with ticket wording intent.

## Risks and Assumptions
- Risk: Broad search/replace could alter additional `the FHIR` phrases outside ticket scope.
- Assumption: Ticket intent is limited to the sentence referenced in `services.html#considerations`.
- Open question: None at planning stage; implementation can proceed with a minimal single-sentence edit.
