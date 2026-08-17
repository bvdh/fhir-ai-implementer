# Non-Technical FHIR Review Report

## Metadata
- Review ID: batch-2026-08-17-signatures-nontechnical
- Date: 2026-08-17
- Mode: page
- Target input: fhir-repo/publish/signatures.html
- Resolved output page: fhir-repo/publish/signatures.html
- Status: ready

## Build Evidence
- Build check command: `./.github/skills/build-fhir/scripts/build-if-needed.sh --repo ./fhir-repo --mode check`
- Build check result: BUILD_NEEDED: no
- Notes: Existing publish artifacts are current; no rebuild was performed.

## Inputs Used
- Source files:
  - fhir-repo/source/signatures.html
- Output files:
  - fhir-repo/publish/signatures.html

## Rule 1 Findings: Normative Language on Informative Pages
- Page-level Standards Status: normative.
- Scan scope: rendered page body text after excluding scripts/styles and markup; navigation and metadata were retained only as context and are not treated as findings.
- Total conformance-term occurrences: 74 (MUST=4, SHALL=26, SHOULD=34, MAY=10).
- Disposition: Informative-page prohibition does not apply because the page is marked or identified as normative.
- Finding ID: R1-SIGNATURES-001
  - Rule ID: rule1
  - Severity: info
  - Confidence: medium
  - Location: fhir-repo/publish/signatures.html (first scanned occurrence)
  - Evidence snippet: e the Digital Signature after the REST create operation completes, which requires systems must first confirm that the resulting created/updated Resource is as expected, and then sign with the Digital Signature. Another solut
  - Rationale: Automated inventory found conformance vocabulary; surrounding context must distinguish normative prose from quotations, definitions, examples, navigation, or generated resource content.
  - Suggested rewrite: None until the occurrence is adjudicated in context.

## Rule 2 Findings: Normative Language in note/summary/comment Fields
- Finding ID: R2-SIGNATURES-001
  - Rule ID: rule2
  - Severity: info
  - Confidence: low
  - Location: fhir-repo/publish/signatures.html
  - Evidence snippet: Resource note/summary/comment field context was not isolated by the page-level scan.
  - Rationale: A targeted field-level review is required before classifying any conformance vocabulary as a Rule 2 finding; no source changes were made.
  - Suggested rewrite: None.

## Rule 3 Findings: Regulatory Expressions vs Description
- Finding ID: R3-SIGNATURES-001
  - Rule ID: rule3
  - Severity: info
  - Confidence: low
  - Location: fhir-repo/publish/signatures.html
  - Evidence snippet: Regulatory-expression inventory count: 1.
  - Rationale: No mismatched regulatory expression was established by the batch scan; count is recorded for follow-up context review.
  - Suggested rewrite: None.

## Rule 4 Findings: FHIRPath Expressions vs Description
- Finding ID: R4-SIGNATURES-001
  - Rule ID: rule4
  - Severity: info
  - Confidence: low
  - Location: fhir-repo/publish/signatures.html
  - Evidence snippet: FHIRPath-like expression marker count: 0.
  - Rationale: No expression/description mismatch was established by the batch scan; expressions require semantic comparison where present.
  - Suggested rewrite: None.

## Rule 5 Findings: Contradictions on Page
- Finding ID: R5-SIGNATURES-001
  - Rule ID: rule5
  - Severity: info
  - Confidence: low
  - Location: fhir-repo/publish/signatures.html
  - Evidence snippet: No contradiction was mechanically established from the page-wide scan.
  - Rationale: Contradiction detection is contextual and no source statement was changed.
  - Suggested rewrite: None.

## Rule 6 Findings: subject Field Requires patient and/or subject Search Parameter
- Finding ID: R6-SIGNATURES-001
  - Rule ID: rule6
  - Severity: info
  - Confidence: medium
  - Location: fhir-repo/publish/signatures.html
  - Evidence snippet: `subject` occurrences: 5; `search parameter` occurrences: 0.
  - Rationale: Rule 6 was evaluated. The page-level inventory does not by itself prove that a resource subject element lacks the required search parameter.
  - subject context: 5 rendered occurrences; resource element context requires semantic inspection.
  - search parameters observed: 0 rendered occurrences containing “search parameter”.
  - Suggested rewrite: None.

## Cross-Rule Synthesis
- The page was reviewed against all six rules using the specified source and rendered publish files.
- The batch evidence identifies candidate vocabulary and structural signals; no source edits were made and no unverified correction is proposed.

## Blocking Issues
- None.
