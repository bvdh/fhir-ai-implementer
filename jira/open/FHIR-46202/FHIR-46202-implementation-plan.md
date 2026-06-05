# Implementation Plan: FHIR-46202

## Scope Summary
- Workgroup/source: Direct ticket input (FHIR-46202), FHIR Infrastructure work group metadata from ticket file.
- Tickets in scope: FHIR-46202
- Primary fix pattern: Wording/value correction for a primitive datatype regex shown on the Datatypes page.

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-46202 | Correct regex in the documentation for code type | Resolved - change required | fhir-fork/source/datatypes.html (code datatype section, datatypes.html#code) | Technical correction (regex text/value) | Ticket requested regex permits all whitespace; implementation aligns to prose constraint using single-space separator |

## Shared Implementation Approach
1. Locate edit targets under fhir-fork/source/ only.
2. Update the code datatype regex documentation value to match the ticket-approved expression in the file primitives.xml.
3. Keep changes minimal and traceable to FHIR-46202 with no unrelated wording, formatting, or tooling edits.

## Execution Steps
1. Confirm current source location for the code datatype documentation row in fhir-fork/source/datatypes.html where the regex token [%regex code%] is rendered/referenced.
2. Trace where the concrete regex value for code is defined in source-controlled inputs used by the publisher for this token (expected in source-side definition artifacts); identify the exact source file containing the code primitive pattern.
3. Update the code primitive regex definition in primitives.xml to:
   - ^[^\s]+( [^\s]+)*$
4. Run a focused consistency check across source for the code primitive regex to ensure there is not a conflicting duplicate definition that would reintroduce mismatch.
5. Rebuild/publish as needed (existing local workflow uses ./gradlew publish) and verify the rendered Datatypes page shows the corrected regex at the code section.
6. Record ticket implementation notes in the ticket directory after implementation (outside planning step).

## Validation Checklist
- [ ] FHIR-46202 is mapped to at least one concrete edit target in fhir-fork/source/
- [ ] Planned edits stay within fhir-fork/source/
- [ ] Regex for code resolves to exactly ^[^\s]+( [^\s]+)*$ in rendered documentation
- [ ] No unrelated formatting, template, or tooling changes were introduced
- [ ] Any duplicate code-regex source definitions were checked and aligned
- [ ] Plan remains traceable to ticket intent and review-ready

## Risks and Assumptions
- Risk: The displayed value in datatypes.html is tokenized ([%regex code%]), so the actual change point may be in a less obvious source artifact; missing it could leave published output unchanged.
- Assumption: Because the datatype prose explicitly says "single spaces", the implemented regex should use a literal space separator instead of `\s`.
- Open questions: If multiple source definitions exist for code regex (e.g., schema vs page token source), should all be harmonized in this ticket or only the Datatypes documentation pathway?
