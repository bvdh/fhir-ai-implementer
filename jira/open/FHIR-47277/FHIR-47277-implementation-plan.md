# Implementation Plan: FHIR-47277 — Async-bundle mandates single outcome behavior

## Scope Summary

- **Ticket:** [FHIR-47277](./FHIR-47277.md), “Async-bundle -> mandate single outcome behavior”
- **Eligibility:** Eligible in the supplied ticket snapshot: Specification is FHIR Core; assignee is Bas van den Heuvel; Resolution is Persuasive; Status is Resolved - change required.
- **Vote date:** 2024-11-04, as recorded in the ticket. This is distinct from the source commit date and any publication date.
- **Resolution:** Upgrade the two SHOULDs in the status-completion paragraph to SHALLs:
  > A successful completion of the status request SHALL be used whenever processing has completed, regardless of whether the underlying interaction has succeeded or failed. A server SHALL use the status and outcome elements of Bundle.entry[0].response to communicate any processing errors.
- **Primary fix pattern:** Normative wording change in the asynchronous interaction response documentation.
- **Current planning constraint:** The historical target page `fhir-repo/source/async-bundle.html` is not present in the current checkout. The current parent page links to the API Incubator copy instead. Do not recreate the removed core page or edit the parent-page link without a confirmed scope decision.
- **Planning-only boundary:** This plan does not authorize source, ticket-record, branch, or Git changes. Any eventual specification edit remains limited to the appropriate specification-source directory. The FHIR repository instruction also requires explicit user approval before editing normative language.

## Ticket Matrix

| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-47277 | Async-bundle -> mandate single outcome behavior | Resolved - change required | Historically `source/async-bundle.html`, “Status Request” → “Response - Complete”; current core page links externally at `fhir-repo/source/async.html:44-52` | SHOULD → SHALL | Exact approved wording is present in merged FHIR source history. Current source target has been removed from this checkout. |

## Resolution-to-Source Mapping and Evidence

### Current source state

- `fhir-repo/source/async-bundle.html` does not exist at the current local FHIR repository HEAD (`26e383455a6659d1763bb8446dca0a73fdfdc470`).
- The current parent page `fhir-repo/source/async.html:44-48` links “Asynchronous Interaction Request” to `https://build.fhir.org/ig/HL7/api-incubator/async-bundle.html`. Lines 50-52 state that both asynchronous patterns are defined in the API Incubator while their details are finalized through implementation testing.
- No `async-bundle.html` file was found elsewhere in the checked-out workspace. The API Incubator source repository is not present, so its current source text and line numbers cannot be verified from this workspace.

### Historical target and already-satisfied change

- In the `FHIR-47277` merge (`f7f575d1cecd0feb58499f7ec7a051f1b27b0aff`), the affected paragraph was `source/async-bundle.html:179` (one long paragraph line); the preceding heading was “Status Request” and the paragraph followed “Response - Complete”. In the later, pre-relocation revision (`270e0ceb7b029dad4ca0fc5ccf5296ff370888cd^`), the paragraph occupies lines 179-183.
- The requested two SHALL statements appear there verbatim. The section also specifies the first bundle entry as the outcome and is followed by an example using a completed `200 OK` status response with operation error details in the bundle.
- Commit `0d9ff4d6665153d63481eab42d9507f2df20427e` (“change SHOULDs into SHALL”) changed the requested SHOULDs on 2024-11-05. The source history shows `FHIR-47277` PR `HL7/fhir#3212` merged on 2024-11-14. The PR merge commit is an ancestor of the current local FHIR HEAD, so the change was applied to the checked-out FHIR history before the page was later removed.
- Evidence identifiers:
  - Ticket snapshot SHA-256: `1c6ce36bba0f610684237c0315ef4f18dc5c9cb48f09c3e2a77acb8999820ed9`
  - `FHIR-47277` change commit: `0d9ff4d6665153d63481eab42d9507f2df20427e`
  - `FHIR-47277` PR merge commit: `f7f575d1cecd0feb58499f7ec7a051f1b27b0aff`
  - Resulting merged `async-bundle.html` blob: `7a4c3a2b42315cd049d44ff9d9dac24fc1df6883`
  - Pre-relocation `async-bundle.html` blob: `1f34f64082ed7642f1382ae5c617b6f129a4c067`
  - Current `async.html` blob: `d8ba4dbfeebc7d48b0e21def7e126a7bfaabbc33`

## Historical Findings and Blockers

1. **The requested change is already present in FHIR source history.** The Nov. 5, 2024 commit followed the ticket’s Nov. 4 vote date; the PR merged Nov. 14. The commit/merge dates establish source application, not the date of publication. The local FHIR-47277 ticket record still says “Resolved - change required” and has no Applied for Version field, so ticket-record reconciliation and publication status are not established by this workspace. Do not repeat the change in core without first resolving the current target.

2. **FHIR-47276 added approved explanatory detail in the same response section.** Its ticket is locally marked Applied. Its Nov. 5, 2024 source commit (`38182bb49ab298faceb8522ec6686df7ba7cf854`) added text describing the first response entry and its status, outcome, location, and optional resource; PR `HL7/fhir#3211` merged Nov. 8. This text coexists with the FHIR-47277 SHALL wording in the later merged page. Preserve it if the authoritative current page contains the same behavior; do not replace the section with only the two ticket sentences.

3. **FHIR-47272 changed adjacent Accept-header behavior.** The Feb. 24, 2025 commit `bfb0c7ce68a9822860aa821914440495b3ab7e81` expands the meaning of the kick-off `Accept` header to cover the eventual asynchronous response and adds status-request guidance: omit `Accept`, or use the same value as the kick-off request. These edits are adjacent to, but do not replace, FHIR-47277’s outcome/error requirement. Preserve them if the current authoritative page includes them. The local FHIR-47272 record remains “Resolved - change required”; the commit is source-application evidence, not proof that its Jira record or publication state was updated.

4. **FHIR-41202 added related conformance guidance to the parent page.** Its Mar. 2, 2025 commit (`3512b7ea6d43b0409809b60ae404037102e91f63`) added the `OperationDefinition.synchronicity` and synchronicity-extension descriptions to `source/async.html`. Its local ticket record is marked Applied for R6. This does not alter the outcome paragraph, but the existing conformance text and current parent-page content should not be disturbed as part of this ticket.

5. **The R6 source relocation is the primary implementation blocker.** Commit `270e0ceb7b029dad4ca0fc5ccf5296ff370888cd`, authored and committed 2025-10-31 with subject “normative changes for R6”, deletes `source/async-bundle.html`. In that same change, the parent page points to the API Incubator’s external `async-bundle.html` URL. The commit subject does not identify a Jira ticket, and no corresponding Applied/Published Jira record was found in the local ticket materials. Because the current checkout has neither the target page nor the API Incubator source repository, the current normative text, target file, line numbers, and publication status cannot be confirmed.

**Suggested direction:** Treat the core-source wording as historically implemented, not as a pending edit to reintroduce in `fhir-repo`. Before implementation, confirm whether the desired current target is the API Incubator source and identify its authoritative working repository. If approved, compare its current status-completion language to the ticket resolution and change only what is missing, preserving the later FHIR-47276 response details, FHIR-47272 header rules, and other currently approved content. If the current target already expresses the resolution, make no source change and resolve the ticket/application-record discrepancy through the normal Jira workflow.

## Execution Steps

1. **Resolve target ownership and version before editing.** Confirm whether this ticket is intended to affect the API Incubator’s current asynchronous interaction page, a specific FHIR version, or only to document the historical core application. Do not use the removed core page as a new target by default.
2. **Inspect the authoritative current target.** In its approved source checkout, locate “Status Request” → completion response and record the actual file, section, and line numbers. Compare that text with the ticket’s approved resolution and examples.
3. **Assess satisfaction before changing anything.** If the target already requires a successful completion response whenever processing completes, regardless of operation success, and requires the response status/outcome to communicate processing errors, record the ticket intent as already satisfied; make no duplicate edit.
4. **If a gap remains and implementation is explicitly authorized,** apply only the minimal ticket-approved normative wording change in the authoritative source. Preserve FHIR-47276’s first-entry/result details and FHIR-47272’s Accept-header behavior wherever present. Do not restore `fhir-repo/source/async-bundle.html` or alter `fhir-repo/source/async.html` links as a workaround.
5. **Review related examples and response semantics.** Confirm the examples consistently show a successful status-request response after processing completes, with the underlying operation’s success/failure and any processing `OperationOutcome` conveyed through `Bundle.entry[0].response`.
6. **Validate in the target repository.** Run the target specification’s standard validation/build only after source is changed and with the relevant repository workflow. Review the generated/rendered page and diff for unintended changes. No build was run during this planning-only task.
7. **Reconcile records separately if requested.** The local FHIR-47277 and FHIR-47272 records do not reflect the source history’s apparent application. Do not change Jira or local ticket records as part of this plan without authorization.

## Validation Checklist

- [ ] Confirm authoritative current repository, page, version, and source file before editing.
- [ ] Verify the approved outcome/error requirements against current target text; avoid duplicating already-satisfied wording.
- [ ] If a change is needed, verify the two ticket-approved SHALL requirements are both present and unambiguous.
- [ ] Verify completed processing uses a successful status-request completion response even if the underlying interaction failed.
- [ ] Verify processing errors are communicated through `Bundle.entry[0].response.status` and `.outcome`, consistently with the examples.
- [ ] Preserve later approved response-entry details (FHIR-47276) and Accept-header rules (FHIR-47272).
- [ ] Preserve existing parent-page conformance guidance (FHIR-41202) and external API Incubator link unless separate scope is approved.
- [ ] Run the authoritative target repository’s build/render validation only after implementation; inspect output and source diff.
- [ ] Keep changes within the authoritative specification source directory; do not change generated output, ticket records, plans, or workflow state as part of implementation unless separately authorized.

## Risks and Assumptions

- **Risk — wrong repository/version:** The current FHIR core page delegates the pattern details to API Incubator. Editing or recreating the removed core page could contradict the R6 organization.
- **Risk — duplicate or conflicting normative text:** The ticket’s approved wording is already present in merged source history, alongside later changes in the same section.
- **Assumption — source history is the available application evidence:** Local commit ancestry proves the changes existed in FHIR source history, but does not establish when or whether a particular published build contained them.
- **Record discrepancy:** FHIR-47277’s local ticket snapshot is Resolved - change required with no Applied for Version entry, while its source commit and merged PR show the wording was applied in the local FHIR history. The FHIR-47272 local record has a similar unresolved status/source-history discrepancy. No live Jira checks were performed.
- **Comments limitation:** The supplied FHIR-47277 export says there are no comments; no live Jira comments were retrieved.
- **History limitation:** Findings are based on the local FHIR clone at branch `FHIR-54535`, HEAD `26e383455a6659d1763bb8446dca0a73fdfdc470`. No fetch, pull, checkout, or external publication verification was performed.
- **Open questions:**
  1. Is the intended current target the API Incubator source, and which authoritative repository/version should own any future change?
  2. Should the ticket be treated as historically satisfied, or is a current API Incubator update still required?
  3. Before any source edit, does the user explicitly approve the normative SHALL wording change under the FHIR repository’s normative-language approval rule?
