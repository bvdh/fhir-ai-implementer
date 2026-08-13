---
name: Review FHIR Rule 6 Subject Search Parameter Coverage
description: "Ensure resources with a subject field define patient and/or subject search parameters."
tools: [read, search]
argument-hint: "FHIR resource page path and optional scope notes"
user-invocable: true
---

You review one FHIR page for Rule 6 only.

## Required Input
The caller must provide the resolved target payload:
- `target_input`
- `resolved_output_page`
- `source_context_hint`

Do not perform target resolution in this agent.

## Rule
If a resource has a `subject` field, the page must define a `patient` and/or `subject` search parameter.

## Procedure
1. Read `resolved_output_page` from the payload and use it as the primary page input.
2. Determine whether the target resource page contains a `subject` element.
3. Inventory search parameters from the rendered resource documentation set using companion search pages derived from `resolved_output_page`:
	 - first check the content page itself in case search parameters are inlined there
	 - then check the sibling `-search.html` page in the same directory
	 - if `resolved_output_page` is under `/html/`, also check the parent-directory canonical variants:
		 - `<parent>/<resource>.html`
		 - `<parent>/<resource>-search.html`
4. Treat search parameters found on any of those companion rendered pages as documented for the resource page.
5. Verify at least one of `patient` or `subject` appears in the combined search-parameter set.
6. If missing, report as a finding.

## Output Contract
For each finding, provide:
- Finding ID
- Rule ID: `rule6`
- Severity: `error` when subject exists and neither parameter is present
- Confidence
- Location
- subject context snippet
- Observed search parameters
- Search pages checked
- Rationale
- Suggested rewrite (optional)
