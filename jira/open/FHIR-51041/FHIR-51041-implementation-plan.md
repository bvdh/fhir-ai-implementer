# Implementation Plan: FHIR-51041

## Scope Summary
- Workgroup/source: FHIR Infrastructure; ticket file jira/active/FHIR-51041/FHIR-51041.md
- Tickets in scope: FHIR-51041
- Primary fix pattern: Resolution-aligned wording and clarification insertion in Additional Resources section

## Pre-Execution Conformance Checklist
- [ ] In-scope ticket key confirmed: FHIR-51041
- [ ] Resolution Description used as primary wording authority
- [ ] Proposed diff hunks map to the two resolution-described edits only
- [ ] No hunk introduces FHIR-50572 normative keyword change scope

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-51041 | Additional resources is a misleading name | Resolved - change required | resource.html#additional (source: fhir-fork/source/resource/resource-introduction.xml) | Heading text correction + clarifying conformance paragraph | Align to resolution: capitalization of "Defined" and add explicit non-conformance statement for custom resources |

## Shared Implementation Approach
1. Use the ticket resolution text as canonical wording source.
2. Keep edits constrained to the Additional Resources section in resource introduction.
3. Preserve surrounding structure and avoid unrelated normative language changes.

## Execution Steps
1. In fhir-fork/source/resource/resource-introduction.xml, update heading text to: "Additional Resources Defined Outside This Specification".
2. Add the resolution-provided conformance paragraph at the end of the Additional Resources subsection (after the bullet list of related sections and before "Moving Additional Resources to FHIR Core").
3. Ensure inserted paragraph text matches ticket wording exactly for the approved statement about custom resources not being conformant.
4. Confirm no edits to the third bullet sentence about resource name usage (this belongs to FHIR-50572 scope).
5. Run targeted grep checks for heading and inserted paragraph.
6. Review scoped diff to ensure only the two intended hunks are present in this file.

## Likely Impacted Files and Lines
- Primary edit target: fhir-fork/source/resource/resource-introduction.xml
  - Heading line near current line 49
  - New paragraph insertion near current line 81
- No other file edits expected for this ticket

## Validation Checklist
- [ ] Plan and ticket key match (FHIR-51041)
- [ ] Both edits are inside fhir-fork/source/resource/resource-introduction.xml
- [ ] Heading uses "Defined" (capital D) exactly as resolution specifies
- [ ] Added paragraph matches approved resolution wording
- [ ] No FHIR-50572-specific normative language replacement is present in this execution
- [ ] Diff contains only two intended hunks in target file

## Risks and Assumptions
- Risk: Nearby Additional Resources wording from other tickets could be changed accidentally.
- Assumption: Existing in-progress changes in resource-introduction.xml are intended to satisfy this ticket.
- Assumption: Resolution text in ticket markdown is the approved source of wording.
- Open questions: None; resolution text explicitly provides both planned edits.
