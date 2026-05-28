# Implementation Plan: FHIR-55116

## Scope Summary
- Workgroup/source: currentTickets.md batch planning run (unimplemented tickets only).
- Tickets in scope: FHIR-55116.
- Primary fix pattern: wording/abbreviation correction in operations narrative text.

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-55116 | Spelling/abbreviation issues on page: operations | Resolved - change required | `fhir-fork/source/operations.html` | wording/abbreviation correction | Resolution: Persuasive. Ticket specifics: `doesn't` |

## Concrete Target Mapping
| Search token | Replacement | Primary file target(s) | Verification scope |
|---|---|---|---|
| `doesn't` | `does not` | `fhir-fork/source/operations.html` | `fhir-fork/source/operations*` |

Mapping rule: apply replacement only to normative/narrative prose in operations content. If the token is not present in `fhir-fork/source/operations.html`, run a scoped search under `fhir-fork/source/operations*` and update only the semantically equivalent prose occurrence.

## Shared Implementation Approach
1. Resolve candidate edit locations from the concrete mapping table before any source change.
2. Apply minimal text-only replacement aligned with ticket intent and FHIR prose conventions.
3. Keep changes traceable and avoid unrelated formatting/tooling/build changes.

## Isolated Session Strategy (Pre-Dirty Overlap Safe)
Problem addressed: prior execution notes indicate pre-existing dirty overlap on `fhir-fork/source/operations.html`, so direct staging from the current tree is unsafe for ticket-isolated commits.

1. Run overlap pre-check before editing:
	- Capture current dirty file list.
	- Confirm whether `source/operations.html` is already dirty.
2. If overlap exists, do not stage from the dirty tree.
3. Create an isolated clean session at current `HEAD` (preferred: temporary git worktree for `fhir-fork`; fallback: temporary clean clone).
4. Re-apply only mapped FHIR-55116 change (`doesn't` -> `does not`) in isolated session.
5. Validate in isolated session with scoped search/readback for `operations*`.
6. Commit FHIR-55116 from isolated session.
7. Integrate isolated commit back to target branch via cherry-pick (preferred) or patch apply.
8. Re-verify final diff is limited to mapped operations target(s) and expected token replacement.

Safety rule: when overlap is present, never use broad staging (`git add .` or path globs) from a pre-dirty tree; stage only exact file/hunk from isolated clean-session output.

## Execution Steps
1. Confirm mapped target and run baseline scoped search for `doesn't` in `fhir-fork/source/operations*`.
2. Run pre-dirty overlap check for `source/operations.html` before any staging.
3. If overlap exists, switch to isolated-session strategy; otherwise continue in-place with exact-path staging only.
4. Apply mapped replacement (`doesn't` -> `does not`) with minimal diff.
5. Perform localized readback around replacement to preserve sentence intent.
6. Run targeted post-change search to confirm `doesn't` is absent from `fhir-fork/source/operations*`.
7. Run final diff-scope check to ensure only mapped operations file(s) are changed for this ticket.

## Validation Checklist
- [ ] Ticket mapped to concrete source file/page under `fhir-fork/source/`
- [ ] Planned edits stay within `fhir-fork/source/`
- [ ] Pre-dirty overlap check executed before staging
- [ ] If overlap exists, isolated-session workflow used
- [ ] No unrelated formatting/tooling/build changes
- [ ] Terminology and abbreviations are consistent with ticket intent
- [ ] `doesn't` absent from `fhir-fork/source/operations*` after edits
- [ ] Plan is review-ready and implementation-specific

## Risks and Assumptions
- Risk: Pre-existing dirty state on `source/operations.html` can cause mixed-ticket commits if not isolated.
- Risk: Multiple prose occurrences in operations scope may require careful sentence-level confirmation.
- Assumption: Ticket scope is limited to abbreviation expansion of `doesn't` in operations narrative.
- Open questions: If additional contraction forms are found nearby, should they be deferred to separate tickets unless explicitly in scope?
