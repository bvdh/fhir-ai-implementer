# Implementation Plan: FHIR-55168

## Scope Summary
- Workgroup/source: Direct ticket input (FHIR-55168)
- Tickets in scope: FHIR-55168
- Primary fix pattern: Binding/terminology alignment for ImplementationGuide.fhirVersion to support a version-independent approach (per Jira resolution)

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-55168 | ImplementationGuide.fhirVersion has no escape valve | Resolved - change required | implementationguide.html / implementationguide-definitions.html | Terminology binding update + narrative clarification | Resolution indicates binding should be version-independent and code system/value set should move to THO |

## Likely Impacted Files and Anchors
- fhir-fork/source/implementationguide/structuredefinition-ImplementationGuide.xml:455
  - Element anchor: ImplementationGuide.fhirVersion
  - Current binding target: http://hl7.org/fhir/ValueSet/FHIR-version
- fhir-fork/source/implementationguide/structuredefinition-ImplementationGuide.xml:678
  - Element anchor: ImplementationGuide.definition.resource.fhirVersion
  - Current binding target: http://hl7.org/fhir/ValueSet/FHIR-version
- fhir-fork/source/implementationguide/implementationguide-notes.xml:110
  - Narrative section describing ImplementationGuide.fhirVersion usage
- fhir-fork/source/terminologies/bindings.xml:813
  - Binding registry reference to #FHIR-version
- fhir-fork/source/terminologies/bindings.xml:1199
  - FHIR-version worksheet section
- fhir-fork/source/capabilitystatement/codesystem-FHIR-version.xml:4
  - Current in-core CodeSystem artifact (likely affected if terminology ownership shifts to THO)

## Shared Implementation Approach
1. Locate files under fhir-fork/source/ that define or describe ImplementationGuide.fhirVersion binding.
2. Apply the smallest set of edits needed to make binding version-independent and terminology ownership consistent with Jira resolution.
3. Keep all edits traceable to the ticket and avoid unrelated structural or formatting changes.

## Execution Steps
1. Confirm the authoritative THO canonical targets.
   - Determine the exact THO canonical URL(s) and versioning policy to reference for the replacement binding.
   - Validate whether both ImplementationGuide.fhirVersion and ImplementationGuide.definition.resource.fhirVersion should point to the same THO value set.
2. Update the primary binding in StructureDefinition.
   - Edit fhir-fork/source/implementationguide/structuredefinition-ImplementationGuide.xml at ImplementationGuide.fhirVersion (around line 455).
   - Replace the current ValueSet canonical with the approved version-independent THO target.
   - Keep binding strength and binding name unless WG guidance requires otherwise.
3. Update the dependent resource-level binding for consistency.
   - Edit the same file at ImplementationGuide.definition.resource.fhirVersion (around line 678).
   - Align this binding target to the same approved version-independent value set (or document intentional divergence if required).
4. Update explanatory narrative text.
   - Review and adjust wording in fhir-fork/source/implementationguide/implementationguide-notes.xml (around line 110) so examples and guidance remain consistent with the new binding semantics.
5. Reconcile terminology source artifacts.
   - Review fhir-fork/source/terminologies/bindings.xml entries (around lines 813 and 1199) to ensure they reflect the post-change terminology source and canonical references.
   - Review whether fhir-fork/source/capabilitystatement/codesystem-FHIR-version.xml remains normative source content or should be retained only as historical/generated input.
6. Perform consistency sweep.
   - Search for remaining direct dependencies on http://hl7.org/fhir/ValueSet/FHIR-version in ImplementationGuide-related definitions and ensure no contradictory references remain.
   - Confirm no edits are made outside fhir-fork/source/.

## Validation Checklist
- [ ] Ticket FHIR-55168 is mapped to at least one concrete edit surface
- [ ] Planned edits remain fully within fhir-fork/source/
- [ ] Both ImplementationGuide.fhirVersion binding points are updated or explicitly justified
- [ ] Narrative text and binding references are internally consistent
- [ ] Terminology registry/source references are aligned with THO ownership intent
- [ ] No unrelated formatting, tooling, or build changes are introduced
- [ ] Plan is actionable without reinterpretation and can be executed in order

## Risks and Assumptions
- Risk: The exact THO replacement canonical may be ambiguous without additional vocabulary guidance, creating risk of binding to the wrong value set.
- Risk: Updating only StructureDefinition bindings without terminology registry alignment could leave inconsistent publication artifacts.
- Assumption: Jira resolution text is authoritative for moving terminology ownership to THO and for requiring version-independent binding behavior.
- Assumption: Both binding sites in ImplementationGuide should remain aligned unless explicit WG guidance says otherwise.
- Open questions:
  - What is the exact THO ValueSet canonical (and optional version pinning policy) to use?
  - Should in-core code system/value set source artifacts be retained, deprecated, or removed from generation inputs in this ticket scope?
  - Is any additional narrative update needed on implementationguide.html besides implementationguide-notes.xml?
