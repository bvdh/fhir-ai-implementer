# Non-Technical FHIR Review Report

## Metadata
- Review ID: diff-r5-non-technical-2026-08-17
- Date: 2026-08-17
- Mode: page
- Target input: `fhir-repo/publish/diff-r5.html`
- Resolved output page: `fhir-repo/publish/diff-r5.html`
- Status: COMPLETED

## Build Evidence
- Build check command: `./.github/skills/build-fhir/scripts/build-if-needed.sh --repo ./fhir-repo --mode check`
- Build check result: BUILD_NEEDED: no
- Build status used for review: current
- Notes: `BUILD_NEEDED: no`; review used the current local publish tree without rebuilding.

## Inputs Used
- Source files:
  - `fhir-repo/source/diff-r5.html` (SHA-256 `88539121d66e169a`)
- Output files:
  - `fhir-repo/publish/diff-r5.html` (603027 bytes)

## Rule 1 Findings: Normative Language on Informative Pages
- Page-level Standards Status evidence: `Informative This page has only partially been updated for R6 at this time`
- Scan scope: visible rendered body text, excluding scripts/styles/SVG; source context used for corroboration. Uppercase occurrence count: 1.
- Finding ID: R1-001; Rule ID: rule1; Severity: warning; Confidence: medium
  - Location: `fhir-repo/publish/diff-r5.html`; heading: `2.1.15`
  - Evidence snippet: `s.actor.key Added Element Requirements.statement.conformance Add code SHALL-NOT Requirements.statement.category Added Element Requirements.statement.derivedFrom Type`
  - Rationale: Informative-page screening found `SHALL` in rendered prose; the surrounding use needs human disposition as statement, quotation, definition, or example.
  - Suggested rewrite: Confirm the sentence status before changing conformance vocabulary.

## Rule 2 Findings: Normative Language in note/summary/comment Fields
- Deterministic source/output scan checked `note`, `summary`, and `comment` contexts for uppercase MUST/SHALL/SHOULD/MAY terms. No field-level violation was isolated; navigation and generated metadata were excluded from disposition. - None.

## Rule 3 Findings: Regulatory Expressions vs Description
- Regulatory marker count: 74 (Jurisdiction, jurisdiction). No regulatory expression/description mismatch was detected by the page-local scan. - None.

## Rule 4 Findings: FHIRPath Expressions vs Description
- FHIRPath-like expression count: 9. No expression with a same-page descriptive mismatch was isolated by the deterministic scan. - None.

## Rule 5 Findings: Contradictions on Page
- Restrictive-language marker count: 2. No contradictory pair was detected by the page-local scan; this is a screening conclusion, not a claim that the page has no editorial ambiguity. - None.

## Rule 6 Findings: subject Field Requires patient and/or subject Search Parameter
- Screening result: no subject element context was detected in source HTML; Rule 6 is not applicable on the available evidence.
- Search parameters observed on the page: patient, subject

## Cross-Rule Synthesis
- The rendered page and matching source context were present, the build freshness gate passed, and all six rule checks were evaluated. Rule 1 recorded 1 conformance-term occurrence(s); no additional cross-rule conflict was found.

## Blocking Issues
- None.
