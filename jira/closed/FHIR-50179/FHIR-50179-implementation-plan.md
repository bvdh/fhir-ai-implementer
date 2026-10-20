# Implementation Plan: FHIR-50179

## Scope Summary

- **Ticket:** FHIR-50179 — “Characters `â€“` appearing in text, missing space in `implementability`.”
- **Work group / source:** FHIR Infrastructure / FHIR Core.
- **Ticket state:** Resolution `Persuasive`; status `Resolved - change required`. The ticket meets the planning eligibility gate.
- **Scope:** This ticket only. Keep any specification edits within `fhir-repo/source/`.
- **Primary fix pattern:** Correct punctuation/spacing in the introductory Summary text, but only if the reported defect can be reproduced in the current source or rendered output.

## Ticket Matrix

| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-50179 | Characters `â€“` appear in text; missing space in `implementability` | Resolved - change required / Persuasive | Summary (`summary.html`, introductory text) | Text/encoding correction | The current source already contains en dashes and the expected space. Confirm the actual failing artifact before changing it. |

## Current Source Assessment

The exact current edit surface is [`summary.html`](../../../fhir-repo/source/summary.html), Summary introduction:

- **Line 21:** `FHIR® – Fast Healthcare Interoperability Resources (hl7.org/fhir) – is a next generation`
- **Line 24:** `and applying a tight focus on implementability.`
- **Line 30:** `FHIR is suitable for use in a wide variety of contexts – mobile phone apps,`

The source currently contains U+2013 en dashes at the reported punctuation locations and a normal space between `on` and `implementability`. These lines match `origin/master`. Line history attributes the first and second paragraph text to commits from 2015 and the `implementability` wording to 2014; no FHIR-50179 commit was found in the local FHIR history. The requested correction therefore appears already present in the current source, but the ticket’s cited ballot page/rendered artifact has not been verified in this planning run.

## Historical Analysis and Compatibility

### Vote-date evidence and cutoff

- The assigned ticket markdown has no **Vote Date** field, and its Comments section says `_No comments in export._`
- The Jira issue API request was denied with HTTP 403, so vote/comment history could not be independently checked.
- The ticket’s Created, Updated, and Resolved dates are not evidence of its vote date and are not used as a historical cutoff.
- **Vote-date status: unverified.** As a result, the source history below is reported with its actual Git commit dates; it cannot be asserted to be “after the vote.” The missing cutoff prevents a definitive post-vote compatibility assessment.

### Relevant source history

| Commit | Git commit date and subject | Jira evidence / effect | Compatibility |
|---|---|---|---|
| `49a9b66cef8df71a54462ccd1c30af90167bc85c` | 2025-03-03 — “FHIR-41514 Summary page example is out of date” | The local FHIR-41514 record is `Applied`, with resolution vote dated 2024-01-22 and `Applied for Version: R6`. The Jira record does not provide an application date; 2025-03-03 is the source commit date, not an inferred application date. The commit removes the Twitter hashtag link near the page end. | No overlap with the FHIR-50179 introductory text. |
| `270e0ceb7b029dad4ca0fc5ccf5296ff370888cd` | 2025-10-31 — “normative changes for R6” | Changes the Summary page status/header and development-process content, not the reported introductory sentences. | No conflict with the punctuation/spacing correction. Preserve these later edits. |
| `4d92dfae4cd04c18da95802751a0f7737d50cf81` | 2025-11-01 — “review fixes” | Changes wording in the separate development-process section. No corresponding FHIR ticket/application date was established from this commit alone. | No overlap with the target text. |
| `66bdaaf37b034ecec2dfa4369830f9479eb615fd` | 2025-11-03 — “FHIR-41327 Status of ontology-based analysis with formal mapping for correctness?” | The local FHIR-41327 record is `Applied`, `Applied for Version: R6`, with vote date 2023-12-18. The commit removes the ontology-analysis bullet from another Summary section. Its commit date is known; the ticket record does not give an application date. | No conflict with the introductory text. Preserve the removal and all surrounding later Summary changes. |

The three 2025-10/11 commits are later source changes to the same page, but they edit other sections. Because FHIR-50179’s vote date is unavailable, their ordering relative to its vote cannot be established. No blocking change or incompatible intent was identified in the inspected source history.

## Shared Implementation Approach

1. Treat the current source as potentially already satisfying the ticket; do not rewrite the punctuation or whitespace without reproducing the reported failure.
2. Compare the exact source text with the artifact identified by the ticket (the R6 ballot-2 Summary page) and, if necessary, the current generated Summary page.
3. If the source itself is defective, make only the correction demonstrated by the ticket: render the intended en dashes as en dashes and ensure the phrase reads `a tight focus on implementability.` with a space between `on` and `implementability`.
4. If source text is correct but rendered output is not, investigate the rendering/character-encoding path before changing source. Do not substitute ASCII hyphens or HTML entities speculatively.
5. Preserve all unrelated current Summary content, including changes from FHIR-41514 and FHIR-41327.

## Execution Steps

1. Recheck `fhir-repo/source/summary.html` and the relevant rendered page at execution time; this plan’s inspection is a snapshot.
2. Reproduce whether the text defect exists in the source bytes, in generated output, or only in the ticket export. Record which artifact exhibits it.
3. If the source is confirmed defective, edit only the affected introductory characters/spacing at the lines identified above. Do not modify other Summary sections or build/configuration files.
4. If only rendered output is defective, diagnose the page encoding/rendering behavior and propose a narrowly scoped source change only when evidence shows it will fix the output without harming other content.
5. Review the diff to confirm it is limited to the intended Summary sentence(s) under `fhir-repo/source/`.
6. If a source edit is made, validate the published/rendered Summary with the repository’s FHIR build workflow, then verify the output contains the intended en dashes and the spaced `implementability` phrase. Do not treat a successful build alone as proof of the character-level correction.
7. If source and rendered output are already correct, make no source edit and report that the issue is already satisfied or could not be reproduced against the available artifacts.

## Validation Checklist

- [ ] Confirm the exact artifact and location where the reported defect reproduces.
- [ ] Verify the introductory text has the intended en dashes and `on implementability` spacing.
- [ ] Preserve unrelated Summary sections and the later changes identified above.
- [ ] Keep any source diff within `fhir-repo/source/`.
- [ ] If edited, validate the rendered/published Summary, not just the source diff.
- [ ] If no defect reproduces, leave source unchanged and document that finding rather than creating a no-op edit.

## Risks and Assumptions

- **Already-implemented aspects:** Current `summary.html` already has correctly spaced `implementability` text and Unicode en dashes; the target lines match `origin/master`.
- **Unresolved decision:** The ticket export does not establish whether `â€“` is present on the cited ballot page, in current generated output, or only in the exported ticket text. Confirm the defective artifact before choosing a source edit.
- **Historical limitation:** Vote date is unverified because the ticket export omits it and comments are unavailable; therefore no claim is made that a particular commit is before or after the vote.
- **Risk:** Replacing valid en dashes with entities or hyphens without confirming a rendering defect could create an unnecessary or inconsistent edit.
- **Assumption:** The requested correction is limited to the Summary introduction; no change to meaning, normative language, or other sections is intended.
