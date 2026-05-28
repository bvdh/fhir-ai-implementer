# Implementation Plan: FHIR-55118

## Scope Summary
- Workgroup/source: current ticket export for FHIR-55118; ticket moved into `jira/active/` for implementation planning.
- Tickets in scope: FHIR-55118.
- Primary fix pattern: replace contractions on the clinician overview page with fully spelled-out wording while preserving meaning and tone.

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-55118 | Spelling/abbreviation issues on page: overview-clinical | Waiting for Input | `fhir-fork/source/overview-clinical.html` | wording cleanup | Ticket explicitly calls out `doesn't` and `they're`; confirm the nearby sentence reads naturally after expansion. |

## Shared Implementation Approach
1. Work only in `fhir-fork/source/overview-clinical.html` unless a nearby sentence needs the same wording style for consistency.
2. Replace contractions with full forms that preserve the existing clinical explanation and authorial tone.
3. Keep the edit minimal so the ticket remains traceable to the two flagged phrases.

## Execution Steps
1. Update the sentence containing `doesn't` to use a full spelling such as `does not`.
2. Update the sentence containing `they're` to use a full spelling such as `they are`.
3. Re-read the edited paragraph to confirm the prose still flows naturally and no other contractions were introduced in the same section.
4. Verify the page still renders cleanly in the source HTML and that the wording change is localized to the intended clinical overview text.

## Validation Checklist
- [ ] The planned edit surface is limited to `fhir-fork/source/overview-clinical.html`.
- [ ] Both ticket-flagged contractions are expanded to full wording.
- [ ] The surrounding paragraph still reads naturally and keeps the original meaning.
- [ ] No unrelated formatting, build, or tooling files are included.
- [ ] The plan is ready for implementation review before any spec source change.

## Risks and Assumptions
- Risk: The ticket text names only the contractions, so the exact preferred expansion may need a final wording pass for tone and readability.
- Assumption: The issue is limited to the clinician overview page and does not require cross-page terminology changes.
- Open questions: If reviewers want a more literal spelling style elsewhere on the page, should the same contraction rule be applied consistently to adjacent prose?