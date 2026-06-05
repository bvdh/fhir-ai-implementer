# Implementation Plan: FHIR-55151

## Scope Summary
- Workgroup/source: FHIR Infrastructure; ticket source is jira/active/FHIR-55151/FHIR-55151.md
- Tickets in scope: FHIR-55151
- Primary fix pattern: Binding behavior change for CapabilityStatement.fhirVersion to support version-independent handling (no escape-valve concept addition)

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-55151 | CapabilityStatement.fhirVersion has no escape valve | Resolved - change required | capabilitystatement.html, capabilitystatement-definitions.html, versioning.html | Binding semantics update + explanatory wording | Resolution says to make binding version-independent and advise tooling to treat prior releases equivalently |

## Likely Edit Surface (Files and Lines)
1. Primary binding element
- fhir-fork/source/capabilitystatement/structuredefinition-CapabilityStatement.xml:642
- fhir-fork/source/capabilitystatement/structuredefinition-CapabilityStatement.xml:653
- fhir-fork/source/capabilitystatement/structuredefinition-CapabilityStatement.xml:662
2. Related operation binding consistency check
- fhir-fork/source/capabilitystatement/operationdefinition-CapabilityStatement-versions.xml:105
- fhir-fork/source/capabilitystatement/operationdefinition-CapabilityStatement-versions.xml:107
3. Related terminology artifact (verify only unless change is required)
- fhir-fork/source/capabilitystatement/codesystem-FHIR-version.xml:23
- fhir-fork/source/capabilitystatement/codesystem-FHIR-version.xml:30
4. Version guidance page check for alignment
- fhir-fork/source/versioning.html:41
- fhir-fork/source/versioning.html:34

## Shared Implementation Approach
1. Locate CapabilityStatement.fhirVersion binding and determine minimal representation for version-independent binding behavior.
2. Prefer minimal source edits in the structuredefinition file before touching shared terminology artifacts.
3. Only update operationdefinition or narrative guidance if needed to keep binding behavior and documentation consistent.
4. Do not add unknown/other concept codes unless explicitly required by resolved ticket text (current resolution indicates this is not required).

## Execution Steps
1. Confirm current binding semantics and canonical references:
- Review CapabilityStatement.fhirVersion binding at structuredefinition-CapabilityStatement.xml:653-663.
- Record current description/valueSet and any binding-related extensions.
2. Implement version-independent binding behavior for CapabilityStatement.fhirVersion:
- Update the binding representation for CapabilityStatement.fhirVersion in structuredefinition-CapabilityStatement.xml (line window around 653-663).
- Keep the element required and code-typed unless ticket scope explicitly changes datatype/cardinality.
3. Align documentation wording for tool behavior:
- If needed, update fhirVersion definition/comment text in structuredefinition-CapabilityStatement.xml around lines 645-646 to reflect version-independent interpretation for prior releases.
- If needed for clarity, update versioning.html around lines 34-41 to avoid implying strictly version-bound interpretation.
4. Cross-file consistency pass:
- Verify operationdefinition-CapabilityStatement-versions.xml binding remains coherent with the final strategy.
- Verify codesystem-FHIR-version.xml remains valid source of allowed versions unless resolution requires terminology-level changes.
5. Validation and artifact updates:
- Run targeted searches for fhirVersion binding references and ensure no contradictory wording remains in touched files.
- Update/change-log and commit-message artifacts after implementation (execution phase, not planning phase).

## Validation Checklist
- [ ] Ticket FHIR-55151 is mapped to at least one concrete file under fhir-fork/source/
- [ ] Planned edits are limited to fhir-fork/source/ files
- [ ] CapabilityStatement.fhirVersion binding behavior is represented as version-independent per resolution intent
- [ ] No unknown/other escape-valve concept was added unless explicitly re-approved
- [ ] OperationDefinition and narrative references are reviewed for consistency with final binding behavior
- [ ] No unrelated formatting or tooling files are modified
- [ ] Plan references exact file paths and likely line anchors for implementation

## Risks and Assumptions
- Risk: The specific technical mechanism for "version-independent binding" may require use of an existing extension/pattern that is not yet obvious from the local file alone.
- Risk: Adjusting only CapabilityStatement.fhirVersion could leave operationdefinition or narrative pages semantically inconsistent.
- Assumption: Ticket resolution intentionally avoids adding new value set concepts (unknown/other) and instead changes binding interpretation.
- Assumption: Existing FHIR-version code system content remains authoritative and likely does not need code-level changes.
- Open questions: Which exact binding pattern should be used to express version-independent behavior in this repository (extension-based, canonical change, or narrative-only clarification)?
