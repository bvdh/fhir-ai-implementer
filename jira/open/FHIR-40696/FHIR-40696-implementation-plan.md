# Implementation Plan: FHIR-40696

## Scope Summary
- Workgroup/source: FHIR Infrastructure / Jira ticket FHIR-40696
- Tickets in scope: FHIR-40696
- Primary fix pattern: Broken inline link markup correction on Datatypes page (instant primitive value domain note)

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-40696 | Broken link to time zone extension | Resolved - change required | datatypes.html#primitive (section 2.1.28.0.1) | Link markup correction | Replace literal `[[[http://hl7.org/fhir/StructureDefinition/timezone extension]]]` with extension anchor using `[%extensions-location%]` format and matching label |

## Shared Implementation Approach
1. Locate the affected text in `fhir-fork/source/datatypes.html` under primitive type notes for `instant`.
2. Update link syntax to the required extension anchor style: `<a href="[%extensions-location%]StructureDefinition-<extension-name>.html"><extension-name></a>`.
3. Keep the change minimal and limited to the intended sentence.

## Execution Steps
1. Open `fhir-fork/source/datatypes.html` and find the instant datatype paragraph that currently contains the broken literal triple-bracket text.
2. Replace only the broken fragment with the required extension anchor format using `[%extensions-location%]` (for timezone: `StructureDefinition-timezone.html` and hyperlink text `timezone`).
3. Confirm there are no remaining occurrences of `[[[http://hl7.org/fhir/StructureDefinition/timezone extension]]]` in `fhir-fork/source/`.
4. Review neighboring text to ensure punctuation/spacing still reads correctly after replacement.
5. Verify the extension URL target exists in generated output (or extension pack path used by `[%extensions-location%]`).
6. Verify hyperlink text matches the extension name in the URL (`timezone` for `StructureDefinition-timezone.html`).
7. Run a local publish/validation step as appropriate for this workflow (at least link-generation validation if full publish is not practical).

## Validation Checklist
- [ ] Ticket FHIR-40696 maps to at least one concrete file/page (`fhir-fork/source/datatypes.html`)
- [ ] Planned edit is inside `fhir-fork/source/` only
- [ ] No unrelated formatting or tooling changes are included
- [ ] Broken timezone extension text is replaced with `[%extensions-location%]` extension anchor format
- [ ] Search confirms no residual broken literal remains
- [ ] Target extension URL resolves to an existing extension page in output
- [ ] Hyperlink label matches extension name in the URL (`timezone`)
- [ ] Result is review-ready and traceable to ticket intent

## Risks and Assumptions
- Risk: `datatypes.html` may contain generated or mirrored text in additional source templates, requiring a second targeted edit.
- Assumption: `[%extensions-location%]StructureDefinition-timezone.html` resolves in the expected published context.
- Open questions: None currently.
