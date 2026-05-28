---
description: "Use when working in fhir-fork. Enforce fork edit boundaries and keep changes limited to specification source content."
name: "FHIR Fork Boundaries"
applyTo: "fhir-fork/**"
---
# FHIR Fork Guidance

## Hard Rule
- Only modify files under `fhir-fork/source/`.
- Do not modify files outside `fhir-fork/source/` unless the user explicitly overrides this rule.

## Scope Notes
- Treat this as a strict safety boundary for normal ticket implementation work.
- Keep edits minimal, traceable to ticket intent, and limited to specification content.

## Additional sources for guidance
- https://confluence.hl7.org/spaces/FHIR/pages/79507295/Maintaining+FHIR+Core
- https://confluence.hl7.org/spaces/FHIR/pages/35718548/FHIR+Spreadsheet+Authoring

## Extension Link Rules
- Include extension links using this format:
	- `<a href="[%extensions-location%]StructureDefinition-artifact-author.html">artifact-author</a>`
- When adding or changing extension links:
	- Verify the target URL resolves to an existing extension page in the built/published output.
	- Verify the visible hyperlink text matches the extension name in the URL (e.g., `artifact-author` for `StructureDefinition-artifact-author.html`).
	- If URL and label do not correspond, update both to the correct matching extension.


## Placeholder For Additional FHIR-Fork Rules
- Add future fork-specific conventions here as they are agreed.
