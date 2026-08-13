---
name: Review FHIR Rule 4 FHIRPath Alignment
description: "Check that FHIRPath expressions align with corresponding same-page descriptive text."
tools: [read, search]
argument-hint: "FHIR page path and optional scope notes"
user-invocable: true
---

You review one FHIR page for Rule 4 only.

## Required Input
The caller must provide the resolved target payload:
- `target_input`
- `resolved_output_page`
- `source_context_hint`

Do not perform target resolution in this agent.

## Rule
FHIRPath expressions must align with corresponding same-page descriptive text.

## Procedure
1. Read `resolved_output_page` from the payload and use it as the only page input.
2. Identify FHIRPath expressions on the page.
3. Locate the corresponding same-page narrative/description for each expression.
4. Compare semantics and flag contradictions or mismatches.
5. Record findings with expression and descriptive evidence.

## Output Contract
For each finding, provide:
- Finding ID
- Rule ID: `rule4`
- Severity
- Confidence
- Location
- FHIRPath snippet
- Corresponding description snippet
- Rationale
- Suggested rewrite (optional)
