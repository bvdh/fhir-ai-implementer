# Implementation Plan: FHIR-55156

## Scope Summary
- Workgroup/source: FHIR Infrastructure; ticket source is jira/active/FHIR-55156/FHIR-55156.md
- Tickets in scope: FHIR-55156
- Primary fix pattern: Reuse existing `other` interaction code by adding it to system-level REST interaction value set and aligning bound element short enumeration

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-55156 | CapabilityStatement.rest.interaction.code has no escape valve | Resolved - change required | capabilitystatement.html | ValueSet membership expansion + short list alignment | Resolution explicitly references FHIR-55154 and says to use same code, adding it to this value set |

## Likely Edit Surface (Files and Lines)
1. CapabilityStatement bound element short list update
- fhir-fork/source/capabilitystatement/structuredefinition-CapabilityStatement.xml:1351
- fhir-fork/source/capabilitystatement/structuredefinition-CapabilityStatement.xml:1353
- fhir-fork/source/capabilitystatement/structuredefinition-CapabilityStatement.xml:1366
2. System-level interaction value set expansion
- fhir-fork/source/capabilitystatement/valueset-system-restful-interaction.xml:250
- fhir-fork/source/capabilitystatement/valueset-system-restful-interaction.xml:263
- fhir-fork/source/capabilitystatement/valueset-system-restful-interaction.xml:266
3. Reused code system concept verification (no new concept expected)
- fhir-fork/source/codesystem/codesystem-restful-interaction.xml:172

## Shared Implementation Approach
1. Reuse existing `other` concept in `restful-interaction` code system (do not create duplicate concept).
2. Add `other` to `ValueSet/system-restful-interaction` compose include list and maintained narrative table.
3. Update `CapabilityStatement.rest.interaction.code` short enumeration to include `other`.
4. Keep binding canonical unchanged and avoid unrelated type-level interaction edits.

## Execution Steps
1. Confirm reuse target exists:
- Verify `codesystem-restful-interaction.xml` already includes `<code value="other"/>` and ticket-consistent definition.
2. Update system-level value set:
- Edit `valueset-system-restful-interaction.xml` to include `<concept><code value="other"/></concept>` in `<compose><include system="http://hl7.org/fhir/restful-interaction">...`.
- Add matching narrative table row/link for `other` under the XHTML rendering block.
3. Align CapabilityStatement short enumeration:
- Edit `structuredefinition-CapabilityStatement.xml` for `CapabilityStatement.rest.interaction.code` short text to append `| other`.
- Keep required binding canonical `http://hl7.org/fhir/ValueSet/system-restful-interaction` unchanged.
4. Cross-file consistency checks:
- Verify `other` appears in system-level value set compose and narrative table.
- Verify `other` appears in `CapabilityStatement.rest.interaction.code` short list.
- Verify no new duplicate `other` concept was added to the code system.

## Validation Checklist
- [ ] Ticket FHIR-55156 is mapped to concrete files under `fhir-fork/source/`
- [ ] Planned edits stay within `fhir-fork/source/`
- [ ] `valueset-system-restful-interaction.xml` includes `other` in compose include concepts
- [ ] `valueset-system-restful-interaction.xml` narrative table includes `other` row/link
- [ ] `CapabilityStatement.rest.interaction.code` short list includes `other`
- [ ] `codesystem-restful-interaction.xml` is reused as-is (no duplicate `other` concept insertion)
- [ ] Required binding canonical remains `http://hl7.org/fhir/ValueSet/system-restful-interaction`
- [ ] No unrelated formatting/tooling/config changes

## Risks and Assumptions
- Risk: Missing narrative row update in value set while updating compose can create display/compose mismatch.
- Risk: Accidental edits to type-level interaction value set instead of system-level value set due to similar names.
- Assumption: FHIR-55154 implementation already introduced/validated the shared `other` code in the canonical code system.
- Assumption: Ticket scope is system-level interaction only (`CapabilityStatement.rest.interaction.code`), not resource-level interaction.
- Open questions: Should `other` be included in any additional summary or narrative pages beyond this value set and the bound CapabilityStatement element for consistency, or is this pair sufficient per prior ticket precedent?
