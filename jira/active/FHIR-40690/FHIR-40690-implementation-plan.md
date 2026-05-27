# Implementation Plan: FHIR-40690

## Scope Summary
- Workgroup/source: direct ticket-key scope (FHIR-40690).
- Tickets in scope: FHIR-40690.
- Primary fix pattern: technical correction (typo fix and R5-to-R6 wording update).

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-40690 | Typos | Resolved - change required | Discovery required in `fhir-fork/source/` (exact sentence/section not present in ticket export) | technical correction | Resolution: Persuasive. Correct `fwe` -> `few` and update final sentence wording from R5 to R6 where the ticket text applies. |

## Shared Implementation Approach
1. Identify the authoritative source location by searching for distinctive ticket phrases and likely wording variants in `fhir-fork/source/`.
2. Apply minimal textual edits only at the confirmed location: typo correction and version reference update.
3. Verify no collateral wording or formatting changes outside the intended paragraph.

## Execution Steps
1. Confirm ticket intent from ticket markdown:
	- `cat jira/active/FHIR-40690/FHIR-40690.md`

2. Locate exact candidate text in source (primary pass):
	- `cd fhir-fork`
	- `rg -n "fwe|Last sentence relates to R5|presumably this should now be R6" source/`

3. Locate likely wording variants if primary pass has no result:
	- `rg -n "few" source/*.html source/**/*.html`
	- `rg -n "R5" source/*.html source/**/*.html`
	- Narrow to candidate paragraphs that contain both typo-like context and release-version wording.

4. Confirm exact edit surface before any change:
	- Open the shortest matching context block and verify it corresponds to the ticket-reported text.
	- Select only the smallest affected section in one source file unless the same sentence is duplicated intentionally in mirrored pages.

5. Planned textual edits at confirmed location:
	- Replace `fwe` with `few`.
	- Update the ticket-targeted final sentence from R5 context to R6 context (preserving surrounding meaning and style).
	- Avoid unrelated cleanup, punctuation normalization, or broad wording rewrites.

6. Post-edit verification (planned):
	- `rg -n "fwe" source/` should return zero matches for intended target content.
	- `rg -n "few|R5|R6" <target-file>` to ensure the corrected sentence reads coherently in context.
	- Review diff to confirm only ticket-intended lines changed.

## Validation Checklist
- [ ] Ticket mapped to at least one concrete file under `fhir-fork/source/`
- [ ] Planned edits stay within `fhir-fork/source/`
- [ ] No unrelated formatting/tooling/build changes
- [ ] Typo correction (`fwe` -> `few`) limited to intended sentence
- [ ] Version wording update (R5 -> R6) limited to intended final sentence
- [ ] Grep checks prepared to verify absence of unintended residual typo
- [ ] Plan is review-ready and tied to ticket intent

## Risks and Assumptions
- Risk: The ticket export omits the direct page/anchor, so phrase matching may surface multiple unrelated R5 references.
- Assumption: The typo and R5-to-R6 correction occur in prose content under a single primary source page in `fhir-fork/source/`.
- Open questions: If no matching sentence exists in current source, should implementation be recorded as already applied after evidence capture?