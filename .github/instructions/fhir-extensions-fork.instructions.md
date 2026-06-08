---
description: "Use when working on FHIR core extension tickets. Route extension-source changes to the fhir-extensions-fork repository by default."
name: "FHIR Extensions Fork Guidance"
applyTo: "fhir-extensions-fork/**"
---
# FHIR Extensions Fork Guidance

## Hard Rule
- FHIR core extensions are stored in the `fhir-extensions-fork` repository.
- If a ticket primarily changes FHIR core extensions, make that change in `fhir-extensions-fork` rather than `fhir-fork` unless the user explicitly overrides this.

## Scope Notes
- Treat `fhir-extensions-fork` as the default implementation location for extension-definition and extension-page updates.
- Keep edits minimal, traceable to ticket intent, and limited to the extension content required by the ticket.

## Coordination Rule
- If a ticket spans both FHIR core specification text and FHIR core extensions, identify which repo owns each part before editing.
- Do not move extension-related edits into `fhir-fork` just because the ticket also touches core specification prose.

## Build And Rendering Guidance
- The publisher is used to generate the IG for `fhir-extensions-fork`.
- Update publisher assets with `./_updatePublisher.sh` when needed.
- Build the IG with `./_genonce.sh`.
- Generated HTML output is written to the `output/` folder.
- The `temp/` folder contains valuable intermediate files that are often useful when investigating difficult rendering issues.
- The `input/` folder contains the source files for the IG, including the extension definitions and pages. Changes to these files are what drive updates to the generated IG. This is the only directory that should be edited when working on extension content.
- All files starting with `StructuredDefinition-` in the `input/` folder are extension definitions. Changes to these files will update the extension definitions in the generated IG.
- The files in the `input/` folder are organized in subfolder that indicate the resource the extension applies to. For example, `input/Patient/` contains extensions that apply to the Patient resource. This organization helps maintain clarity about which extensions are relevant to which resources.