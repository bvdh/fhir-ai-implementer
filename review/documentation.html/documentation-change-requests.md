# Non-Technical FHIR Review Report

## Metadata
- Review ID: documentation-non-technical-2026-08-17
- Date: 2026-08-17
- Mode: page
- Target input: `fhir-repo/publish/documentation.html`
- Resolved output page: `fhir-repo/publish/documentation.html`
- Status: COMPLETED

## Build Evidence
- Build check command: `./.github/skills/build-fhir/scripts/build-if-needed.sh --repo ./fhir-repo --mode check`
- Build check result: BUILD_NEEDED: no
- Build status used for review: current
- Notes: `BUILD_NEEDED: no`; review used the current local publish tree without rebuilding.

## Inputs Used
- Source files:
  - `fhir-repo/source/documentation.html` (SHA-256 `3cb442ba8cdbaef8`)
- Output files:
  - `fhir-repo/publish/documentation.html` (20817 bytes)

## Rule 1 Findings: Normative Language on Informative Pages
- Page-level Standards Status evidence: `Informative This page provides an index to the key commonly used background docu`
- Scan scope: visible rendered body text, excluding scripts/styles/SVG; source context used for corroboration. Uppercase occurrence count: 2.
- Finding ID: R1-001; Rule ID: rule1; Severity: warning; Confidence: medium
  - Location: `fhir-repo/publish/documentation.html`; heading: `2.1.0`
  - Evidence snippet: `is, documentation that does not make rules about what Implementations SHALL or SHOULD do. FHIR ®© HL7.org 2011+. FHIR R6 hl7.fhir.r6.core#6.0.0-ballot4 generated on`
  - Rationale: Informative-page screening found `SHALL` in rendered prose; the surrounding use needs human disposition as statement, quotation, definition, or example.
  - Suggested rewrite: Confirm the sentence status before changing conformance vocabulary.
- Finding ID: R1-002; Rule ID: rule1; Severity: warning; Confidence: medium
  - Location: `fhir-repo/publish/documentation.html`; heading: `2.1.0`
  - Evidence snippet: `entation that does not make rules about what Implementations SHALL or SHOULD do. FHIR ®© HL7.org 2011+. FHIR R6 hl7.fhir.r6.core#6.0.0-ballot4 generated on Fri, Aug 7`
  - Rationale: Informative-page screening found `SHOULD` in rendered prose; the surrounding use needs human disposition as statement, quotation, definition, or example.
  - Suggested rewrite: Confirm the sentence status before changing conformance vocabulary.

## Rule 2 Findings: Normative Language in note/summary/comment Fields
- Deterministic source/output scan checked `note`, `summary`, and `comment` contexts for uppercase MUST/SHALL/SHOULD/MAY terms. No field-level violation was isolated; navigation and generated metadata were excluded from disposition. - None.

## Rule 3 Findings: Regulatory Expressions vs Description
- Regulatory marker count: 1 (Legal). No regulatory expression/description mismatch was detected by the page-local scan. - None.

## Rule 4 Findings: FHIRPath Expressions vs Description
- FHIRPath-like expression count: 0. No expression with a same-page descriptive mismatch was isolated by the deterministic scan. - None.

## Rule 5 Findings: Contradictions on Page
- Restrictive-language marker count: 0. No contradictory pair was detected by the page-local scan; this is a screening conclusion, not a claim that the page has no editorial ambiguity. - None.

## Rule 6 Findings: subject Field Requires patient and/or subject Search Parameter
- Screening result: no subject element context was detected in source HTML; Rule 6 is not applicable on the available evidence.
- Search parameters observed on the page: - None detected.

## Cross-Rule Synthesis
- The rendered page and matching source context were present, the build freshness gate passed, and all six rule checks were evaluated. Rule 1 recorded 2 conformance-term occurrence(s); no additional cross-rule conflict was found.

## Blocking Issues
- None.
