# Implementation Plan: FHIR-39121 — Editorial comments for Documents

## Scope Summary

- **Canonical ticket:** [FHIR-39121](./FHIR-39121.md)
- **Specification:** FHIR Core
- **Assignee:** Bas van den Heuvel
- **Status / resolution:** Resolved - change required / Persuasive with Modification
- **Vote date:** 2023-06-26
- **Resolution:** “Will make the changes from the second review.”
- **Primary target:** [`fhir-repo/source/documents.html`](../../../fhir-repo/source/documents.html), primarily the Documents overview, structure, identifiers/dates, presentation, stylesheet, and profiles sections.
- **Scope:** Reconcile the approved second-review editorial comments with the current Documents page. Do not broaden the ticket into unrelated document-model or normative changes.
- **Planning boundary:** This plan does not edit specification source, ticket records, or any other plan. The second-review attachment named in the ticket is not present in the local workspace, so this plan identifies the verifiable changes and the exact gate needed before any additional edits can be specified.

## Ticket Matrix

| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-39121 | Editorial comments for Documents | Resolved - change required; Persuasive with Modification | Documents (`documents.html`) | Editorial corrections and clarification | Resolution refers to “the changes from the second review”; the reviewed document itself is not available locally. The June 2023 source commit and merged PR already contain many editorial changes. |

## Resolution and Comment Interpretation

1. The March 2023 comments record that the earlier “Considered for Future Use” disposition was reverted because R5 had been published and the issue would be reconsidered for R6. They are history, not the final disposition.
2. The June 26, 2023 vote is the final ticket disposition in the local ticket record. The resolution is specifically limited to the second review; it does not enumerate individual edits.
3. The June 28, 2023 ticket comment points to [HL7/fhir PR #2951](https://github.com/HL7/fhir/pull/2951). The PR description says most changes were already present and that remaining small editorials from comments were added.
4. The local PR status record says PR #2951 was merged into `master` on 2023-09-19. The implementing source commit is dated 2023-06-27, one day after the vote. These are distinct events: vote (June 26), source commit (June 27), PR creation (June 28), and recorded merge/application (September 19).
5. The canonical ticket remains locally marked `Resolved - change required`; the available local evidence does not show a later Jira `Applied` or `Published` status for FHIR-39121. The merged PR and current source are application evidence, but they do not establish the current Jira status or publication version.

## Current Source Map and Already-Satisfied Portions

The current file is [`fhir-repo/source/documents.html`](../../../fhir-repo/source/documents.html). The line numbers below refer to the file inspected for this plan and can move as the page evolves.

| Current section / lines | FHIR-39121 scope visible in history | Current state |
|---|---|---|
| Overview, lines 38–62 | Editorial formatting around document exchange and CapabilityStatement conformance; unbounded-EHR wording; distinction between FHIR document bundles and other document structures | Most formatting and wording from the FHIR-39121 commit is present. Later approved FHIR-54512 and FHIR-54513 revisions now replace the old IHE XDS reference and expand the overview to distinguish document bundles, DocumentReference, and DiagnosticReport. Preserve the later wording. |
| Document Structure, lines 72–119 | “May include” wording; Composition introduction; composition-set wording; supporting-information list | The 2023 wording changes are present, with later approved additions for graph/reference handling, signatures, and Provenance. The 2023 phrase “single Composition resource” has since been changed to “root Composition resource” by FHIR-54515. |
| Identifiers and dates, lines 121–144 | Editorial rewrites of identifier/date bullets; clearer paragraph structure around serialization and signatures | The identifier/date editorial form is present but has been superseded in part: FHIR-54516 changed the `Composition.meta.lastUpdated` description, FHIR-54517 removed the redundant “additional documents” identifier requirement, and FHIR-46789 replaced the earlier signature guidance. Do not restore the superseded wording. |
| Documents referencing other documents, lines 146–160 | Current subsection gives options for referring to another document | This subsection is a later addition under FHIR-54515, not original FHIR-39121 scope. Retain it unchanged unless the missing second-review comments demonstrably require a compatible edit. |
| Document Presentation, lines 163–197 | Presentation order; attested-content wording; Composition and subject narrative guidance; editorial paragraph flow | The FHIR-39121 presentation edits are present, including the separate subject-resource narrative guidance. FHIR-54530 later removed a separate normative processor-obligation bullet; do not reintroduce it while editing nearby prose. |
| Stylesheets, lines 200–238 | Editorial line-flow change in the stylesheet explanation and trading-partner paragraph | The original editorial formatting is present. FHIR-54529 later clarified how a Bundle reference resolves to an embedded Binary stylesheet. Preserve that clarification. |
| Document Profiles, lines 240–257 | Editorial line-flow change in the CapabilityStatement/profile paragraph | The 2023 paragraph formatting is present. No later conflicting change was found in this portion of the available history. |

The FHIR-39121 commit (`57c8d051a32fa9fa729af9cb9184f50e79953725`) changed `source/documents.html` by 70 lines (38 insertions, 32 deletions). Its changes are already in the current local source history. One wording error introduced in that commit (“such as a all data stored”) was corrected in a subsequent 2023 page commit (`679444e282de7cb7d18d2837b2b46db62221cbc0`); the current text reads “such as all data stored.”

“Already satisfied” above means the corresponding known FHIR-39121 commit content is present or is represented by a later approved replacement. It does **not** prove that every comment in the unavailable second-review document was handled.

## Post-Vote History: Preservation Constraints and Blockers

The following later source edits overlap with or constrain the same Documents sections. Where a later ticket is locally marked Applied, its approved result takes precedence over replaying historical FHIR-39121 text. “No direct conflict” means the change is contextual and must be preserved, but does not itself prevent a compatible residual editorial correction.

| Later ticket / commit evidence | Changed text or behavior and why it constrains this plan | Direction for implementation |
|---|---|---|
| [FHIR-54512](https://jira.hl7.org/browse/FHIR-54512), Applied; commit `9ecbd4395131ebf7e7406e027145b7547ca1664b` | Replaced the IHE XDS reference in the overview with the IHE MHD link at current line 39. Reinstating the 2023 XDS destination would undo this later approved correction. | Keep the current IHE MHD reference. Apply any second-review change to surrounding prose without restoring the retired link. |
| [FHIR-54513](https://jira.hl7.org/browse/FHIR-54513), Applied; commits `8b971906401102dcbc496a65caae8ea0c47dfc55` and `5c8eff12e0932e7a0f16b55157e06a7288ec54eb` | Replaced the shorter document-format/DocumentReference explanation with a three-item overview including DiagnosticReport at lines 56–62; the follow-up removed the now-duplicated earlier paragraph. A replay of older FHIR-39121 overview wording could erase the distinction or reintroduce duplicate text. | Retain the current three-structure list and all three links. Make only comment-supported edits that preserve the distinctions. |
| [FHIR-43295](https://jira.hl7.org/browse/FHIR-43295), Applied; commit `736523cda3b02579e307112bf1db369f79ec00cd`, and [FHIR-45507](https://jira.hl7.org/browse/FHIR-45507), Applied; commits `e3fe9fdef25099c995e905af26b84a15734f81c4` / `24226d9f5dc004317dbd20fffc9aaaeeaed4da95` | Added explicit reference types and graph-connected Bundle guidance in the supporting-information clause (current lines 112–116). These later constraints affect document assembly and are not optional editorial phrasing. | Preserve the reference-type list and Graph-connected Bundles reference. Do not replace or simplify the supporting-information rule while implementing unrelated edits. |
| [FHIR-54514](https://jira.hl7.org/browse/FHIR-54514), Applied; commit `c92cc3feecd98cf30508a7ead407626a4c38a19b` | Added `Signature` to the allowed supporting references and added Provenance resources targeting the Bundle at lines 112–118. This extends the allowed bundle contents beyond the 2023 version. | Keep the Signature reference and Bundle-targeting Provenance bullet. Do not restore the older three-item-only list. |
| [FHIR-54515](https://jira.hl7.org/browse/FHIR-54515), Applied; commit `659b42449d4d6ca776f85da5518600c536e790c4` | Changed “single Composition resource” to “root Composition resource” at line 110 and added the “Documents referencing other documents” subsection at lines 146–160. Reverting to the original FHIR-39121 phrase would conflict with the later approved wording. | Use the current “root Composition resource” wording and preserve the later subsection. |
| [FHIR-54516](https://jira.hl7.org/browse/FHIR-54516), Applied; commit `07fdfc9cbbb89b50fb3a70bded7d794dd5640282` | Clarified that `Composition.meta.lastUpdated` is specific to the authoring system and removed the `>= Composition.date` restriction at line 135. This revises the date semantics in the same section as the 2023 editorial rewrite. | Retain the current authoring-system qualification and absence of the obsolete date comparison. |
| [FHIR-54517](https://jira.hl7.org/browse/FHIR-54517), Applied; commit `6f3a1c1ed328e98660c4626ffb832452783acdd3` | Removed the redundant statement that additional documents from the same Composition SHALL have a different `Bundle.identifier`; the globally unique/non-reused identifier rule already covers this. | Do not restore that removed sentence. Keep the current shorter serialization paragraph at lines 142–144. |
| [FHIR-46789](https://jira.hl7.org/browse/FHIR-46789), Applied; commit `44d4699f20a0d3cc55144e2b22bd726e4d2b48fc` | Replaced the former specific attester/KeyInfo requirements with the current `Bundle.signature` direction at lines 138–140. | Keep the current signature wording; do not restore the former KeyInfo or attester requirements. |
| [FHIR-54529](https://jira.hl7.org/browse/FHIR-54529), Applied; commit `ef1712b150110e957b8bff8d8d4afb4c3d498b81` | Clarified that the stylesheet `url` may use Bundle resolution rules to reference a Binary at lines 216–219. This overlaps the stylesheet passage edited for line flow in FHIR-39121. | Retain the Bundle resolution link and CSS-only restriction. Do not revert the paragraph to its pre-clarification version. |
| [FHIR-54530](https://jira.hl7.org/browse/FHIR-54530), Applied; commit `1e2b4eaaa9adc2d5a5796a5948707783926ca8d3` | Removed a separate SHALL bullet in Processor Obligations requiring the narrative rules to be followed. This is adjacent to, but distinct from, the current presentation guidance. | Do not add the deleted normative bullet back as part of an editorial cleanup. If second-review comments touch normative terms, escalate before changing them. |
| Commit `aec3a16f6006be381543368ecafb845554b913be` is titled FHIR-40757 | It changed the document-structure phrase from “Provenance statements and a signature” to “Provenance statements including signatures.” However, the local [FHIR-40757 record](https://jira.hl7.org/browse/FHIR-40757) is about R5 extensions and mandatory fields and does not document this Documents-page change. The source wording is current, but the ticket-to-edit relationship is not established by the local record. | Preserve the current wording as source evidence. Do not infer additional approved intent from this commit subject; if a proposed edit depends on its rationale, verify the correct ticket/resolution during implementation. |
| [FHIR-54532](https://jira.hl7.org/browse/FHIR-54532), **Unresolved / Triaged**; commit `309312042b064723f251253aec2ad940f0874fc9` exists on `origin/FHIR-54532` | A later branch commit proposes version-specific references and Provenance guidance for imported resources. The commit is not an ancestor of the inspected `HEAD` and its local ticket is Unresolved, so it is neither current applied text nor approved policy. | Do not merge or apply this proposal as part of FHIR-39121. If FHIR-54532 is later resolved and merged, reconcile any overlapping processor-obligation text separately while preserving its final approved disposition. |

Other later edits found in the page history include FHIR-45281’s article correction and the 2023 “a all” typo correction. They do not create a blocker for the FHIR-39121 intent. The review should still avoid undoing them.

## Execution Steps

1. **Obtain the resolution source before defining residual edits.** Locate and review the second-review attachment referenced by the ticket, particularly `Documents - Editorial comments from Philips -rg -pw.docx` and, if needed for comment history, the earlier Philips comment files. Record each comment as an individual checklist item for implementation review; do not infer requests from filenames or the PR summary.
2. **Reconcile each comment against existing source and PR #2951.** For every item, compare the requested text with the FHIR-39121 commit and the current `documents.html` content. Classify it as: already implemented by FHIR-39121; satisfied by a later approved replacement; still outstanding and compatible; or ambiguous/unsupported.
3. **Resolve all overlaps before editing.** Use the post-vote constraints above. For any item affecting sections changed by FHIR-54512/13/14/15/16/17/29/30 or FHIR-43295/45507/46789, retain the later approved text and limit edits to a compatible scope.
4. **Apply only verified residual editorial corrections.** If no second-review item remains outstanding, make no source change. If a residual item is supported, change only the relevant prose in `fhir-repo/source/documents.html`; expand beyond that file only if the attachment explicitly identifies another source page and the ticket intent requires it.
5. **Review the final diff against the comment checklist.** Confirm every comment has a disposition, no already-satisfied content was duplicated, later approved wording remains intact, and no unrelated source or repository files changed.
6. **Check normative-language and behavior impact.** If a proposed edit changes SHALL/MUST/SHOULD/MAY language, conformance behavior, or the semantics of document construction, stop for explicit approval rather than treating it as editorial.

## Validation Checklist

- [ ] Every second-review comment is available and mapped to an exact current source section.
- [ ] Every comment is classified as implemented, superseded by a later approved change, outstanding, or unresolved.
- [ ] Planned source edits are limited to `fhir-repo/source/` and directly traceable to FHIR-39121.
- [ ] The current MHD, DiagnosticReport, graph/reference, Signature, Provenance, Composition-root, date, identifier, stylesheet, and document-reference guidance is preserved.
- [ ] No FHIR-54532 unresolved-branch proposal is treated as approved or copied into the current source.
- [ ] No normative language or behavior changes are made without explicit approval.
- [ ] The source diff contains no unrelated changes and does not overwrite shared-workspace work.
- [ ] If source changes are authorized and made, validate against the FHIR repository’s normal build and content checks. No build was run for this planning task, as requested.

## Risks and Assumptions

- **Missing authoritative detail:** The local ticket says “changes from the second review,” but its comments do not enumerate those changes. The named Word attachments were not found in the workspace. Without them, a complete outstanding-change list cannot be verified.
- **Application-state gap:** Local evidence records PR #2951 as merged, and the FHIR-39121 source commit is in the inspected source history, but the local Jira record still says `Resolved - change required`; no FHIR-39121 Applied/Published record or published-version evidence was found.
- **History boundary:** No fetch/pull was performed. Findings reflect the local ticket exports, local PR status artifact, local Git objects/refs, and inspected source snapshot only.
- **Shared-workspace caution:** The FHIR checkout and outer ticket repository have unrelated work in progress. This plan must not be used to justify reverting or changing those files.
- **Assumption:** The ticket’s scope remains the Documents editorial review and does not authorize new normative requirements or behavior changes beyond the final resolution and reviewed comments.
- **Open question / execution gate:** Where are the second-review Philips Word attachment(s), and which specific comments were accepted in that review? Until answered from the authoritative document, no additional residual source edits can be specified reliably.

## Evidence Snapshot and Hashes

SHA-256 values below identify the local evidence files inspected for this plan. Git commit IDs are shown in the history table above. The source hash identifies the inspected current file, not a claim about a published FHIR release.

| Evidence | Local status or use | SHA-256 |
|---|---|---|
| [`FHIR-39121.md`](./FHIR-39121.md) | Canonical ticket metadata and comments | `9e133a6d6582d93727cc914177197804eeb26bf6381c8a9af73e096ec2b1ed63` |
| [`documents.html`](../../../fhir-repo/source/documents.html) | Current source target | `0f468e7bdd3ac4753e1e27372b5377ebf05e79489220c50b61a462e6246b415a` |
| [`2951-status.md`](../../../pr/merged/2951-fhir-39121/2951-status.md) | Local PR merge evidence | `fe67fff5c2015ec8f67f68c04d3fcb4086d1e50afc6a4ae6dec5ad8654df1b4e` |
| [FHIR-54512 ticket](../../closed/FHIR-54512/FHIR-54512.md) | Applied MHD reference update | `ae99902d8f44aa57870ee27fc4a1f472b685eb626219eb69e1fab86f96aeea87` |
| [FHIR-54513 ticket](../../closed/FHIR-54513/FHIR-54513.md) | Applied document-structure overview update | `81bfe8b0476b9c421a576acd87a4f5ce45fcccc60f01898bf9b656f66496ae00` |
| [FHIR-54514 ticket](../../closed/FHIR-54514/FHIR-54514.md) | Applied Signature and Provenance bundle updates | `ec1ea166adbb748dcade6c5b9333d33acacdcf29f0fb7a560d26e7590af4223d` |
| [FHIR-54515 ticket](../../closed/FHIR-54515/FHIR-54515.md) | Applied Composition-root and referred-document guidance | `cb7e35147b6d317836278744cc0800cf821c5ac317af24cdc9845a3bc50d0ef8` |
| [FHIR-54516 ticket](../../closed/FHIR-54516/FHIR-54516.md) | Applied `lastUpdated` clarification | `81185ac51be4cd2729ece50fb52764aa53d3548fc636aabbe78cfd3f899a2ec2` |
| [FHIR-54517 ticket](../../closed/FHIR-54517/FHIR-54517.md) | Applied redundant identifier sentence removal | `dfe2498ce7f405708e4e23c71116570c90251d92b316c0cea8fe79c1ebc6f9cb` |
| [FHIR-54529 ticket](../../closed/FHIR-54529/FHIR-54529.md) | Applied stylesheet reference clarification | `5343341b4a7ff73f14c707a2d70ff7b1ae87ba947506f0b03ba73d501395ecb5` |
| [FHIR-54530 ticket](../../closed/FHIR-54530/FHIR-54530.md) | Applied removal of redundant narrative SHALL bullet | `c805f7763408adeb8a21622efa717f3f441a4bb2e42a51132e6f4a9e34913986` |
| [FHIR-54532 ticket](../../open/FHIR-54532/FHIR-54532.md) | Unresolved ticket; branch proposal excluded from approved source | `933274506d5e5a253695085b43c236687711d73e3bdad6d8e12af0615a903e2f` |
| [FHIR-43295 ticket](../../closed/FHIR-43295/FHIR-43295.md) | Applied reference-graph clarification | `b6e8c977eb159b3d89c47b411da04f422946c37404414c57f41dc6a8017dafcf` |
| [FHIR-45507 ticket](../../closed/FHIR-45507/FHIR-45507.md) | Applied graph-connected Bundle clarification | `8e263b81a9f6e458dac4ede5fe3c9aa039de2f2b64f39ab8ae4596350556261b` |
| [FHIR-46789 ticket](../../closed/FHIR-46789/FHIR-46789.md) | Applied document-signature clarification | `05c11489e3d0406c9056616463239db76552e03e4c041f2f9473b2551f23b3ed` |
| [FHIR-40757 ticket](../../closed/FHIR-40757/FHIR-40757.md) | Local record does not substantiate the Documents-page commit attribution | `c5deb5e33eedd63737f2919ab621b679822aee4a90044381473919b3b1afdd90` |
