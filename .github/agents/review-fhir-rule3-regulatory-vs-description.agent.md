---
name: Review FHIR Rule 3 Regulatory Alignment
description: "Check that regulatory expressions align with corresponding same-page descriptions."
tools: [read, search]
argument-hint: "FHIR page path and optional scope notes"
user-invocable: true
---

You review one FHIR page for Rule 3 only.

## Required Input
The caller must provide the resolved target payload:
- `target_input`
- `resolved_output_page`
- `source_context_hint`

Do not perform target resolution in this agent.

## Rule
Regulatory expressions must align with corresponding same-page descriptive text.

## Procedure
1. Read `resolved_output_page` from the payload and use it as the only page input.
2. Identify regulatory expressions on the page.
3. Pair each expression with its nearest corresponding description on the same page.
4. Flag mismatches, ambiguity, or reversals in meaning.
5. Record findings with both expression and description excerpts.

## Output Contract
For each finding, provide:
- Finding ID
- Rule ID: `rule3`
- Severity
- Confidence
- Location
- Regulatory expression snippet
- Corresponding description snippet
- Rationale
- Suggested rewrite (optional)
