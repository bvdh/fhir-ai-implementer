# Implementation Plan: FHIR-55095

## Scope Summary
- Workgroup/source: currentTickets.md batch planning run (unimplemented tickets only).
- Tickets in scope: FHIR-55095.
- Primary fix pattern: wording/typo correction in datatypes narrative and datatype definition sources.

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-55095 | Spelling/abbreviation issues on page: datatypes | Resolved - change required | `fhir-fork/source/datatypes.html`, `fhir-fork/source/datatypes/address.xml`, `fhir-fork/source/datatypes/humanname.xml`, `fhir-fork/source/datatypes/identifier.xml` | wording/typo correction | Resolution: Persuasive. Ticket specifics: "isn't" "processer" |

## Concrete Target Mapping
| Search token | Replacement | Primary file target(s) | Verification scope |
|---|---|---|---|
| `isn't` | `is not` | `fhir-fork/source/datatypes.html`, `fhir-fork/source/datatypes/address.xml`, `fhir-fork/source/datatypes/humanname.xml` | `fhir-fork/source/datatypes*` |
| `processer` | `processor` | `fhir-fork/source/datatypes/identifier.xml` and `fhir-fork/source/datatypes.html` (if duplicate generated narrative exists) | `fhir-fork/source/datatypes*` |

Mapping rule: if a token is not found in a primary file target, run scoped search only under `fhir-fork/source/datatypes*` and update the nearest semantically equivalent sentence in that scope.

## Shared Implementation Approach
1. Resolve candidate edits from the concrete mapping table before making changes.
2. Apply minimal text-only replacements aligned with ticket intent and terminology conventions.
3. Keep changes traceable, avoid unrelated formatting/tooling changes, and restrict scope to datatypes targets.

## Isolated Session Strategy (Pre-Dirty Overlap Safe)
Problem addressed: local pre-existing dirty files may overlap the same datatypes files required by this ticket, making direct staging unsafe.

1. Detect overlap before edits:
	- Capture dirty file list in the current working tree.
	- Compare against mapped targets in `fhir-fork/source/datatypes*`.
2. If overlap exists, do not stage from the dirty tree.
3. Create an isolated clean work session from current HEAD (preferred: temporary git worktree for `fhir-fork`; fallback: temporary branch in a clean clone).
4. Re-apply only mapped FHIR-55095 edits in the isolated session.
5. Validate with scoped searches/readback in isolated session.
6. Commit ticket changes in isolated session.
7. Integrate safely:
	- Preferred: cherry-pick the isolated commit back to the intended branch.
	- Alternative: export patch from isolated commit and apply with 3-way merge.
8. Re-check resulting diff contains only mapped ticket files and token replacements.

Safety rule: never use broad `git add .` or path-globs from a pre-dirty tree when overlap is present; stage exact files/hunks only from isolated clean-session output.

## Execution Steps
1. Confirm mapped targets and run baseline searches for `isn't` and `processer` under `fhir-fork/source/datatypes*`.
2. Run overlap pre-check against current dirty files.
3. If overlap is present, switch to isolated-session strategy; if no overlap, continue in-place with exact-path staging.
4. Apply mapped replacements (`isn't` -> `is not`, `processer` -> `processor`) with minimal diff.
5. Perform localized readback around each replacement to preserve sentence intent.
6. Run targeted post-change searches to confirm absence of flagged terms in `fhir-fork/source/datatypes*`.
7. Perform diff scope check to ensure only mapped datatypes files are changed for this ticket.

## Validation Checklist
- [ ] Ticket mapped to concrete source files/pages under `fhir-fork/source/`
- [ ] Planned edits stay within `fhir-fork/source/`
- [ ] Pre-dirty overlap check executed before staging
- [ ] If overlap exists, isolated-session workflow used
- [ ] No unrelated formatting/tooling/build changes
- [ ] Terminology and abbreviations are consistent with ticket intent
- [ ] `isn't` absent from `fhir-fork/source/datatypes*` after edits
- [ ] `processer` absent from `fhir-fork/source/datatypes*` after edits
- [ ] Plan is review-ready and implementation-specific

## Risks and Assumptions
- Risk: Generated/narrative duplication can place target text in multiple datatypes files.
- Risk: Pre-existing dirty changes in target files can cause accidental mixed commits if not isolated.
- Assumption: The ticket remains strictly scoped to explicit terms `isn't` and `processer` in datatypes content.
- Open questions: Should nearby non-ticket spelling cleanups discovered during scoped search be deferred to separate tickets?
