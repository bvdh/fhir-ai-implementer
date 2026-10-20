# Implementation Plan: FHIR-54535

## Scope Summary
- Workgroup/source: FHIR Infrastructure; FHIR Core ticket FHIR-54535.
- Ticket in scope: FHIR-54535 only.
- Primary change: Replace the DocumentReference-specific mandatory `_content` search statement with the approved optional search over decoded attachment data.
- Planning evidence snapshot: 2026-10-20. Ticket metadata reports Vote Date 2026-10-19.
- Planning only: no source edit, build, branch operation, checkout synchronization, commit, or Jira update was performed for this plan.

## Ticket Matrix
| Ticket | Summary | Status / resolution | Target section | Change type |
|---|---|---|---|---|
| FHIR-54535 | DocumentReference search using `_content` | Resolved - change required / Persuasive | DocumentReference Implementation Notes, `fhir-repo/source/documentreference/documentreference-notes.xml`, line 10 | Normative behavior clarification |

## Resolution and Comment Mapping
| Ticket decision or comment | Interpretation for implementation | Exact source mapping |
|---|---|---|
| Resolution: replace “shall search” across `attachment.data` and `attachment.url` with “MAY search” decoded content in `attachment.data`. | Permit (do not require) searching decoded attachment data. Remove the URL from this particular `_content` behavior sentence. | `fhir-repo/source/documentreference/documentreference-notes.xml`, Implementation Notes, line 10. |
| Ticket description asks whether `Attachment.data` means Base64 or deserialized content. | The resolution specifies decoded content; do not describe searching the encoded Base64 representation. | Same sentence, line 10. |
| Ticket description asks whether searching `Attachment.url` means matching URL text or fetching and searching the referenced resource. | The resolved sentence omits `attachment.url`; do not imply that URL text must be searched or that a URL target must be fetched and searched. | Same sentence, line 10. |
| John Moehrke's 2026-05-13 comment notes that not all servers can do full-text document search and anticipated that it might require an operation. | The resolution chooses optional support in this search parameter statement. Do not add a new operation or make support mandatory. | Same sentence, line 10; no separate operation source is implicated. |
| Oliver Egger's 2026-05-13 IHE MHD comment describes full-text search of document content as an option. | Treat as context for the intended decoded document-content meaning, not as a request to copy or normatively incorporate IHE text. | Same sentence, line 10; no IHE source edit. |
| Lloyd McKenzie's 2026-08-13 reopening and reversal comments record disposition history. | Procedural history only; the current ticket resolution and approved replacement govern this plan. | No additional source edit. |

## Source Mapping and Boundaries
- **Direct target:** `fhir-repo/source/documentreference/documentreference-notes.xml`, Implementation Notes list, line 10. Replace the existing sentence with the ticket's resolved sentence, preserving the `<li>` and `<code>` markup. The expected wording is: “The _content search parameter MAY search across the decoded content in the DocumentReference.content.attachment.data.”
- **Generic context, not a target:** `fhir-repo/source/search.html`, `_content` subsection, lines 5839-5846, describes `_content` as a special search parameter for textual content. Keep this general definition unchanged; it does not restate the DocumentReference-specific attachment requirement.
- **SearchParameter definition, not a target:** `fhir-repo/source/resource/bundle-Resource-search-params.xml`, `Resource-_content` entry, lines 8-15, defines the resource-level special parameter. Do not alter it.
- **Distinct URL search parameter, not a target:** `fhir-repo/source/documentreference/bundle-DocumentReference-search-params.xml` contains the `url` search parameter (including the attachment URL expression around lines 374-380). It is separate from `_content`; do not remove or modify it.
- Search of `fhir-repo/source/documentreference/` found the behavior sentence only in `documentreference-notes.xml`. The broader source search found the generic `_content` definition and resource-level parameter noted above, but no second DocumentReference-specific behavior statement.

## Local History and Application Evidence
- The canonical local ticket file, `jira/active/FHIR-54535/FHIR-54535.md`, reports Project/Specification FHIR Core, Status `Resolved - change required`, Resolution `Persuasive`, and Vote Date `2026-10-19`. This verifies the eligibility gate against the available local snapshot; no live Jira status was queried.
- The relevant baseline is `5a1b865a60060794c71b2ace30105c97a69e0c56`, dated 2026-10-19; its version of the sentence still says `shall` and includes both `.data` and `.url`.
- A post-vote implementation commit now exists: `26e383455a6659d1763bb8446dca0a73fdfdc470`, authored and committed by Bas van den Heuvel on 2026-10-20 at 15:01:29 +02:00. It changes exactly one line in `source/documentreference/documentreference-notes.xml`, matching the resolution. The local `FHIR-54535` branch and its `origin/FHIR-54535` tracking ref point to this commit. Evidence: [FHIR-54535 commit](https://github.com/HL7/fhir/commit/26e383455a6659d1763bb8446dca0a73fdfdc470).
- Relevant earlier committed context: `3800384a0c47165145ee8b96d9eb58e1cfd238c4`, dated 2026-03-27, titled `FHIR-53824, FHIR-53550 --DocumentReference.related/relatesTo clarified for purpose of each`, added adjacent `relatesTo` and `related` notes but did not change the `_content` sentence. Evidence: [commit diff](https://github.com/HL7/fhir/commit/3800384a0c47165145ee8b96d9eb58e1cfd238c4).
- A separate post-vote FHIR-54000 merge, `eba19ee864aa1f979f5629e514244f1ebedb1e4e` (2026-10-20 14:02:41 +02:00), adds guidance about indexing/searching the `additionalReference` extension in `source/search.html` around line 3259. It is unrelated to the `_content` subsection (lines 5839-5846), does not change the Resource-_content or DocumentReference `url` SearchParameter definitions, and is not an ancestor of the FHIR-54535 implementation commit (whose parent is the 2026-10-19 baseline `5a1b865...`). It is **not a blocker**; no FHIR-54000 content needs to be folded into this ticket's one-line change. Evidence: [FHIR-54000 merge](https://github.com/HL7/fhir/commit/eba19ee864aa1f979f5629e514244f1ebedb1e4e).
- These history checks used locally available Git refs only. No fetch or remote refresh was performed, so commits not present in the local object database cannot be ruled out.
- The existing local [implementation change log](./FHIR-54535-implementation-change-log.md), dated 2026-10-20, reports the focused source edit, successful `./gradlew publish` (11m 9s), and an HTTP 404 while fetching a FHIR-54535 terminology cache despite the successful build. It also reports restoring unrelated build side effects and preserving the pre-existing `.project` modification. These are claims in the local log, not independently rerun validations in this planning-only task.
- The local generated `fhir-repo/publish/documentreference.html` currently contains the resolved wording at line 1641. This demonstrates that local generated output reflects the change; it does **not** establish publication to the public FHIR site.
- The local ticket snapshot has no Applied/Published status or PR reference. The dates supported by local evidence are distinct: the vote is dated 2026-10-19, the source change is committed on the `FHIR-54535` branch on 2026-10-20, and the local change log reports its build on 2026-10-20. The commit is not evidence of merge to the main FHIR branch, Jira Applied status, or public release; those remain unverified.

## Already-Satisfied Portions and Remaining Work
- **Source change:** Already committed on the local `FHIR-54535` branch as `26e383455a6659d1763bb8446dca0a73fdfdc470`; current line 10 matches the resolution. The current generated `documentreference.html` contains the same wording.
- **Reported validation:** The existing change log records a successful publish build and focused checks. Do not treat the log as proof of upstream application or repeat the build as part of this planning-only task.
- **Implementation follow-through:** Do not reapply the sentence change. Review the existing commit and its branch context; make no further source changes unless a later authoritative change or review identifies a specific conflict.
- **Application status:** Confirm through the normal ticket/PR workflow whether the branch commit has a PR, is merged, and is reflected in Jira/public publication. Only the branch commit is established by local Git evidence.

## Execution Steps
1. Review commit `26e383455a6659d1763bb8446dca0a73fdfdc470` and verify its one-line source change matches the currently approved ticket resolution; do not reapply the edit.
2. Confirm the target remains `fhir-repo/source/documentreference/documentreference-notes.xml:10` and that the change preserves the XHTML/XML markup, specifies decoded attachment data, uses `MAY`, and omits `.attachment.url`.
3. Leave the generic `_content` prose in `source/search.html`, the `Resource-_content` SearchParameter entry, the separate DocumentReference `url` search parameter, and unrelated DocumentReference guidance unchanged.
4. Recheck the DocumentReference source for conflicting duplicate behavior only if the implementation commit changes or review identifies a conflict. Confirm there is no implication that encoded Base64 text, URL text, or fetched URL content must be searched.
5. Treat the existing publish result as reported evidence for the current commit unless source changes invalidate it. If revalidation becomes necessary, use the standard FHIR build workflow and record validation separately from vote, commit, merge, and publication dates.

## Validation Checklist
- [x] Local ticket metadata meets the planning gate: non-empty `Persuasive` resolution and `Resolved - change required` status.
- [x] Resolution and relevant comments are mapped to the exact DocumentReference sentence and adjacent generic search definitions.
- [x] The local FHIR-54535 commit contains only the approved one-line source change under `fhir-repo/source/`.
- [x] Source search found no duplicate DocumentReference-specific `_content` behavior statement; generic search definitions and the separate `url` parameter are identified.
- [x] Existing local execution log reports a successful publish build; this plan did not rerun it.
- [ ] Establish whether the branch commit has a PR, is merged, and is reflected in Jira Applied status and public publication.

## Risks, Assumptions, and Open Questions
- Risk: Changing “shall” to “MAY” changes required capability into optional capability; preserve the exact approved modality and avoid expanding the scope.
- Risk: The `FHIR-54535` branch commit is not, by itself, proof of merge to the main FHIR branch or public publication.
- Assumption: The approved replacement is authoritative. “Decoded content” means the decoded attachment payload, not its Base64 encoding.
- Assumption: Omitting `attachment.url` from this behavior statement means this statement imposes no requirement to search URL text or dereference a URL for full-text search; it does not change the separate `url` SearchParameter.
- Open question: Local evidence cannot determine whether Jira or the public specification has since marked, merged, or published the change. Confirm those states when doing the application/PR workflow.
- Limitation: History checks used the local Git object database and refs only. No remote refresh was performed, so later upstream commits not present locally cannot be ruled out.
