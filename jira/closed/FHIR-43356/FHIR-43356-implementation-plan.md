# Implementation Plan: FHIR-43356

## Scope Summary

- Workgroup/source: direct ticket-key request (FHIR-43356).
- Tickets in scope: FHIR-43356.
- Primary fix pattern: punctuation typo correction (missing closing parenthesis).

## Ticket Matrix

| Ticket     | Summary                        | Status                     | Target page(s)                                           | Change type             | Notes                                                                         |
| ---------- | ------------------------------ | -------------------------- | -------------------------------------------------------- | ----------------------- | ----------------------------------------------------------------------------- |
| FHIR-43356 | Typo (missing closing bracket) | Resolved - change required | fhir-fork/source/license.html (FHIR Trademark section)   | wording/typo correction | Persuasive; add missing `)` near fair-use text.                              |

## Shared Implementation Approach

1. Locate the exact trademark guidance bullet in the editable source file under `fhir-fork/source/`.
2. Apply the smallest possible text change: add the missing closing `)` only.
3. Preserve surrounding markup and wording to avoid unintended legal-text changes.

## Target File Mapping

- Primary target: `fhir-fork/source/license.html`
- Secondary verification target: rendered publication output corresponding to License page (verify-only; no direct edit)
- Mapping rationale: ticket description quote matches the trademark bullet text in the FHIR License/Trademark source page.

## Execution Steps

1. Open `fhir-fork/source/license.html` and navigate to the `FHIR Trademark` section.
2. Locate the bullet beginning with `You can use the trademarks "FHIR" and the ... FHIR logo ...` and continuing onto the next line with `(nominatively, or under the terms of ... fair use`.
3. Confirm the sentence has an opening `(` and lacks the closing `)` before the list item close.
4. Insert exactly one `)` immediately after the fair use link so the sentence reads with balanced parentheses.
5. Perform localized readback around the edited lines to ensure HTML list structure remains valid and wording is otherwise unchanged.
6. Run targeted verification:

   - `rg -n "nominatively, or under the terms of" fhir-fork/source/license.html`
   - `rg -n "fair use" fhir-fork/source/license.html`
   - `git -C fhir-fork diff -- source/license.html`

## Validation Checklist

- [ ] Primary target file is explicit: `fhir-fork/source/license.html`
- [ ] Planned edits stay within `fhir-fork/source/`
- [ ] Exactly one punctuation fix (`)`) is applied in the intended sentence
- [ ] No unrelated formatting/tooling/build changes
- [ ] Trademark wording and links remain unchanged apart from parenthesis balancing
- [ ] Plan is review-ready and implementation-specific

## Risks and Assumptions

- Risk: Similar text may exist in generated output; editing generated files would create drift from source.
- Assumption: `fhir-fork/source/license.html` is the authoritative source for this trademark bullet text.
- Open questions: If identical missing-parenthesis text appears in another editable source page, should it be included in this ticket or handled separately?
