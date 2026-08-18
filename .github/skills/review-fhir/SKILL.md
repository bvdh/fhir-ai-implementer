---
name: review-fhir
description: 'Review a single FHIR page for non-technical and technical corrections, including seven rule checks, W3C style checks, link validation, and spelling checks.'
argument-hint: 'Target page (for example patient.html or fhir-repo/output/patient.html); optional scope notes'
user-invocable: true
---

# Review FHIR (Non-Technical + Technical)

## What This Skill Produces
This skill produces two findings-only reports for one FHIR page:
- a non-technical review report
- a technical-corrections review report

Outputs are written under `review/`:
- Page mode: `review/<page-slug>.html/<page-slug>-change-requests.md`
- Page mode: `review/<page-slug>.html/<page-slug>-technical-corrections.md`
- Template: `review/non-technical-review-template.md`
- Template: `review/technical-corrections-template.md`

## When To Use
- You want one command to run both non-technical and technical correction checks for a page.
- You want a non-technical correction pass focused on language and consistency rules.
- You need regulatory and FHIRPath expression checks against same-page descriptions.
- You need to confirm that resources with a `subject` field expose a `patient` and/or `subject` search parameter.
- You need to confirm that normative resources only bind to normative `ValueSet`s and `CodeSystem`s.
- You need W3C style checks, link target checks, link-text alignment checks, and spelling checks.

## Inputs
- Target page input (single-page mode only in v1):
  - page filename like `patient.html`
   - relative path like `fhir-repo/output/patient.html` or `fhir-repo/publish/patient.html`
  - absolute path to a local rendered page
- Optional scope notes:
  - severity focus
  - include/exclude headings
  - ticket reference

## Rule Set (Always Run)
1. Normative language (`MUST`, `SHALL`, `SHOULD`, `MAY`) is not allowed on informative pages. For an informative page, scan the rendered page body and its source context for uppercase conformance terms, excluding the standards-status metadata, navigation, page chrome, scripts, styles, and generated markup. Report every occurrence with its heading or anchor, exact evidence, and whether it is an actual normative statement, a quotation/definition, or an explanatory example. Do not treat a term merely appearing in the page's description of FHIR conformance vocabulary as an automatic violation; record it for review and explain the context.
2. For FHIR resource elements, normative language is not allowed in note, summary, and comment fields.
3. Regulatory expressions must align with corresponding same-page descriptions.
4. FHIRPath expressions must align with corresponding same-page descriptions.
5. Page prose must not contain contradictions.
6. If a resource has a `subject` field, the page must define a `patient` and/or `subject` search parameter.
7. When a resource is normative, every element's bound `ValueSet` and each `CodeSystem` it draws from must also be normative.

## Workflow
1. Resolve target to local files.
   - Use local rendered page under `fhir-repo/output/**` or `fhir-repo/publish/**`.
   - Identify matching source context under `fhir-repo/source/**` for evidence.
2. Enforce build freshness.
   - Run `./.github/skills/build-fhir/scripts/build-if-needed.sh --repo ./fhir-repo --mode check`.
   - If result is `BUILD_NEEDED: yes`, ask whether to rebuild.
   - If user confirms, run rebuild and continue.
   - If user declines (or rebuild fails), stop and write a BLOCKED report.
3. Build and pass a resolved target payload to every rule agent.
   - Required payload fields:
     - `target_input`
     - `resolved_output_page`
     - `source_context_hint`
   - Agents must use this payload and must not perform target resolution themselves.
4. Determine the target page's page-level Standards Status from the resolved rendered page or source context. When the page is informative, run the Rule 1 normative-language scan against the rendered body and source context before aggregating the rule results. When the page is normative, do not apply the informative-page prohibition; still report normative terms as evidence when relevant to another finding.
5. Invoke seven rule agents and aggregate findings.
   - Deterministic aggregation order: Rule 1 through Rule 7.
6. Invoke technical-correction checks on the same resolved target.
   - W3C style checks (sections 7.2, 7.3, 11, 13)
   - Link target existence checks
   - Link description/heading alignment checks
   - Spelling checks
7. Write findings-only reports.
   - Write to `review/<page-slug>.html/` (create the subdirectory if it does not exist).
   - Use `review/non-technical-review-template.md` structure for the change-requests report.
   - Use `review/technical-corrections-template.md` structure.

## Decision Logic
- If target resolves to exactly one output page, proceed.
- If target resolves to multiple output pages, use lexical path order and record alternates in Notes.
- If target does not resolve to a local output page, write BLOCKED report and stop.
- If target does not resolve to a local output/publish page, write BLOCKED report and stop.

## Report Requirements
The non-technical report must include:
- Metadata and target
- Build evidence
- Input files used
- Findings grouped by Rule 1 to Rule 7
- For Rule 1 on informative pages: the page-level Standards Status, scan scope/exclusions, total occurrence count, each occurrence's location and evidence, and a disposition distinguishing normative statements from quotations, definitions, examples, or other non-normative uses
- Cross-rule synthesis
- Blocking issues

For each finding, include:
- Finding ID
- Rule ID
- Severity (`error|warning|info`)
- Confidence (`high|medium|low`)
- Location (file + heading/anchor)
- Evidence snippet
- Rationale
- Suggested rewrite (optional)

Rule 6 findings must also include:
- Detected `subject` element context
- Observed search-parameter inventory on the page

Rule 7 findings must also include:
- Element path and binding strength
- Resource, ValueSet, and CodeSystem Standards Status values

The technical-corrections report must include:
- Metadata and target
- Build evidence
- Source and output files used
- Findings grouped by:
   - W3C style deviations
   - Link target validation
   - Link description alignment
   - Spelling findings
   - Other technical corrections
- Patch-ready edits for each finding

## Quality Criteria
A run is complete only when all are true:
- Build freshness gate passed or explicit BLOCKED report was written.
- All seven rule sections are present in the report.
- Rule 6 was evaluated with explicit subject/search-parameter evidence.
- Rule 7 was evaluated with explicit ValueSet/CodeSystem normative-status evidence (or explicitly skipped for non-normative resources).
- Technical-correction sections are present in the technical report.
- No source files were edited by this skill.

## Suggested Runner
Use the helper script to enforce gate and create both report skeletons:

```bash
bash ./.github/skills/review-fhir/scripts/review-page.sh <target-page>
```

If build output is stale, the runner asks whether to rebuild now.

Then execute the seven rule-agent checks and populate findings.

## Example Prompts
- `/review-fhir patient.html`
- `/review-fhir fhir-repo/output/observation.html focus on contradictions and rule6 evidence`
