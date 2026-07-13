# Implementation Plan: CONF-202509-WedQ3-AR-TARGETS

## Scope Summary
- Workgroup/source: FHIR Infrastructure; Confluence-derived tracking item at jira/active/CONF-202509-WedQ3-AR-TARGETS/CONF-202509-WedQ3-AR-TARGETS.md
- Tickets in scope: CONF-202509-WedQ3-AR-TARGETS
- Primary fix pattern: Define a new core extension in fhir-extensions-fork that allows additional resources to declare which core and additional-resource reference elements may target them

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| CONF-202509-WedQ3-AR-TARGETS | Define extension to declare allowed targets for additional resources | Resolved - change required (Confluence approved motion 13-0-0) | fhir-extensions-fork extension definitions (primary), FHIR-I WGM minutes and related Jira FHIR-55462 (context) | New extension definition | Motion requires WG approval for each affected element context before inclusion |

## Shared Implementation Approach
1. Treat this as an extension-definition task owned by `fhir-extensions-fork`, not a primary `fhir-fork` prose task.
2. Use the existing `additional-resource-compartment` extension as the closest structural model for an additional-resource declaration extension on `StructureDefinition`.
3. Preserve linkage with [FHIR-55462](../FHIR-55462/FHIR-55462.md) as the related core-specification guidance ticket, while keeping this plan focused on the extension artifact itself.
4. Include approval-tracking requirements from `fhir-extensions-fork/pull_request_template.md` because the motion explicitly requires responsible WG approval for target-element inclusion.

## Execution Steps
1. Inspect `fhir-extensions-fork/input/definitions/StructureDefinition/StructureDefinition-additional-resource-compartment.xml` as the nearest implementation pattern for an extension attached to `StructureDefinition`.
2. Define the new extension in `fhir-extensions-fork/input/definitions/StructureDefinition/` with a new `StructureDefinition-*.xml` file name that reflects allowed reference targets for additional resources.
3. Set extension metadata consistent with FHIR Infrastructure ownership and extension-pack conventions:
   - `structuredefinition-wg` = `fhir`
   - `publisher` and contact consistent with FHIR Infrastructure conventions
   - `context` on `StructureDefinition`
4. Model the extension contents so an additional resource definition can declare what core and additional-resource reference elements may use it as a target.
5. Choose value representation that is reviewable and computable for target declaration, likely using canonical references and/or repeating slices rather than prose-only text.
6. Ensure the design captures the motion constraint that the WG responsible for the referenced element must approve inclusion; if this cannot be fully encoded in the extension itself, document the enforcement point in extension description/comments and PR metadata.
7. Cross-check overlap with FHIR-55462 to ensure the extension design supports the normal-reference policy rather than reintroducing alternate-reference dependence.
8. Prepare ticket-local implementation artifacts after source design is stabilized.

## Likely Impacted Files and Lines
- Primary implementation target:
  - `fhir-extensions-fork/input/definitions/StructureDefinition/StructureDefinition-<new-extension>.xml`
- Primary structural reference/example:
  - `fhir-extensions-fork/input/definitions/StructureDefinition/StructureDefinition-additional-resource-compartment.xml` (existing pattern for additional-resource declarations on `StructureDefinition`)
- Review/approval workflow reference:
  - `fhir-extensions-fork/pull_request_template.md` (approval minutes and context ownership expectations)
- Related context only:
  - `jira/active/FHIR-55462/FHIR-55462.md`
  - `fhir-fork/source/references.html`

## Validation Checklist
- [ ] Plan scope is explicitly anchored to `fhir-extensions-fork`
- [ ] New extension is mapped to a concrete file location under `fhir-extensions-fork/input/definitions/StructureDefinition/`
- [ ] Existing `additional-resource-compartment` extension was reviewed as the structural baseline
- [ ] Plan accounts for WG approval requirements for affected reference-element contexts
- [ ] Plan distinguishes this extension-definition work from the related core-specification text change in FHIR-55462
- [ ] No unrelated `fhir-fork` prose changes are included in this plan by default

## Risks and Assumptions
- Risk: The motion describes required governance (“WG responsible for the element must approve”) that may not be fully enforceable by extension structure alone.
- Risk: The exact extension data model for representing allowed targets may need review to avoid duplicating existing `targetProfile` semantics in a confusing way.
- Risk: Naming and scope may overlap with existing additional-resource or reference-target concepts, requiring careful overlap review.
- Assumption: `StructureDefinition-additional-resource-compartment.xml` is the best existing pattern to copy/adapt for this new extension.
- Assumption: The primary implementation belongs in `fhir-extensions-fork`, with any corresponding prose updates handled separately or linked to FHIR-55462.
- Open questions:
  - What exact canonical URL/name should the new extension use?
  - Should approved target declarations reference elements, search parameters, or profiles as the computable unit?
  - How should WG approval be represented: metadata, narrative requirement, or a companion governance artifact?
