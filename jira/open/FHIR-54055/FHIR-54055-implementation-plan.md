# FHIR-54055 Implementation Plan

## Objective
Apply the approved technical correction for CapabilityStatement wording:

- From: "CapabilityStatements may represent the use of additional resource."
- To: "CapabilityStatements may represent the use of additional resources."

## Ticket
- Key: FHIR-54055
- Issue Type: Technical Correction
- Status: Resolved-Change Required
- Resolution: Unresolved (allowed by direct-resolution technical correction exception)

## Source of Approved Wording
- Ticket description in `jira/active/FHIR-54055/FHIR-54055.md`

## Owning Repository
- `fhir-fork`

## Planned File Changes
1. `fhir-fork/source/capabilitystatement/capabilitystatement-notes.xml`
   - Update singular phrase `additional resource` to plural `additional resources` in the sentence under "Using additional resources in CapabilityStatements".

## Validation Steps
1. Search for the updated sentence in `capabilitystatement-notes.xml`.
2. Confirm the old singular sentence no longer appears in that file.
3. Review diff scope to ensure only the intended line changed.

## Plan Conformance Mapping
- Step 1 maps to one text replacement in `capabilitystatement-notes.xml` and no other files under `fhir-fork/source/`.
