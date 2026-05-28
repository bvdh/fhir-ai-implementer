# Implementation Plan: FHIR-45952

## Scope Summary
- Ticket: FHIR-45952
- Summary: Supply hyperlink to RFC 2119
- Status: Resolved - change required
- Resolution: Persuasive
- Planning scope: Add hyperlinking for RFC 2119 references in relevant specification narrative text.
- Implementation boundary: Limit edits to `fhir-fork/source/` during execution.

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-45952 | Supply hyperlink to RFC 2119 | Resolved - change required | `fhir-fork/source/conformance-rules.html`, `fhir-fork/source/help.html` | Wording/presentation improvement (reference hyperlinking) | Convert plain-text RFC 2119 mentions to explicit hyperlinks (for example, to `https://www.rfc-editor.org/rfc/rfc2119`). Keep surrounding conformance-language wording unchanged unless needed to insert links. |

## Shared Implementation Approach
1. Locate RFC 2119 mentions in `fhir-fork/source/` and confirm where the ticket-relevant plain-text references occur.
2. Insert HTML hyperlinks for RFC 2119 at those references using stable RFC Editor URLs.
3. Keep edits minimal and local, preserving existing prose and markup structure.

## Execution Steps
1. Open `fhir-fork/source/conformance-rules.html` and find the conformance language paragraph containing "RFC 8174 clarification of RFC 2119" and "Unlike RFC 2119".
2. Add hyperlink markup for RFC 2119 in that paragraph while preserving sentence meaning and readability.
3. Open `fhir-fork/source/help.html` and find the glossary definition text that states conformance verbs are defined in RFC 2119.
4. Add hyperlink markup for RFC 2119 in this glossary entry.
5. Verify links render as intended and point to `https://www.rfc-editor.org/rfc/rfc2119` (or an agreed canonical RFC 2119 URL).
6. Run a focused search for plain "RFC 2119" occurrences in `fhir-fork/source/` and confirm intended references in touched files are now linked.
7. Confirm no unrelated text edits, punctuation changes, or formatting-only churn were introduced.

## Validation Checklist
- [ ] The plan maps FHIR-45952 to concrete files under `fhir-fork/source/`.
- [ ] Planned changes are limited to hyperlinking RFC 2119 references.
- [ ] `fhir-fork/source/conformance-rules.html` is updated with RFC 2119 link(s) in the conformance language section.
- [ ] `fhir-fork/source/help.html` is updated with an RFC 2119 link in the glossary entry.
- [ ] Added links resolve to the intended RFC 2119 target.
- [ ] No unrelated specification content or tooling/build files are changed.

## Risks and Assumptions
- Risk: Over-linking every textual occurrence of "RFC 2119" could reduce readability; scope should prioritize the ticket-relevant normative references.
- Assumption: The accepted destination is the RFC Editor page (`https://www.rfc-editor.org/rfc/rfc2119`) as suggested in the ticket description.
- Open question: If local style guidance prefers linked first mention only per section/page, apply that convention during implementation.
