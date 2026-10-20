# Implementation Plan: FHIR-55328 — Spelling/abbreviation issues on overview-patient

## Scope Summary

- **Ticket:** FHIR-55328
- **Canonical ticket file:** `jira/assigned/FHIR-55328/FHIR-55328.md`
- **Assignee:** Bas van den Heuvel
- **Status / resolution:** Resolved - change required / Persuasive
- **Specification / work group:** FHIR Core / Patient Empowerment
- **Primary fix pattern:** Correct the two cited spelling/contraction issues in the Patient overview page.
- **Source scope:** `fhir-repo/source/overview-patient.html` only.
- **Planning boundary:** No specification source, generated output, ticket metadata, or other plan is changed as part of this plan.

## Ticket Matrix

| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-55328 | Spelling/abbreviation issues on page: overview-patient | Resolved - change required; Persuasive | `overview-patient.html` | Spelling and contraction correction | The ticket specifically identifies “refering” and “they’re”. |

## Resolution and Exact Planned Edits

The current source is `fhir-repo/source/overview-patient.html` in the checked-out FHIR repository at revision `26e383455a6659d1763bb8446dca0a73fdfdc470` (2026-10-20). The target lines are unchanged in the current working tree.

| Current source line | Current wording | Planned wording | Rationale |
|---|---|---|---|
| 25 | `...agree on how they’re going to send and share data...` | `...agree on how they are going to send and share data...` | Expand the specifically cited contraction without changing meaning or sentence structure. |
| 100 | `...a pun on the JSON format, refering to Jason and the Argonauts...` | `...a pun on the JSON format, referring to Jason and the Argonauts...` | Correct the specifically cited misspelling. |

Keep both edits confined to these phrases. Do not broaden the change to unrelated wording or other apparent spelling/style issues elsewhere on the page.

## Source History and Vote-Date Evidence

### Vote-date cutoff

The ticket markdown does **not** contain a `Vote Date`. Its issue links identify BALLOT-91784 and BALLOT-93669 and show affirmative vote snippets with truncated dates (`2026-J...`); the ticket’s Comments section contains an assignment comment dated 2026-01-27, not a vote date. A local search for those ballot IDs found no separate ballot record or dated vote evidence. Therefore, the exact vote date and the requested post-vote cutoff are **unverified**. Do not substitute the ticket’s Created, Updated, or Resolved dates for a vote date.

The source history below was reviewed through the checked-out source revision above. It cannot be classified as “after the vote” without a verifiable vote date.

### Affected-line history

`git blame` attributes both current target lines (25 and 100) to commit `a7b5d4574d5f5301ded1f590e357d9ba927d7be1`, authored by Abigail Watson on 2023-02-24 (“r5 patient intro edits”). Line history shows no subsequent commit changing either cited phrase. The misspelling and contraction remain present in the current source.

Relevant commits elsewhere on this same page:

| Commit | Commit date and subject | Evidence / effect on this ticket |
|---|---|---|
| `1f15661843844066aea8c4bf6d3e7bbf745a6f62` | 2023-03-20 — “Marked patient intro as owned by PE” | Changed the page’s work-group metadata, not either cited sentence. |
| `270e0ceb7b029dad4ca0fc5ccf5296ff370888cd` | 2025-10-31 — “normative changes for R6” | Changed the page’s responsibility/standards-status metadata, not either cited sentence. |
| `c55a0afb58fb4c253421547019cef2b67b2f76da` | 2026-05-26 — “FHIR-54022: Standardize payer spelling in financial narrative content” | Changed “payors” to “payers” in a separate Patient overview list item. |
| `99127f6665bf4ffb5bf5c80589106ead5a0ae5b5` | 2026-05-27 — “FHIR-54022: Standardize payer terminology in mapped prose pages” | Changed “Payor” to “Payer” in separate Patient overview prose. |

### Later/applied-ticket overlap and incompatibility assessment

FHIR-54022 is marked **Applied** in `jira/closed/FHIR-54022/FHIR-54022.md`. Its ticket comment links PR 4116 on 2026-05-27, and its implementation change log records execution on 2026-05-27. The two source commits above are dated 2026-05-26 and 2026-05-27. These are distinct evidence types: ticket resolution/status and execution records are not commit dates, and none establishes when FHIR-55328 was voted on.

FHIR-54022 touched the same source file but changed payer terminology in different passages. It is not a blocking change: the planned spelling correction and contraction expansion do not overlap or conflict with the applied payer wording. Preserve the payer spellings if implementing FHIR-55328. No other later blocking change or incompatibility was identified in the available page history. Because the vote cutoff is unverified, the commits cannot be asserted to be later than the vote.

## Shared Implementation Approach

1. Make only the two ticket-specified corrections in `fhir-repo/source/overview-patient.html`.
2. Preserve the surrounding text, markup, and punctuation; retain FHIR-54022’s payer terminology.
3. Do not edit files outside `fhir-repo/source/` in the FHIR checkout, and do not modify generated publish output.
4. Avoid disturbing unrelated pre-existing changes in the shared workspace.

## Execution Steps

1. Reconfirm the source checkout and inspect the current diff/status before editing; preserve all pre-existing work.
2. In `fhir-repo/source/overview-patient.html`, expand `they’re` to `they are` in the sentence at line 25.
3. In the same file, change `refering` to `referring` in the Argonaut sentence at line 100.
4. Review the resulting diff to ensure only those two phrases changed and no neighboring FHIR-54022 payer wording was altered.
5. If the vote date is later established before implementation, review the page history from that exact date and update the compatibility assessment before applying edits.

## Validation Checklist

- [ ] Both ticket-specific phrases are corrected in `fhir-repo/source/overview-patient.html`.
- [ ] The final diff contains only the two intended text changes in the FHIR source tree.
- [ ] Surrounding markup and wording are preserved, including FHIR-54022 payer terminology.
- [ ] No generated files, tooling, ticket files, or unrelated source files are changed.
- [ ] Run the repository’s FHIR build validation after source edits when required, following the `build-fhir` skill; do not edit generated output as a substitute for source changes.
- [ ] Record that the historical post-vote review remains limited until an authoritative Vote Date is available.

## Risks and Assumptions

- **Vote-date uncertainty:** The ticket references two ballots but provides no complete vote date. The local ticket/comments/history evidence does not establish a cutoff; no Created, Updated, or Resolved date is used as a proxy.
- **Minimal editorial interpretation:** “they’re” is treated as the contraction “they are”, and “refering” as the misspelling “referring”, consistent with the ticket’s explicit examples.
- **Scope control:** Other apparent page issues are outside this ticket’s listed specifics and are not included.
- **Historical overlap:** FHIR-54022 is an applied ticket that touched this page, but its payer edits are in different passages and are not incompatible. Its position relative to FHIR-55328’s vote cannot be determined absent the Vote Date.
- **Open decision:** Obtain an authoritative Vote Date only if a strict after-vote history cutoff is required before implementation; until then, retain the limitation above in implementation review.
