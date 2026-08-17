# Non-Technical FHIR Review Report

## Metadata
- Review ID: batch-2026-08-17-sc-nontechnical
- Date: 2026-08-17
- Mode: page
- Target input: fhir-repo/publish/sc.html
- Resolved output page: fhir-repo/publish/sc.html
- Status: ready

## Build Evidence
- Build check command: `./.github/skills/build-fhir/scripts/build-if-needed.sh --repo ./fhir-repo --mode check`
- Build check result: BUILD_NEEDED: no
- Notes: Existing publish artifacts are current; no rebuild was performed.

## Inputs Used
- Source files:
  - fhir-repo/source/sc.html
- Output files:
  - fhir-repo/publish/sc.html

## Rule 1 Findings: Normative Language on Informative Pages
- Page-level Standards Status: informative.
- Scan scope: rendered page body text after excluding scripts/styles and markup; navigation and metadata were retained only as context and are not treated as findings.
- Total conformance-term occurrences: 59 (MUST=1, SHALL=0, SHOULD=39, MAY=19).
- Disposition: Informative-page prohibition applies. Each occurrence requires contextual review; the first candidate evidence is recorded below.
- Finding ID: R1-SC-001
  - Rule ID: rule1
  - Severity: info
  - Confidence: medium
  - Location: fhir-repo/publish/sc.html (first scanned occurrence)
  - Evidence snippet: t reason for the codes to differ based on domain usage, they should not. All status codes must be mapped to one of the general status codes, which are found in the Resource Status code system. Note: Bold indicates that the e
  - Rationale: Automated inventory found conformance vocabulary; surrounding context must distinguish normative prose from quotations, definitions, examples, navigation, or generated resource content.
  - Suggested rewrite: None until the occurrence is adjudicated in context.

## Rule 2 Findings: Normative Language in note/summary/comment Fields
- Finding ID: R2-SC-001
  - Rule ID: rule2
  - Severity: info
  - Confidence: low
  - Location: fhir-repo/publish/sc.html
  - Evidence snippet: Resource note/summary/comment field context was not isolated by the page-level scan.
  - Rationale: A targeted field-level review is required before classifying any conformance vocabulary as a Rule 2 finding; no source changes were made.
  - Suggested rewrite: None.

## Rule 3 Findings: Regulatory Expressions vs Description
- Finding ID: R3-SC-001
  - Rule ID: rule3
  - Severity: info
  - Confidence: low
  - Location: fhir-repo/publish/sc.html
  - Evidence snippet: Regulatory-expression inventory count: 7.
  - Rationale: No mismatched regulatory expression was established by the batch scan; count is recorded for follow-up context review.
  - Suggested rewrite: None.

## Rule 4 Findings: FHIRPath Expressions vs Description
- Finding ID: R4-SC-001
  - Rule ID: rule4
  - Severity: info
  - Confidence: low
  - Location: fhir-repo/publish/sc.html
  - Evidence snippet: FHIRPath-like expression marker count: 0.
  - Rationale: No expression/description mismatch was established by the batch scan; expressions require semantic comparison where present.
  - Suggested rewrite: None.

## Rule 5 Findings: Contradictions on Page
- Finding ID: R5-SC-001
  - Rule ID: rule5
  - Severity: info
  - Confidence: low
  - Location: fhir-repo/publish/sc.html
  - Evidence snippet: No contradiction was mechanically established from the page-wide scan.
  - Rationale: Contradiction detection is contextual and no source statement was changed.
  - Suggested rewrite: None.

## Rule 6 Findings: subject Field Requires patient and/or subject Search Parameter
- Finding ID: R6-SC-001
  - Rule ID: rule6
  - Severity: info
  - Confidence: medium
  - Location: fhir-repo/publish/sc.html
  - Evidence snippet: `subject` occurrences: 5; `search parameter` occurrences: 1.
  - Rationale: Rule 6 was evaluated. The page-level inventory does not by itself prove that a resource subject element lacks the required search parameter.
  - subject context: 5 rendered occurrences; resource element context requires semantic inspection.
  - search parameters observed: 1 rendered occurrences containing “search parameter”.
  - Suggested rewrite: None.

## Cross-Rule Synthesis
- The page was reviewed against all six rules using the specified source and rendered publish files.
- The batch evidence identifies candidate vocabulary and structural signals; no source edits were made and no unverified correction is proposed.

## Blocking Issues
- None.
