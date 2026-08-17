# Non-Technical FHIR Review Report

## Metadata
- Review ID: conformance-rules-non-technical-2026-08-17
- Date: 2026-08-17
- Mode: page
- Target input: `fhir-repo/publish/conformance-rules.html`
- Resolved output page: `fhir-repo/publish/conformance-rules.html`
- Status: COMPLETED

## Build Evidence
- Build check command: `./.github/skills/build-fhir/scripts/build-if-needed.sh --repo ./fhir-repo --mode check`
- Build check result: BUILD_NEEDED: no
- Build status used for review: current
- Notes: `BUILD_NEEDED: no`; review used the current local publish tree without rebuilding.

## Inputs Used
- Source files:
  - `fhir-repo/source/conformance-rules.html` (SHA-256 `0461476d507c2da3`)
- Output files:
  - `fhir-repo/publish/conformance-rules.html` (58303 bytes)

## Rule 1 Findings: Normative Language on Informative Pages
- Page-level Standards Status evidence: `Normative The FHIR specification describes a set of resources and several differ`
- Scan scope: visible rendered body text, excluding scripts/styles/SVG; source context used for corroboration. Uppercase occurrence count: 20.
- Screening result: 20 uppercase conformance-term occurrence(s); page status: `Normative The FHIR specification describes a set of resources and several differ`. No informative-page Rule 1 violation was isolated by the deterministic scan.

## Rule 2 Findings: Normative Language in note/summary/comment Fields
- Deterministic source/output scan checked `note`, `summary`, and `comment` contexts for uppercase MUST/SHALL/SHOULD/MAY terms. No field-level violation was isolated; navigation and generated metadata were excluded from disposition. - None.

## Rule 3 Findings: Regulatory Expressions vs Description
- Regulatory marker count: 0 (none). No regulatory expression/description mismatch was detected by the page-local scan. - None.

## Rule 4 Findings: FHIRPath Expressions vs Description
- FHIRPath-like expression count: 0. No expression with a same-page descriptive mismatch was isolated by the deterministic scan. - None.

## Rule 5 Findings: Contradictions on Page
- Restrictive-language marker count: 9. No contradictory pair was detected by the page-local scan; this is a screening conclusion, not a claim that the page has no editorial ambiguity. - None.

## Rule 6 Findings: subject Field Requires patient and/or subject Search Parameter
- Screening result: source context contains 5 subject-related occurrence(s); representative context: `<li>FHIR has been subject to a level of review and vetting unlikely to be received by any non-conformant variation; variations may result in intr`.
- Detected subject context: `fhir-repo/source/conformance-rules.html`; the scan did not prove that every occurrence is a resource element.
- Search parameters observed on the page: patient, subject. No unsupported Rule 6 violation is asserted without a resource-specific subject definition.

## Cross-Rule Synthesis
- The rendered page and matching source context were present, the build freshness gate passed, and all six rule checks were evaluated. Rule 1 recorded 20 conformance-term occurrence(s); no additional cross-rule conflict was found.

## Blocking Issues
- None.
