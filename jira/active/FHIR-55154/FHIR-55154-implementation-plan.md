# Implementation Plan: FHIR-55154

## Scope Summary
- Workgroup/source: FHIR Infrastructure; ticket source is jira/active/FHIR-55154/FHIR-55154.md
- Tickets in scope: FHIR-55154
- Primary fix pattern: Add new terminology concept (`other`) for a required binding escape valve and align dependent value set + binding display text

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-55154 | CapabilityStatement.rest.resource.interaction.code has no escape valve | Resolved - change required | capabilitystatement.html | Terminology expansion + binding text alignment | Resolution says add `other` (not `unknown`) with specific definition to code system and value set |

## Likely Edit Surface (Files and Lines)
1. Primary code system concept addition
- fhir-fork/source/codesystem/codesystem-restful-interaction.xml:167
- fhir-fork/source/codesystem/codesystem-restful-interaction.xml:171
2. Bound value set concept inclusion
- fhir-fork/source/capabilitystatement/valueset-type-restful-interaction.xml:348
- fhir-fork/source/capabilitystatement/valueset-type-restful-interaction.xml:403
- fhir-fork/source/capabilitystatement/valueset-type-restful-interaction.xml:405
3. CapabilityStatement element binding/display alignment
- fhir-fork/source/capabilitystatement/structuredefinition-CapabilityStatement.xml:992
- fhir-fork/source/capabilitystatement/structuredefinition-CapabilityStatement.xml:994
- fhir-fork/source/capabilitystatement/structuredefinition-CapabilityStatement.xml:1007

## Shared Implementation Approach
1. Add `other` to the canonical RESTful interaction code system with the resolution-provided definition.
2. Include `other` in the `type-restful-interaction` value set compose list so the required binding permits it.
3. Align `CapabilityStatement.rest.resource.interaction.code` short/binding-facing text with updated allowed interaction set.
4. Keep scope limited to `fhir-fork/source/` and avoid unrelated terminology/system-interaction changes.

## Execution Steps
1. Update code system source:
- Edit `codesystem-restful-interaction.xml` to add a `<concept>` entry for code `other` with display `other` and definition: `An interaction type that is not one of the standard interaction types defined in this version of FHIR.`
- Place the concept in a stable location near other top-level REST interaction codes.
2. Update required value set:
- Edit `valueset-type-restful-interaction.xml` to add `<concept><code value="other"/></concept>` in the `<compose><include system="http://hl7.org/fhir/restful-interaction">...` block.
- If the narrative table in `<text><div>` is explicitly maintained in this source file, add matching row/anchor for `other`.
3. Align CapabilityStatement binding presentation:
- Edit `structuredefinition-CapabilityStatement.xml` at `CapabilityStatement.rest.resource.interaction.code` short text to include `other` in the enumerated list.
- Keep binding canonical `http://hl7.org/fhir/ValueSet/type-restful-interaction` unchanged.
4. Cross-file consistency checks:
- Confirm the new code appears in code system, value set compose, and `CapabilityStatement.rest.resource.interaction.code` short text.
- Confirm `unknown` is not added for this ticket.

## Validation Checklist
- [ ] Ticket FHIR-55154 is mapped to concrete files under `fhir-fork/source/`
- [ ] Planned edits stay within `fhir-fork/source/`
- [ ] `codesystem-restful-interaction.xml` contains new code `other` with ticket-specified definition
- [ ] `valueset-type-restful-interaction.xml` includes `other` in compose/include concepts
- [ ] `CapabilityStatement.rest.resource.interaction.code` short text includes `other`
- [ ] No `unknown` concept added for this ticket
- [ ] No unrelated formatting/tooling/config files modified

## Risks and Assumptions
- Risk: `valueset-type-restful-interaction.xml` has both narrative and compose content; updating compose without matching narrative row could create presentation mismatch.
- Risk: Changing short text enumeration in `CapabilityStatement` may need mirrored adjustments if generated artifacts rely on exact tokenized lists elsewhere.
- Assumption: Resolution intent applies specifically to type-level REST interaction binding (`ValueSet/type-restful-interaction`) rather than system-level interaction value set.
- Assumption: Bound value set canonical remains unchanged; only concept membership expands.
- Open questions: Should `other` also be added to `valueset-system-restful-interaction.xml`, or is scope intentionally limited to `CapabilityStatement.rest.resource.interaction.code` as written in ticket resolution?
