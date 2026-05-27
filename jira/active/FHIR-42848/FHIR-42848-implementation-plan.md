# Implementation Plan: FHIR-42848

## Scope Summary
- Workgroup/source: currentTickets.md batch planning run (unimplemented tickets only).
- Tickets in scope: FHIR-42848.
- Primary fix pattern: wording/typo correction in SampledData invariant text.

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-42848 | Spelling error within the SampledData datatype | Resolved - change required | Primary: `fhir-fork/source/datatypes/sampleddata.xml`; Secondary (verify-only): `fhir-fork/source/datatypes.html` SampledData section | wording/typo correction | Resolution: Persuasive. Jira text references invariant `sdd-1` and token swap `SAHLL` -> `SHALL`. |

## Shared Implementation Approach
1. Edit the invariant source of truth in `fhir-fork/source/datatypes/sampleddata.xml`.
2. Anchor by invariant semantics (SampledData + interval/offsets rule), not by a single misspelled token.
3. Treat `fhir-fork/source/datatypes.html` as secondary verification context only (no direct edit unless the literal text is present there in this branch).

## Execution Steps
1. Open `fhir-fork/source/datatypes/sampleddata.xml` and navigate to the Invariants worksheet row for SampledData containing expression `interval.exists().not() xor offsets.exists().not()`.
2. Primary token attempt: if English text contains `A SampledData SAHLL have either an interval and offsets but not both`, change only `SAHLL` to `SHALL`.
3. Blocked-token fallback (prevents unknown-token/no-target-files): if `SAHLL` is not present, locate the same row by the expression and context (`SampledData`) and treat the ticket as already-applied wording (`A SampledData SHALL have either an interval and offsets but not both`). Do not force unrelated edits.
4. Secondary check: inspect `fhir-fork/source/datatypes.html` for the same literal invariant sentence. If absent, no action. If present with `SAHLL`, align to `SHALL`.
5. Perform localized readback around every touched line to ensure only the misspelling fix was made.
6. Run targeted searches:
	- `SAHLL` in `fhir-fork/source/**` should return zero matches for this invariant context.
	- `A SampledData SHALL have either an interval and offsets but not both` should resolve in `fhir-fork/source/datatypes/sampleddata.xml`.

## Validation Checklist
- [ ] Primary target file is explicit: `fhir-fork/source/datatypes/sampleddata.xml`
- [ ] Secondary verification target is explicit: `fhir-fork/source/datatypes.html` (SampledData section)
- [ ] Execution path handles both token states (`SAHLL` present vs already `SHALL`) without failure
- [ ] Planned edits stay within `fhir-fork/source/`
- [ ] No unrelated formatting/tooling/build changes
- [ ] Terminology and abbreviations are consistent with ticket intent
- [ ] Plan is review-ready and implementation-specific

## Risks and Assumptions
- Risk: Jira references invariant id `sdd-1`, while source anchor is represented by SampledData invariant row semantics rather than explicit id text in this file.
- Assumption: `fhir-fork/source/datatypes/sampleddata.xml` is the editable source of truth for this invariant in the current branch.
- Open questions: If this ticket is fully pre-applied in source, should execution mark it as no-op applied, or should it be closed as already resolved with evidence links?
