# Non-Technical FHIR Review Report

## Metadata
- Review ID: languages-non-technical-2026-08-17
- Date: 2026-08-17
- Mode: page
- Target input: `fhir-repo/publish/languages.html`
- Resolved output page: `fhir-repo/publish/languages.html`
- Status: COMPLETED

## Build Evidence
- Build check command: `./.github/skills/build-fhir/scripts/build-if-needed.sh --repo ./fhir-repo --mode check`
- Build check result: BUILD_NEEDED: no
- Build status used for review: current
- Notes: `BUILD_NEEDED: no`; review used the current local publish tree without rebuilding.

## Inputs Used
- Source files:
  - `fhir-repo/source/languages.html` (SHA-256 `4ca167aaab17cbfe`)
- Output files:
  - `fhir-repo/publish/languages.html` (29519 bytes)

## Rule 1 Findings: Normative Language on Informative Pages
- Page-level Standards Status evidence: `Informative In general, with regard to human language, the content in resources`
- Scan scope: visible rendered body text, excluding scripts/styles/SVG; source context used for corroboration. Uppercase occurrence count: 1.
- Finding ID: R1-001; Rule ID: rule1; Severity: warning; Confidence: medium
  - Location: `fhir-repo/publish/languages.html`; heading: `7.12`
  - Evidence snippet: `on. Note that the choice of locale from the "Accept-language" headers MAY change syntax of resource narrative (e.g., date formats, number formats). 7.12.3 Translat`
  - Rationale: Informative-page screening found `MAY` in rendered prose; the surrounding use needs human disposition as statement, quotation, definition, or example.
  - Suggested rewrite: Confirm the sentence status before changing conformance vocabulary.

## Rule 2 Findings: Normative Language in note/summary/comment Fields
- Deterministic source/output scan checked `note`, `summary`, and `comment` contexts for uppercase MUST/SHALL/SHOULD/MAY terms. No field-level violation was isolated; navigation and generated metadata were excluded from disposition. - None.

## Rule 3 Findings: Regulatory Expressions vs Description
- Regulatory marker count: 0 (none). No regulatory expression/description mismatch was detected by the page-local scan. - None.

## Rule 4 Findings: FHIRPath Expressions vs Description
- FHIRPath-like expression count: 0. No expression with a same-page descriptive mismatch was isolated by the deterministic scan. - None.

## Rule 5 Findings: Contradictions on Page
- Restrictive-language marker count: 0. No contradictory pair was detected by the page-local scan; this is a screening conclusion, not a claim that the page has no editorial ambiguity. - None.

## Rule 6 Findings: subject Field Requires patient and/or subject Search Parameter
- Screening result: no subject element context was detected in source HTML; Rule 6 is not applicable on the available evidence.
- Search parameters observed on the page: patient

## Cross-Rule Synthesis
- The rendered page and matching source context were present, the build freshness gate passed, and all six rule checks were evaluated. Rule 1 recorded 1 conformance-term occurrence(s); no additional cross-rule conflict was found.

## Blocking Issues
- None.
