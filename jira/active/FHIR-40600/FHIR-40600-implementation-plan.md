# Implementation Plan: FHIR-40600

## Scope Summary
- Ticket: FHIR-40600
- Summary: Typo in Resource Definitions spec
- Status: Resolved - change required
- Resolution: Persuasive
- Planning scope: correct typo `uppwer case letter` -> `upper case letter` in the "Key to Type Icons" bullet text.
- Implementation boundary: limit edits to `fhir-fork/source/` only.

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-40600 | Typo in Resource Definitions spec | Resolved - change required | `fhir-fork/source/formats.html` (Key to Type Icons list) | Typographical correction | Replace `uppwer case letter` with `upper case letter` only. |

## Concrete Target File Mapping
- Primary edit target:
  - `fhir-fork/source/formats.html`
  - Reason: contains `Key to Type Icons` section with typo token.

## Shared Implementation Approach
1. Navigate to `Key to Type Icons` section in `formats.html`.
2. Locate exact phrase `uppwer case letter`.
3. Apply minimal single-token typo correction.
4. Preserve punctuation and surrounding wording.

## Execution Steps
1. Open `fhir-fork/source/formats.html`.
2. Find `Key to Type Icons` bullet containing `uppwer case letter`.
3. Replace with `upper case letter`.
4. Re-check nearby lines to ensure no unrelated edits.
5. Search for residual typo in source scope.

## Validation Checklist
- [ ] `fhir-fork/source/formats.html` contains corrected phrase `upper case letter`.
- [ ] Search check: `rg -n "uppwer case letter" fhir-fork/source` returns no matches.
- [ ] Diff is limited to typo correction in targeted section.
- [ ] No files outside `fhir-fork/source/` are edited for source implementation.

## Risks and Assumptions
- Risk: generated outputs may also include the typo, but source edit should be made in canonical source only.
- Assumption: `formats.html` is the source-controlled content for the reported typo.
- Open question: none at planning stage.
