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

## Previous versions of the specification
- R4: https://hl7.org/fhir/R4/
- R4B: https://hl7.org/fhir/R4B/
- R5: https://hl7.org/fhir/R5/

Other versions can be found at https://hl7.org/fhir/directory.html.

## Source repo holding the code called when building and publishing the FHIR specification:
- https://github.com/HL7/kindling.

## Primitive Regex Source Rules
- Treat `fhir-fork/source/datatypes/primitives.xml` as the source of truth for primitive datatype regex values rendered via tokens such as `[%regex code%]`.
- When a ticket changes a primitive regex, update the corresponding row in `fhir-fork/source/datatypes/primitives.xml` rather than hardcoding regex text into tokenized template pages such as `fhir-fork/source/datatypes.html`.
- Keep `fhir-fork/source/datatypes.html` token usage intact unless a ticket explicitly requires changing template structure.

## Extension Link Rules
- Include extension links using this format:
	- `<a href="[%extensions-location%]StructureDefinition-artifact-author.html">artifact-author</a>`
- When adding or changing extension links:
	- Verify the target URL resolves to an existing extension page in `fhir-fork/publish/` output.
	- If `fhir-fork/publish/` is missing or stale for the files being validated, run `./gradlew publish` from the `fhir-fork/` root, then re-check.
	- Use `./gradlew publish` sparingly because it is expensive; do not re-run when current `fhir-fork/publish/` output already reflects the source under review.
	- Verify the visible hyperlink text matches the extension name in the URL (e.g., `artifact-author` for `StructureDefinition-artifact-author.html`).
	- If URL and label do not correspond, update both to the correct matching extension.

## Deprecation Pattern Rules
- When deprecating elements, concepts, code systems, or value sets, use the `structuredefinition-standards-status` extension with `valueCode="deprecated"`.
- Provide a deprecation reason using `http://hl7.org/fhir/StructureDefinition/structuredefinition-standards-status-reason` when there is a clear replacement or migration path.
- Prefer the nested pattern used in existing content:
	- `structuredefinition-standards-status` -> `valueCode value="deprecated"` -> nested `structuredefinition-standards-status-reason` with `valueMarkdown`.
- If the surrounding artifact already uses a slightly different but valid ordering for the reason extension, follow the local file style for consistency.
- Pair metadata deprecation with explicit migration wording in nearby `short`, `definition`, or `comment` text when applicable (for example: "Use <replacement> instead").
- When deprecating capability flags in favor of interaction codes, ensure replacement codes are present in the relevant code system/value set before or alongside the deprecation update.


## Placeholder For Additional FHIR-Fork Rules
- Add future fork-specific conventions here as they are agreed.
