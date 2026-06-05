# Implementation Change Log: FHIR-53684

## Summary
- Plan: jira/active/FHIR-53684/FHIR-53684-implementation-plan.md
- Ticket: jira/active/FHIR-53684/FHIR-53684.md
- Execution date: 2026-06-05

## Files Changed
- fhir-fork/source/implementationguide/implementationguide-notes.xml

## Changes Applied
1. Added a new `Declaring conformance to guides` subsection to Implementation Guide notes.
2. Added guidance explaining that not all implementation guides are appropriate direct contractual implementation targets.
3. Added explicit guidance to reference child `CapabilityStatement` and/or `ActorDefinition` resources when they are the concrete conformance targets.
4. Added text stating implementation guides SHOULD declare intended purpose and use, and that `ImplementationGuide.useContext` can help surface these expectations in a computable way.
5. Reviewed related comments in `structuredefinition-ImplementationGuide.xml` (`ImplementationGuide.useContext`) and `structuredefinition-CapabilityStatement.xml` (`CapabilityStatement.implementationGuide`) and made no changes because wording was already consistent with ticket intent.

## Validation Performed
- Plan/ticket key alignment (`FHIR-53684`): PASS
- Targeted text checks in `implementationguide-notes.xml` (`Declaring conformance to guides`, `ImplementationGuide.useContext`, `CapabilityStatement`, `ActorDefinition`): PASS
- No new abstract element check (`ImplementationGuide.abstract`): PASS
- Scope diff check (`git -C fhir-fork diff --name-only` only includes `source/implementationguide/implementationguide-notes.xml`): PASS
- Build/publish validation (`./gradlew publish`): PASS (exit code 0)

## Notes
- Source edits were limited to `fhir-fork/source/` and tied directly to the ticket resolution.
- No reusable cross-ticket pattern requiring an instruction update was identified in this change.
