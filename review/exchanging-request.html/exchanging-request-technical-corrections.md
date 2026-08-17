# Technical Corrections Review Report

## Metadata
- Review ID: exchanging-request-technical-2026-08-14
- Date: 2026-08-14
- Mode: page
- Target: fhir-repo/publish/exchanging-request.html
- Status: ready

## Build Evidence
- Build check command: `./.github/skills/build-fhir/scripts/build-if-needed.sh --repo ./fhir-repo --mode check`
- Build check result: `BUILD_NEEDED: no`
- Build status used for review: current
- Additional evidence: No rebuild was run. No source files were edited.

## Inputs Used
- Source files:
  - Requested: `fhir-repo/source/exchanging-request.xml` (not present)
  - Available authored source used for context: `fhir-repo/source/exchanging-request.html`
- Output files:
  - `fhir-repo/publish/exchanging-request.html`

## W3C Findings
### Section 7.2
- None. No citation-format deviations found.
### Section 7.3
- None. No within-document reference-citation deviations found.
### Section 11
- **CHG-001** warning, high: replace unexplained `i.e.,` with `For example,` in the CommunicationRequest introduction.
- **CHG-002** error, high: replace `a request resources represent` with `request resources represent` and add the serial comma in `plans, proposals, or orders`.
- **CHG-003** warning, high: replace `POSTed` with `posted` in the Direct POST section.
- **CHG-004** warning, high: remove the repeated `it must` in `it must either be stored ... or it must be thrown away`.
- **CHG-005** warning, high: add a comma before `and eventually` in the Task status progression.
- **CHG-006** warning, high: replace `additional information around progress ... expected time frame for delivery` with concise progress/timeframe wording.
- **CHG-007** error, high: replace `<b>Steps 9:</b>` with `<b>Step 9:</b>`.
- **CHG-008** warning, high: replace `id(s)` and fix parallelism in the Step 9 retrieval alternatives.
- **CHG-009** warning, high: apply the same concise progress/timeframe wording to the repeated status paragraph.
- **CHG-010** warning, medium: replace passive `can be found here` with direct link wording in the final Task guidance paragraph.
### Section 13
- **CHG-011** warning, high: replace `time frame` with `timeframe` in both occurrences.
- **CHG-012** warning, medium: replace the inflected technical verb `POSTed` with `posted`.

## Link Target Validation Findings
- **Link ID:** LNK-001; **Severity:** warning; **Confidence:** high
  - **Source location:** `fhir-repo/publish/exchanging-request.html`, workflow-management link
  - **Link text:** `Option H`
  - **Href:** `workflow-management.html#optionH`
  - **Target type:** internal-file
  - **Validation status:** missing
  - **Evidence:** `workflow-management.html` exists, but its target anchor is lowercase `#optionh`.
  - **Patch-ready edit:** replace `workflow-management.html#optionH` with `workflow-management.html#optionh`.

## Link Description Correspondence Findings
- None beyond LNK-001. The `Option H` link text aligns with the target heading; only fragment casing is incorrect. The remaining 86 checked anchors had no target or description-alignment problem.

## Spelling Findings
- **SP-001** warning, very high: redundant `directly` in `being directly POSTed directly back`; remove the first occurrence.
- **SP-002** warning, very high: singular step labels rendered as `Steps 9:` and `Steps 7:`; change both to `Step 9:` and `Step 7:`.
- **SP-003** warning, high: lowercase `step 5` in two cross-references is inconsistent with the page’s `Step 5` style; capitalize both.
- No ordinary dictionary spelling errors were found.

## Non-W3C Technical Corrections
- The link fragment correction LNK-001 is the only broken target. The spelling/wording findings above are the remaining technical corrections; no additional technical defects were identified.

## Patch-Ready Change Set
- **CHG-001 through CHG-012:** Apply the exact source-text replacements listed in the W3C findings. Target file: `fhir-repo/source/exchanging-request.html`; validate by rebuilding and checking the rendered page.
- **LNK-001:** Replace the unique href `workflow-management.html#optionH` with `workflow-management.html#optionh`; validate the anchor resolves to `Option H: POST of Task to a workflow broker`.
- **SP-001:** In the Direct POST paragraph, remove the duplicated first `directly`.
- **SP-002:** Change the two rendered singular labels from `Steps 9:` and `Steps 7:` to `Step 9:` and `Step 7:` in source.
- **SP-003:** Change both `step 5` references to `Step 5`.

## Apply Sequence
1. Resolve the workflow contradiction and step references in the source.
2. Apply CHG-001 through CHG-012 and SP-001 through SP-003.
3. Apply LNK-001.
4. Rebuild and rerun link, W3C, spelling, and page-rule checks.

## Blocking Issues
- None for execution. Requested XML source was unavailable, but the authored HTML source was available for technical context. Review-only request honored; no files were edited.
