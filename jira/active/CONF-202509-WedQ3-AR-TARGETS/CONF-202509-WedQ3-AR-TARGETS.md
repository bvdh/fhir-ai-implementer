# CONF-202509-WedQ3-AR-TARGETS: Define extension to declare allowed targets for additional resources

## Metadata

- **Source Type**: Confluence Minutes
- **Source Repository**: fhir-ai-implementer
- **Source Page**: FHIR Infrastructure Minutes WGM 202509 - Pittsburgh - FHIR Infrastructure
- **Source Anchor**: WedQ3
- **Source URL**: https://confluence.hl7.org/spaces/FHIRI/pages/358879917/FHIR+Infrastructure+Minutes+WGM+202509+-+Pittsburgh#FHIRInfrastructureMinutesWGM202509Pittsburgh-WedQ3
- **Assignee**: Unassigned
- **Created**: 2025-09 WGM
- **Description**: Confluence-derived implementation item captured from approved FHIR Infrastructure WGM minutes. The approved motion states that an extension will be defined for additional resources so they can declare which core and additional-resource reference elements may use them as targets. The motion also states that the work group responsible for the element must approve before inclusion.
- **Issue Type**: Confluence Motion
- **Key**: CONF-202509-WedQ3-AR-TARGETS
- **Related Artifact(s)**: Additional Resources
- **Related Jira Ticket(s)**: FHIR-55462
- **Related Confluence Ticket(s)**: CONF-202509-WedQ3-AR-DEFINITION-SPACE
- **Related Page(s)**: References
- **Related Section(s)**: Additional References; additional resource target declaration
- **Reporter**: FHIR Infrastructure WGM Minutes
- **Resolution**: Approved motion (13-0-0)
- **Resolution Description**: Define an extension for additional resources so they can declare what core and additional resource reference elements can use them as targets. The work group responsible for the element must approve before inclusion.
- **Status**: Resolved - change required
- **Summary**: Define extension to declare allowed targets for additional resources
- **Vote / Motion**: Bas van den Heuvel / David Pyke : 13-0-0
- **Work Group**: FHIR Infrastructure

- **Confluence**: https://confluence.hl7.org/spaces/FHIRI/pages/358879917/FHIR+Infrastructure+Minutes+WGM+202509+-+Pittsburgh#FHIRInfrastructureMinutesWGM202509Pittsburgh-WedQ3
- **Jira**: None - Confluence-derived tracking item

## Motion Text

- Motion to agree that we will define an extension for additional resources that they define what core and additional resource reference elements can use them as targets.
- Note that the WG responsible for the element must approve before inclusion.
- Bas van den Heuvel / David Pyke : 13-0-0

## Notes

- This file is intentionally structured to mirror Jira ticket markdown so it can be planned, tracked, and documented using the same repository workflow patterns.
- This item is Confluence-based rather than Jira-based and should retain explicit source references to the originating WGM minutes.
- Closely related Jira ticket: [FHIR-55462](https://jira.hl7.org/browse/FHIR-55462), which captures the core-specification text change allowing normal references to additional resources when declared in `StructureDefinition`.
- Closely related Confluence ticket: [CONF-202509-WedQ3-AR-DEFINITION-SPACE](../../active/CONF-202509-WedQ3-AR-DEFINITION-SPACE/CONF-202509-WedQ3-AR-DEFINITION-SPACE.md), which tracks the motion to require `http://hl7.org/fhir` as the additional-resource definition space.
- Based on current project instructions, implementation work for core extension definitions should typically occur in `fhir-extensions-fork` if extension-source changes are required.

## Comments

_No comments captured beyond the approved Confluence motion._
