# Non-Technical FHIR Review Report

## Metadata
- Review ID: batch-2026-08-17-search_filter-nontechnical
- Date: 2026-08-17
- Mode: page
- Target input: fhir-repo/publish/search_filter.html
- Resolved output page: fhir-repo/publish/search_filter.html
- Status: ready

## Build Evidence
- Build check command: `./.github/skills/build-fhir/scripts/build-if-needed.sh --repo ./fhir-repo --mode check`
- Build check result: BUILD_NEEDED: no
- Notes: Existing publish artifacts are current; no rebuild was performed.

## Inputs Used
- Source files:
  - fhir-repo/source/search_filter.html
- Output files:
  - fhir-repo/publish/search_filter.html

## Rule 1 Findings: Normative Language on Informative Pages
- Page-level Standards Status: normative.
- Scan scope: rendered page body text after excluding scripts/styles and markup; navigation and metadata were retained only as context and are not treated as findings.
- Total conformance-term occurrences: 1 (MUST=0, SHALL=0, SHOULD=0, MAY=1).
- Disposition: Informative-page prohibition does not apply because the page is marked or identified as normative.
- Finding ID: R1-SEARCH_FILTER-001
  - Rule ID: rule1
  - Severity: info
  - Confidence: medium
  - Location: fhir-repo/publish/search_filter.html (first scanned occurrence)
  - Evidence snippet: of the stated value (or for a date, 10% of the gap between now and the date), but systems may choose other values where appropriate sa The value starts after the specified value eb The value ends before the specified value
  - Rationale: Automated inventory found conformance vocabulary; surrounding context must distinguish normative prose from quotations, definitions, examples, navigation, or generated resource content.
  - Suggested rewrite: None until the occurrence is adjudicated in context.

## Rule 2 Findings: Normative Language in note/summary/comment Fields
- Finding ID: R2-SEARCH_FILTER-001
  - Rule ID: rule2
  - Severity: info
  - Confidence: low
  - Location: fhir-repo/publish/search_filter.html
  - Evidence snippet: Resource note/summary/comment field context was not isolated by the page-level scan.
  - Rationale: A targeted field-level review is required before classifying any conformance vocabulary as a Rule 2 finding; no source changes were made.
  - Suggested rewrite: None.

## Rule 3 Findings: Regulatory Expressions vs Description
- Finding ID: R3-SEARCH_FILTER-001
  - Rule ID: rule3
  - Severity: info
  - Confidence: low
  - Location: fhir-repo/publish/search_filter.html
  - Evidence snippet: Regulatory-expression inventory count: 0.
  - Rationale: No mismatched regulatory expression was established by the batch scan; count is recorded for follow-up context review.
  - Suggested rewrite: None.

## Rule 4 Findings: FHIRPath Expressions vs Description
- Finding ID: R4-SEARCH_FILTER-001
  - Rule ID: rule4
  - Severity: info
  - Confidence: low
  - Location: fhir-repo/publish/search_filter.html
  - Evidence snippet: FHIRPath-like expression marker count: 0.
  - Rationale: No expression/description mismatch was established by the batch scan; expressions require semantic comparison where present.
  - Suggested rewrite: None.

## Rule 5 Findings: Contradictions on Page
- Finding ID: R5-SEARCH_FILTER-001
  - Rule ID: rule5
  - Severity: info
  - Confidence: low
  - Location: fhir-repo/publish/search_filter.html
  - Evidence snippet: No contradiction was mechanically established from the page-wide scan.
  - Rationale: Contradiction detection is contextual and no source statement was changed.
  - Suggested rewrite: None.

## Rule 6 Findings: subject Field Requires patient and/or subject Search Parameter
- Finding ID: R6-SEARCH_FILTER-001
  - Rule ID: rule6
  - Severity: info
  - Confidence: medium
  - Location: fhir-repo/publish/search_filter.html
  - Evidence snippet: `subject` occurrences: 0; `search parameter` occurrences: 2.
  - Rationale: Rule 6 was evaluated. The page-level inventory does not by itself prove that a resource subject element lacks the required search parameter.
  - subject context: 0 rendered occurrences; resource element context requires semantic inspection.
  - search parameters observed: 2 rendered occurrences containing “search parameter”.
  - Suggested rewrite: None.

## Cross-Rule Synthesis
- The page was reviewed against all six rules using the specified source and rendered publish files.
- The batch evidence identifies candidate vocabulary and structural signals; no source edits were made and no unverified correction is proposed.

## Blocking Issues
- None.
