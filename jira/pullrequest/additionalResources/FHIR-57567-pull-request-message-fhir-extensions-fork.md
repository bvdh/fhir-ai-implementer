# Extensions Pack Pull Request
NOTE: In the check-lists below, work groups are asked to attest that they've checked for overlapping functionality.  This means that they've checked that the extension either does not overlap functionality of other existing core elements or extensions (including HL7 IG-published extensions) or clearly defines how to manage such overlap such that it's clear when implementers should use this extension in preference to other approaches.

## Tickets Addressed
- [FHIR-57567](https://jira.hl7.org/browse/FHIR-57567)

_(If there's more than one extension, repeat the following one for each that has different answers)_

**Extension Name**: additional-resource-reference-target
[ ] **-** New extension  _(complete 'new extension' section below)_
[x] **-** Updated extension  _(complete 'updated extension' section below)_

### New extension
**Approving Work Group**: FHIR-I
**Approval Minutes (link)**: https://confluence.hl7.org/spaces/FHIRI/pages/358879917/FHIR+Infrastructure+Minutes+WGM+202509+-+Pittsburgh#FHIRInfrastructureMinutesWGM202509Pittsburgh-WedQ3
_Indicate the work group(s) that are responsible for the extension context(s) if different from above work group_
| Work Group | Extension context(s) | Approval Minutes Link | Overlap checked? |
| ---------- | -------------------- | --------------------- |------------------|
| FHIR-I | Reference elements in core and additional resources | https://confluence.hl7.org/spaces/FHIRI/pages/358879917/FHIR+Infrastructure+Minutes+WGM+202509+-+Pittsburgh#FHIRInfrastructureMinutesWGM202509Pittsburgh-WedQ3 | Yes |

(FHIR-I is the work group if the context is Resource, DomainResource, or Element)_

### Updated extension
Please attest to one of the following:
[x] **-** This PR contains **no breaking changes** from the previous version of the extension
[ ] **-** This extension is marked as 'draft' and is not referenced in any known published specifications or used in any implementations.
[ ] **-** This PR does not meet ether of the above, but has received FMG approval as documented in their minutes here: _____

If the extension revision adds or removes scopes for content not owned by the work group requesting the change,
please indicate the approvals of the impacted work group(s) below:
| Work Group | Extension context(s) | Approval Minutes Link | Overlap checked? |
| ---------- | -------------------- | --------------------- |------------------|
| None (no scope changes in this ticket run) | N/A | N/A | N/A |

## Ticket Mapping
- Jira ticket: [FHIR-57567](https://jira.hl7.org/browse/FHIR-57567)
- Confluence motion tracker: CONF-202509-WedQ3-AR-TARGETS

## Execution Note for This Ticket Run
- Verification-only outcome: extension definition already existed in fhir-extensions-fork and no source edit was required for this run.
- Evidence reference: fhir-extensions-fork/input/definitions/StructureDefinition/StructureDefinition-additional-resource-reference-target.xml
