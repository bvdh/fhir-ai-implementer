# Implementation Plan: FHIR-40695

## Scope Summary
- Ticket: FHIR-40695
- Summary: dateTime typo in primitive data type notes
- Status: Resolved - change required
- Resolution: Persuasive
- Planning scope: Define the minimal specification edit required to correct the primitive datatype notes typo.
- Implementation boundary: Limit edits to `fhir-fork/source/` during execution.

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-40695 | dateTime typo in primitive data type notes | Resolved - change required | `fhir-fork/source/datatypes.html` (Notes bullet discussing leap seconds for datetime/instant/time) | Typographical terminology correction | Replace the misspelled primitive datatype token `datetime` with `dateTime` in the specific notes bullet. |

## Shared Implementation Approach
1. Locate the exact notes bullet in `fhir-fork/source/datatypes.html` containing: "Leap second are allowed in the datetime, instant and time types."
2. Apply the smallest possible text edit that changes only the datatype casing from `datetime` to `dateTime`.
3. Avoid any adjacent wording cleanup (including grammar) unless explicitly approved for this ticket.

## Execution Steps
1. Open `fhir-fork/source/datatypes.html` and navigate to the primitive datatype "Notes" list.
2. Find the leap-second bullet that currently references `datetime`.
3. Update only that token to `dateTime`.
4. Confirm no additional text changed in the bullet or nearby notes.
5. Run a focused search in `fhir-fork/source/` for the exact legacy phrase segment `in the datetime, instant and time types` to ensure this targeted typo is no longer present.

## Validation Checklist
- [ ] The plan maps FHIR-40695 to at least one concrete file in `fhir-fork/source/`.
- [ ] Planned edit is restricted to `fhir-fork/source/datatypes.html`.
- [ ] Edit scope is minimal (single-token terminology casing correction).
- [ ] No unrelated formatting/tooling/build changes are included.
- [ ] Post-edit search confirms the incorrect token is removed from the targeted sentence.
- [ ] Correct datatype spelling appears as `dateTime` in the updated bullet.

## Risks and Assumptions
- Risk: Nearby text could be unintentionally edited if broad formatting tools are used.
- Assumption: The ticket intent is limited to correcting `datetime` to `dateTime` and does not include grammar/style rewrites.
- Open question: None at planning stage; implementation can proceed with the minimal correction approach.
