# Implementation Plan: FHIR-55155

## Scope Summary
- Workgroup/source: FHIR Infrastructure; ticket source is jira/active/FHIR-55155/FHIR-55155.md
- Tickets in scope: FHIR-55155
- Primary fix pattern: Clarify fallback behavior by adding element comment guidance (no terminology expansion)

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-55155 | CapabilityStatement.rest.resource.searchParam.type has no escape valve | Resolved - change required | capabilitystatement.html | Comment-only clarification | Resolution says to add a comment: "If down-converting from a version of FHIR that has additional types, they would map to 'special'" |

## Likely Edit Surface (Files and Lines)
1. Primary element comment addition
- fhir-fork/source/capabilitystatement/structuredefinition-CapabilityStatement.xml:1250
- fhir-fork/source/capabilitystatement/structuredefinition-CapabilityStatement.xml:1254
2. Related terminology artifact (verify only; no concept additions planned)
- fhir-fork/source/capabilitystatement/codesystem-search-param-type.xml:83
- fhir-fork/source/capabilitystatement/codesystem-search-param-type.xml:85

## Shared Implementation Approach
1. Add the ticket-specified fallback comment directly on `CapabilityStatement.rest.resource.searchParam.type`.
2. Keep required binding and value set canonical unchanged.
3. Do not add `unknown`/`other` concepts to SearchParamType terminology, because resolution specifies mapping to existing `special`.

## Execution Steps
1. Update `CapabilityStatement.rest.resource.searchParam.type` comment:
- In `structuredefinition-CapabilityStatement.xml`, add/adjust `<comment>` for this element to include: `If down-converting from a version of FHIR that has additional types, they would map to 'special'`.
- Keep existing convenience guidance intact where possible, appending the new sentence if that is the smallest clear diff.
2. Confirm terminology remains unchanged:
- Verify `codesystem-search-param-type.xml` still contains `special` concept definition and no new concepts are introduced for this ticket.
3. Cross-file consistency check:
- Verify the `short` list and binding canonical for `CapabilityStatement.rest.resource.searchParam.type` are unchanged except for intended comment clarification.

## Validation Checklist
- [ ] Ticket FHIR-55155 is mapped to at least one file under `fhir-fork/source/`
- [ ] Planned edits stay within `fhir-fork/source/`
- [ ] `CapabilityStatement.rest.resource.searchParam.type` has explicit down-conversion guidance to map additional types to `special`
- [ ] No `unknown` or `other` concept added to SearchParamType artifacts for this ticket
- [ ] Required binding canonical `http://hl7.org/fhir/ValueSet/search-param-type` remains unchanged
- [ ] No unrelated formatting/tooling/config changes

## Risks and Assumptions
- Risk: Existing comment wording is long; replacing instead of appending may accidentally remove useful prior guidance.
- Risk: Over-editing nearby searchParam elements could introduce unrelated diff noise.
- Assumption: Ticket intent is purely explanatory guidance and does not require terminology expansion.
- Assumption: Mapping additional unknown future types to `special` is sufficient for backward/down-conversion behavior.
- Open questions: Should the same down-conversion guidance also be reflected in other search parameter documentation pages, or is `CapabilityStatement.rest.resource.searchParam.type` sufficient per ticket scope?
