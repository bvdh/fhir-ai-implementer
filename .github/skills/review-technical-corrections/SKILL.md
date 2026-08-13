---
name: review-technical-corrections
description: 'Review a FHIR page or the full built spec for technical corrections. Uses the Review W3C Style agent for W3C issues and a link-validation agent for link integrity checks, enforces current build evidence, and writes page-specific review reports under review/.'
argument-hint: 'Target page (for example documentreference.html or fhir-repo/output/documentreference.html) or full-spec; optional scope notes'
user-invocable: true
---

# Review Technical Corrections

## What This Skill Produces
This skill produces implementation-ready technical-correction review reports for FHIR content.

Outputs are always written to repository-local files under `review/`:
- Single page mode: `review/<page-slug>.html/<page-slug>-technical-corrections.md`
- Full spec mode: one file per flagged page using `review/<page-slug>.html/<page-slug>-technical-corrections.md`
- Use template: `review/technical-corrections-template.md`

Each report is patch-ready and can be used directly to update source content.

## When To Use
- You want a technical-correction pass on one FHIR page.
- You want a broad technical-correction pass across the built FHIR spec.
- You need W3C Manual of Style findings, link integrity findings, and correction-ready edit details.

## Inputs
- Target:
  - page mode: a page name/path/URL, such as `documentreference.html`
  - full mode: `full-spec`
- Optional scope notes:
  - include/exclude page patterns
  - severity focus
  - ticket reference

## Workflow
1. Normalize target mode.
   - If target is `full-spec`, run full mode.
   - Otherwise run page mode.
2. Require current build status before review.
   - Run `./.github/skills/build-fhir/scripts/build-if-needed.sh --repo ./fhir-repo --mode build`.
   - If build fails, stop and write a BLOCKED report to `review/` with command, exit status, and failure reason.
3. Resolve local review inputs.
   - Source input: matching files under `fhir-repo/source/**`.
   - Output input: matching rendered page(s) under `fhir-repo/output/**`.
   - Prefer local output file(s) over remote URLs.
4. Invoke domain agents for each target page.
   - The W3C agent is authoritative for sections 7.2, 7.3, 11, and 13.
  - Invoke `Review Link Target and Description Alignment` for link checks.
  - The link agent is authoritative for link-target existence and link-description correspondence findings.
   - Keep exclusions active: icon-only markers, generated UI labels, citation-linking recommendations.
   - Include spelling checks.
5. Merge findings into a technical-corrections report.
  - Preserve W3C section mapping and keep link findings grouped by domain.
  - Apply precedence rules: link findings are owned by the link agent; W3C style findings are owned by the W3C agent.
   - Keep all edits patch-ready with exact current/proposed text and context.
6. Write report file(s) under `review/`.
  - For a page, write exactly one page-specific file under `review/<page-slug>.html/` (create the subdirectory if it does not exist).
  - For full mode, write one page-specific file per flagged page under the corresponding `review/<page-slug>.html/` subdirectory (no master summary file).
  - Use `review/technical-corrections-template.md` as the report skeleton.

## Decision Logic
- Page mode:
  - If exactly one local output page matches target, review it.
  - If multiple matches, choose the canonical page path and record other candidates in Notes.
  - If no local output match, write BLOCKED report and stop.
- Full mode:
  - Enumerate candidate pages from `fhir-repo/output/*.html`.
  - Skip generated index/navigation-only pages when they have no meaningful prose content.
  - Review pages in deterministic order (lexical path order).
  - Run both domain agents per page and write one page report per reviewed page.
- Build gate:
  - If build command reports current/no rebuild required, continue.
  - If rebuild occurs, include rebuild evidence in report.
- External link verification:
  - Validate HTTP/HTTPS targets when reachable.
  - If a target cannot be verified (for example timeout, DNS, TLS, blocked network), classify as indeterminate and include evidence.

## Report Format Requirements
Each generated report must include:
- Target and mode
- Build status and build evidence
- Source input files used
- Output input files used
- Findings grouped by:
  - W3C style deviations (sections 7.2, 7.3, 11, 13)
  - Link target validation findings
  - Link description correspondence findings
  - Spelling findings
  - Non-W3C technical corrections discovered during review
- Patch-ready change set for each finding:
  - Change ID
  - Target file
  - Anchor
  - Edit type
  - Current text (exact)
  - Proposed text (exact)
  - Pre-context and post-context
  - Occurrence rule
  - Rationale
  - Validation check
- Apply sequence
- Blocking issues (if any)

## Quality Criteria
A run is complete only when all are true:
- Build requirement satisfied or explicitly BLOCKED with evidence.
- Review used local `fhir-repo/source/**` and `fhir-repo/output/**` inputs.
- W3C-agent findings are included without citation-linking recommendations.
- Link-agent findings are included for both target existence and description correspondence.
- External link checks are classified as validated or indeterminate with evidence.
- Spelling checks are included.
- Report file(s) are written under `review/<page-slug>.html/` using the required naming convention.
- The output is precise enough to implement page updates directly.

## Example Prompts
- `/review-technical-corrections documentreference.html`
- `/review-technical-corrections fhir-repo/output/documentreference.html focus on terminology consistency`
- `/review-technical-corrections full-spec include pages matching *reference*.html`
