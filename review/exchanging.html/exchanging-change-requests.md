# Non-Technical FHIR Review Report

## Metadata
- Review ID: exchanging-2026-08-14
- Date: 2026-08-14
- Mode: page
- Target input: fhir-repo/publish/exchanging.html
- Resolved output page: fhir-repo/publish/exchanging.html
- Status: ready

## Build Evidence
- Build check command: `./.github/skills/build-fhir/scripts/build-if-needed.sh --repo ./fhir-repo --mode check`
- Build check result: BUILD_NEEDED: no
- Build status used for review: current

## Inputs Used
- Source context requested: fhir-repo/source/exchanging.xml (not present in workspace)
- Output file:
  - fhir-repo/publish/exchanging.html
- Source-context note: the requested XML source path was checked and unavailable; findings are based on the resolved published page.

## Rule 1 Findings: Normative Language on Informative Pages
- Finding ID: R1-001
  - Rule ID: rule1
  - Severity: error
  - Confidence: high
  - Location: fhir-repo/publish/exchanging.html, About this section
  - Evidence snippet: `Implementation guides SHOULD provide an explanation of the considerations...` (also repeated at the following paragraph)
  - Rationale: Uppercase SHOULD is normative language on an informative page.
  - Suggested rewrite: `Implementation guides are encouraged to provide an explanation of the considerations...`

## Rule 2 Findings: Normative Language in note/summary/comment Fields
- None. No FHIR resource element note, summary, or comment field was identified with normative language.

## Rule 3 Findings: Regulatory Expressions vs Description
- None. Regulatory expressions align with the corresponding same-page descriptions.

## Rule 4 Findings: FHIRPath Expressions vs Description
- None. No concrete FHIRPath expression requiring an expression-to-description comparison was found.

## Rule 5 Findings: Contradictions on Page
- None. No internal prose contradiction was found.

## Rule 6 Findings: subject Field Requires patient and/or subject Search Parameter
- None. Subject context: this is an exchange guidance page, not a resource definition page, and no `subject` element was detected. Search parameters observed: no resource-specific `patient` or `subject` parameter; general search-parameter prose only. Rule 6 is therefore not triggered.

## Cross-Rule Synthesis
- One high-confidence normative-language issue was found: the same uppercase SHOULD sentence appears twice. Rules 2-6 produced no findings; Rule 6 was explicitly evaluated and not applicable.

## Blocking Issues
- None. The published target resolved and the freshness gate passed. The requested source context path `fhir-repo/source/exchanging.xml` is absent, so source-level confirmation was unavailable.

## Finding Counts
- error: 1
- warning: 0
- info: 0
