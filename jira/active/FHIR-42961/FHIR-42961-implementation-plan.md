# Implementation Plan: FHIR-42961

## Scope Summary

- **Workgroup/source:** FHIR Infrastructure; local canonical ticket at [FHIR-42961.md](./FHIR-42961.md).
- **Eligibility:** FHIR Core; assigned to Bas van den Heuvel; status `Resolved - change required`; resolution `Not Persuasive with Modification`; vote date `2026-07-06`. Eligible for planning.
- **Output:** This plan in the existing `jira/active/FHIR-42961/` directory. Do not move the ticket.
- **FHIR source repository:** `fhir-repo/source/` only. Do not change source during this planning task.
- **Primary fix pattern:** Treat the intentional deprecation and subsequent removal of `Bundle.signature` as the approved lifecycle. The deprecation and its explanatory text were already applied; identify and correct any remaining current Bundle-page text that falsely says the element exists. Do not restore the element or change its cardinality.

## Ticket Matrix

| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-42961 | Update the cardinality of Bundle.signature to have an upper bound | Resolved - change required | Bundle notes and, if published, Bundle diagram | Align residual current-version references with intentional deprecation and removal; original cardinality request is not persuasive | The deprecation and explanatory text were applied before FHIR-53722 intentionally removed the element. The worked example is outside this resolution. |

## Resolution and Comment Interpretation

1. **Original request:** The description asks to change cardinality from `0..1` to `0..*` to support multiple signers and purposes. The final resolution does not approve this change; it says the element is deprecated. Do not implement `0..*`.
2. **Final resolution:** "Per FHIR-51099, this element is deprecated. Ensure that Bundle.signature is flagged as deprecated and has text updated to reflect that." Treat the deprecation as intentional: it was applied in the source before FHIR-53722 intentionally removed the deprecated element. Do not recreate the removed element merely to retain its deprecated flag.
3. **2026-07-01 ticket comments:** The comment says the prior resolution was superseded by a rework of signatures; the quoted, reverted resolution proposed an `AdditionalSignature` extension. Neither the reverted extension proposal nor a new extension is the current resolution. No `AdditionalSignature` definition/reference was found in the local extension checkout during this review.
4. **FHIR-51099:** Its local ticket is marked `Applied`; it declined widening cardinality and pointed toward Provenance-based signatures. The commit history shows the deprecation state before the later removal (see timeline below).
5. **FHIR-53722:** Its local ticket is marked `Applied` and explicitly lists removal of `Bundle.signature`; its linked sub-ticket FHIR-55430 is named "Remove deprecated Bundle.signature". The current FHIR source and commit history confirm that removal.
6. **Current signing guidance:** The current [Signing Bundles section in signatures.html](../../../fhir-repo/source/signatures.html#L434) describes signing through `Provenance.signature`. Preserve that approved direction and do not reintroduce `Bundle.signature`.

## Current Source Mapping

| Current source location | Evidence and relevance | Planned treatment |
|---|---|---|
| [structuredefinition-Bundle.xml, lines 644-660](../../../fhir-repo/source/bundle/structuredefinition-Bundle.xml#L644) | The sequence proceeds from `Bundle.entry.response.outcome` to `Bundle.issues`; there is no `Bundle.signature` element. Commit `2bc9b966e3a50eb7f6ad5befcad3c27e583984fa` removed the entire 17-line element definition, including the deprecated status, former `0..1` cardinality, and replacement wording. | Treat removal as controlling current behavior. Do not add the element back or change its cardinality. |
| [bundle-notes.xml, lines 381-389](../../../fhir-repo/source/bundle/bundle-notes.xml#L381) | The "Signatures" section still says "The Bundle resource includes a signature element" and describes its purpose. This is inconsistent with the current StructureDefinition and the intentional FHIR-53722 removal. | Remove the false current-state assertion and point readers to the existing Provenance-based Bundle guidance. Do not invent new normative requirements. |
| [bundle-introduction.xml, lines 6-14](../../../fhir-repo/source/bundle/bundle-introduction.xml#L6) | The ballot note already records withdrawal of the deprecated element and links to FHIR-53722. It reflects the later approved removal, not a surviving deprecated field. | Retain this history. Do not rewrite it to imply that the element remains available. |
| [signatures.html, lines 434-465](../../../fhir-repo/source/signatures.html#L434) | The current "Signing Bundles" section describes the Provenance-signature method. It is consistent with FHIR-51099 and the removal. | Preserve existing guidance; use it as the destination for any approved explanatory cross-reference. |
| [signatures.html, lines 469-474](../../../fhir-repo/source/signatures.html#L469) | A ballot note says the worked example is based on the now-removed `Bundle.signature` and needs rework. It acknowledges an outstanding example issue, rather than asserting that the element currently exists. | Leave the ballot note and worked example unchanged; example rework is not included in this resolution. |
| [bundle.svg, lines 172-175](../../../fhir-repo/source/bundle/bundle.svg#L172) | The diagram still links to `bundle-definitions.html#Bundle.signature` and labels the field `[0..1]`. Blame attributes these lines to `213a15d7282` (2023-02-28); FHIR-53722 did not update this SVG. Whether this source SVG is still included in the current published Bundle page was not established from local source references. | Verify whether this SVG is a live publication input. If it is, remove the obsolete node/link to match the approved removal; do not change it to `0..*`. Confirm whether this correction belongs under FHIR-53722 or requires separate workgroup authorization. |
| [versions.html, line 689](../../../fhir-repo/source/versions.html#L689) | The `Bundle.signature` URL is explicitly under the R4 historical extension table. | Leave historical-version references intact; they do not claim the element exists in the current Bundle definition. |

## Historical Evidence and Blockers

### Timeline

| Date (date type) | Evidence | What it establishes |
|---|---|---|
| 2025-08-04 (**FHIR-51099 vote date**) | Local [FHIR-51099.md](../../../jira/closed/FHIR-51099/FHIR-51099.md); status `Applied`; resolution says not to relax cardinality and to use Provenance-based signatures. | The earlier 0..* request was declined in favor of deprecation and an alternate signing approach. |
| 2025-08-12 (**source commit date**) | Commit [`9fe4e8ba2ec241ab35dc18046c102c38872e1d50`](https://github.com/HL7/fhir/commit/9fe4e8ba2ec241ab35dc18046c102c38872e1d50), "deprecate Bundle.signature and adjustments to digital signatures page". | The source had already implemented the deprecated status and updated explanatory text. The local Jira record says `Applied`, but does not give a separate application date; the commit is the source-level evidence of application. |
| 2026-01-26 (**FHIR-53722 resolved date in local ticket**) / 2026-02-02 (**vote date in local ticket**) | Local [FHIR-53722.md](../../../jira/closed/FHIR-53722/FHIR-53722.md), status `Applied`, resolution explicitly directs removal of `Bundle.signature`. | The removal was separately approved as part of the R6 removal of deprecated elements. The ticket's local `Updated` date (2026-06-30) is not an application date. |
| 2026-07-01 (**source commit date**) | Commit [`2bc9b966e3a50eb7f6ad5befcad3c27e583984fa`](https://github.com/HL7/fhir/commit/2bc9b966e3a50eb7f6ad5befcad3c27e583984fa), "FHIR-53722 Deprecated elements should be withdrawn where applicable in R6". | The commit deletes the complete `Bundle.signature` definition from `structuredefinition-Bundle.xml`. This actual source change predates FHIR-42961's final vote by five calendar days. FHIR-53722 has no explicit application-date field in the local ticket export; the commit date proves when the source change landed, not when Jira status was changed. |
| 2026-07-01 (**FHIR-42961 comment dates**) | Two comments in [FHIR-42961.md](./FHIR-42961.md) mention superseding signature rework and the reverted `AdditionalSignature` proposal. | These comments predate the final vote and align with the contemporaneous removal; they do not reinstate the reverted extension proposal. |
| 2026-07-06 (**FHIR-42961 vote date**) | [FHIR-42961.md](./FHIR-42961.md): resolution `Not Persuasive with Modification`; vote 8-0-2; status `Resolved - change required`. | The final recorded resolution confirms the intentional deprecation/text direction already applied in source; the later removal is consistent with that lifecycle. |

### Intentional deprecation and subsequent removal

- **Ticket and link:** [FHIR-53722](https://jira.hl7.org/browse/FHIR-53722), with linked [FHIR-55430](https://jira.hl7.org/browse/FHIR-55430).
- **Commit:** `2bc9b966e3a50eb7f6ad5befcad3c27e583984fa` (2026-07-01, before the FHIR-42961 vote).
- **Changed behavior/text:** Removed the `Bundle.signature` StructureDefinition element, including its prior deprecated flag, short/definition text, and `0..1` cardinality.
- **Lifecycle interpretation:** The deprecation was intentional and was applied in source by FHIR-51099 before FHIR-53722 removed the deprecated element. FHIR-53722 is the intended next lifecycle step, not a reason to question or reverse FHIR-42961's deprecation resolution.
- **Implementation direction:** Do not restore the element or change its cardinality. Correct residual current-version Bundle prose (notably `bundle-notes.xml`) and, if confirmed live, remove the obsolete diagram depiction. Keep the signing route on `Provenance.signature`.
- **Application evidence/gap:** The local FHIR-53722 ticket status is `Applied`; the commit's exact source deletion is direct evidence. The export does not state an application date, and no local FHIR-55430 ticket file was found. Do not infer application date from `Resolved`, `Updated`, or the later FHIR-42961 vote date.
- **Metadata date discrepancy:** The local FHIR-53722 export records `Resolved: 2026-01-26` and `Vote Date: 2026-02-02`, placing the resolved date before the recorded vote. Preserve the exported dates as evidence, but do not infer a corrected date or workflow sequence from them.

### Remaining current-text inconsistencies in scope

1. **Bundle narrative:** `bundle-notes.xml` still states the current Bundle "includes" the removed field. FHIR-53722 commit `2bc9b966e3a50eb7f6ad5befcad3c27e583984fa` deleted the StructureDefinition element but left this narrative unchanged. Remove the obsolete description and link to the established Provenance-based signing guidance; do not introduce a new signing model or normative requirement.
2. **Diagram:** `bundle.svg` still depicts and links the old `0..1` field. The same FHIR-53722 commit did not touch this asset, leaving a depiction that conflicts with the intentional removal if the SVG is still published. Verify its publication role before changing it; if used, remove the obsolete depiction rather than replacing its cardinality.
3. **Worked example (out of scope):** The ballot note in `signatures.html` says the example needs rework based on the removed element. Leave both note and example untouched under FHIR-42961; any rework is separate from this resolution.

## Post-Vote History Audit

Local `fhir-repo` history was inspected through the planning snapshot HEAD `26e383455a6659d1763bb8446dca0a73fdfdc470` (2026-10-20; branch `FHIR-54535`). No fetch or checkout was performed. No post-vote commit in the inspected history reinstates or changes the `Bundle.signature` StructureDefinition element.

| Commit / ticket | Post-vote change found | Relevance |
|---|---|---|
| `b8d9ddca76b2256e92d55026a8f4cc6eabcb57f6`, FHIR-54064, 2026-07-08; local ticket status `Applied` | Corrected link punctuation and note placement in the JWS `Signature.data` guidance in `signatures.html`; the initial source commit `2e624d625dc3b18bac24b98b16bee5c0d75afba2` is dated 2026-07-03, before FHIR-42961's vote. | Does not alter Bundle.signature lifecycle or Provenance signing behavior. Not a blocker. |
| `19d54a0d4742b898252a5fe789636e977fa3abbe`, 2026-07-09, "PR tidy up" | Corrected "reoved" to "removed" in the ballot note about the already-removed element at `signatures.html:472`. | Editorial correction; confirms the note concerns a removed field, not a retained deprecated one. |
| `9e764522393ce5f6a0a15df33109d58b5669c01b`, `f0291841c40fefa81353ce1c53826597cc95889c`, `2cbd56aaa86eeeb21a2ad5e66f8802804105b76a`, 2026-07-16 | Added and formatted the Bundle ballot note at `bundle-introduction.xml:6-14`, explicitly recording withdrawal of the deprecated element and linking FHIR-53722. | Supporting post-vote documentation of removal; no contrary change. |
| `7c785c1c0035d18e0ac68118cd15ad420e3ffd18`, FHIR-58604, 2026-09-11; local ticket status `Applied` | Corrected "Provenence" to "Provenance" in the explanatory paragraph near `signatures.html:465`. | Editorial correction, not a lifecycle change. |
| `c265ea549850890ebef3c714a27a16da8db74d7f`, 2026-09-24 | General QA changed lowercase "shall" to `SHALL` in unrelated JWS/XML signature rule text. | Does not concern `Bundle.signature`; preserve as-is. |

## Execution Steps (for a separately authorized implementation)

1. Preserve the approved lifecycle: do not restore `Bundle.signature`, reapply its deprecation flag to a removed element, or change its cardinality.
2. Update the misleading current-version paragraph in `fhir-repo/source/bundle/bundle-notes.xml` to remove the claim that Bundle currently includes the element and point to the existing Provenance signing guidance.
3. Confirm whether `fhir-repo/source/bundle/bundle.svg` is included in the current Bundle publication. If it is, remove the obsolete node and link; otherwise leave it unchanged.
4. Leave the `signatures.html` ballot note and worked example unchanged; they are not included in this resolution.
5. Review the final diff for scope (only authorized files under `fhir-repo/source/`) and ensure historical-version references remain historical.

## Validation Checklist

- [ ] Ticket identity, FHIR Core specification, Bas van den Heuvel assignment, resolution, status, and 2026-07-06 vote date match the canonical ticket.
- [ ] No change widens `Bundle.signature` to `0..*` or restores the removed element.
- [ ] Any approved edit removes the false current-state claim from `bundle-notes.xml` and points only to existing Provenance guidance.
- [ ] The `bundle.svg` edit decision is based on confirming its role in the current published page; if changed, no obsolete `Bundle.signature` node/link remains.
- [ ] The `signatures.html` ballot note and worked example remain untouched; example rework is excluded from this resolution.
- [ ] The R4 historical reference in `versions.html` remains unchanged.
- [ ] No new normative statement is introduced without approval; any future source edits stay under `fhir-repo/source/`.
- [ ] After implementation is separately authorized, run the normal FHIR validation/build workflow and verify generated Bundle and Signatures pages against the source. No build was run for this planning task.

## Risks and Assumptions

- **Risk - residual references:** `bundle-notes.xml` and possibly `bundle.svg` may still imply that the removed element exists; verify the final source and publication output.
- **Assumption - intentional lifecycle:** The deprecation was intentional and previously applied; FHIR-53722's approved removal is its subsequent lifecycle step. FHIR-42961 does not authorize restoring the element.
- **Assumption - signing direction:** The existing Provenance-based guidance in `signatures.html` remains the intended current approach.
- **Scope exclusion:** Reworking the `signatures.html` worked example is not part of this resolution and must remain separate.
- **Evidence limitation:** This review used the local Jira exports and local `fhir-repo` history only; no network/Jira check, fetch, pull, build, or checkout was performed. The checkout was on `FHIR-54535` at the recorded HEAD, and the relevant source paths had no local diff at the time checked. Shared-workspace branch state may advance independently.
- **Application-date gap:** Local FHIR-53722/FHIR-51099 records show `Applied`, but do not provide an explicit date of application. Commit dates are source-history evidence and are not represented as Jira application dates.
- **Existing local execution artifact:** The existing implementation change log cites `fhir-fork/source/` and `jira/active/` paths; it was not used as evidence for current FHIR Core source state and was not modified by this planning task.
- **Open question:** Confirm whether `bundle.svg` is included in the current Bundle publication before deciding whether to edit it.
