# Non-Technical FHIR Review Report

## Metadata
- Review ID: administration-module-non-technical-2026-08-17
- Date: 2026-08-17
- Mode: page
- Target input: `fhir-repo/publish/administration-module.html`
- Resolved output page: `fhir-repo/publish/administration-module.html`
- Status: COMPLETED

## Build Evidence
- Build check command: `./.github/skills/build-fhir/scripts/build-if-needed.sh --repo ./fhir-repo --mode check`
- Build check result: BUILD_NEEDED: no
- Build status used for review: current
- Notes: `BUILD_NEEDED: no`; review used the current local publish tree without rebuilding.

## Inputs Used
- Source files:
  - `fhir-repo/source/administration-module.html` (SHA-256 `645170b92f3e9cc8`)
- Output files:
  - `fhir-repo/publish/administration-module.html` (54566 bytes)

## Rule 1 Findings: Normative Language on Informative Pages
- Page-level Standards Status evidence: `Informative 8`
- Scan scope: visible rendered body text, excluding scripts/styles/SVG; source context used for corroboration. Uppercase occurrence count: 4.
- Finding ID: R1-001; Rule ID: rule1; Severity: warning; Confidence: medium
  - Location: `fhir-repo/publish/administration-module.html`; heading: `8.0`
  - Evidence snippet: `g how a User Identity could be represented in FHIR resources: Systems MAY use .identifier on the Patient, RelatedPerson, Practitioner or Person resources for user`
  - Rationale: Informative-page screening found `MAY` in rendered prose; the surrounding use needs human disposition as statement, quotation, definition, or example.
  - Suggested rewrite: Confirm the sentence status before changing conformance vocabulary.
- Finding ID: R1-002; Rule ID: rule1; Severity: warning; Confidence: medium
  - Location: `fhir-repo/publish/administration-module.html`; heading: `8.0`
  - Evidence snippet: `es for user identities. When using a Person resource, this identifier MAY be duplicated to the other related resources, however is not required. User identities MA`
  - Rationale: Informative-page screening found `MAY` in rendered prose; the surrounding use needs human disposition as statement, quotation, definition, or example.
  - Suggested rewrite: Confirm the sentence status before changing conformance vocabulary.
- Finding ID: R1-003; Rule ID: rule1; Severity: warning; Confidence: medium
  - Location: `fhir-repo/publish/administration-module.html`; heading: `8.0`
  - Evidence snippet: `the other related resources, however is not required. User identities MAY be handled completely outside of the FHIR and not represented on FHIR resources at all. D`
  - Rationale: Informative-page screening found `MAY` in rendered prose; the surrounding use needs human disposition as statement, quotation, definition, or example.
  - Suggested rewrite: Confirm the sentence status before changing conformance vocabulary.
- Finding ID: R1-004; Rule ID: rule1; Severity: warning; Confidence: medium
  - Location: `fhir-repo/publish/administration-module.html`; heading: `8.0`
  - Evidence snippet: `setting. Implementation Note: The FHIR SMART App Launch specification MAY refer to a FHIR Patient, RelatedPerson, Practitioner, PractitionerRole or Person resource`
  - Rationale: Informative-page screening found `MAY` in rendered prose; the surrounding use needs human disposition as statement, quotation, definition, or example.
  - Suggested rewrite: Confirm the sentence status before changing conformance vocabulary.

## Rule 2 Findings: Normative Language in note/summary/comment Fields
- Deterministic source/output scan checked `note`, `summary`, and `comment` contexts for uppercase MUST/SHALL/SHOULD/MAY terms. No field-level violation was isolated; navigation and generated metadata were excluded from disposition. - None.

## Rule 3 Findings: Regulatory Expressions vs Description
- Regulatory marker count: 2 (legal, regulated). No regulatory expression/description mismatch was detected by the page-local scan. - None.

## Rule 4 Findings: FHIRPath Expressions vs Description
- FHIRPath-like expression count: 0. No expression with a same-page descriptive mismatch was isolated by the deterministic scan. - None.

## Rule 5 Findings: Contradictions on Page
- Restrictive-language marker count: 0. No contradictory pair was detected by the page-local scan; this is a screening conclusion, not a claim that the page has no editorial ambiguity. - None.

## Rule 6 Findings: subject Field Requires patient and/or subject Search Parameter
- Screening result: source context contains 3 subject-related occurrence(s); representative context: `these subjects. Many other resources refer back to these as either the subject of care, or are somehow`.
- Detected subject context: `fhir-repo/source/administration-module.html`; the scan did not prove that every occurrence is a resource element.
- Search parameters observed on the page: patient, subject. No unsupported Rule 6 violation is asserted without a resource-specific subject definition.

## Cross-Rule Synthesis
- The rendered page and matching source context were present, the build freshness gate passed, and all six rule checks were evaluated. Rule 1 recorded 4 conformance-term occurrence(s); no additional cross-rule conflict was found.

## Blocking Issues
- None.
