# Non-Technical FHIR Review Report

## Metadata
- Review ID: exchanging-polling-2026-08-14
- Date: 2026-08-14
- Mode: page
- Target input: fhir-repo/publish/exchanging-polling.html
- Resolved output page: fhir-repo/publish/exchanging-polling.html
- Status: ready

## Build Evidence
- Build check command: `./.github/skills/build-fhir/scripts/build-if-needed.sh --repo ./fhir-repo --mode check`
- Build check result: `BUILD_NEEDED: no`
- Notes: Existing build freshness was verified before review. No rebuild was performed.

## Inputs Used
- Source files:
  - fhir-repo/source/exchanging-polling.html
  - The requested `fhir-repo/source/exchanging-polling.xml` does not exist; the matching source context is the HTML source file above.
- Output files:
  - fhir-repo/publish/exchanging-polling.html

## Rule 1 Findings: Normative Language on Informative Pages
- Finding ID: R1-001; Rule ID: rule1; Severity: warning; Confidence: high
- Location: fhir-repo/publish/exchanging-polling.html, section 3.1.1 / polling frequency paragraph
- Evidence snippet: `Provided the relevant tables are indexed by _lastUpdated, this should also dramatically increase the efficiency...`
- Rationale: `should` expresses a recommendation on an informative page.
- Suggested rewrite: `Provided the relevant tables are indexed by _lastUpdated, this is also expected to dramatically increase the efficiency...`

- Finding ID: R1-002; Rule ID: rule1; Severity: error; Confidence: high
- Location: fhir-repo/publish/exchanging-polling.html, section 3.1.3 / polling a single record
- Evidence snippet: `separate requests must be made for each record being monitored.`
- Rationale: `must` imposes a mandatory requirement on an informative page.
- Suggested rewrite: `separate requests are made for each record being monitored.`

- Finding ID: R1-003; Rule ID: rule1; Severity: warning; Confidence: high
- Location: fhir-repo/publish/exchanging-polling.html, section 3.1.4.2 / polling across records
- Evidence snippet: `whatever query mechanism is used, it should include the filter of &_lastUpdated=gt[sometimestamp]...`
- Rationale: `should` presents normative guidance on an informative page.
- Suggested rewrite: `whatever query mechanism is used, it is recommended to include the filter of &_lastUpdated=gt[sometimestamp]...`

## Rule 2 Findings: Normative Language in note/summary/comment Fields
- None. No FHIR resource element note, summary, or comment fields were found.

## Rule 3 Findings: Regulatory Expressions vs Description
- None. Regulatory expressions and their corresponding same-page descriptions align.

## Rule 4 Findings: FHIRPath Expressions vs Description
- None. `&_lastUpdated=gt[sometimestamp]` is search syntax, not FHIRPath, and its description correctly relates it to `meta.lastUpdated`.

## Rule 5 Findings: Contradictions on Page
- None. No internal contradiction was found.

## Rule 6 Findings: subject Field Requires patient and/or subject Search Parameter
- None. Not applicable: this is an exchange-workflow page, not resource documentation, and no resource `subject` element was detected.
- subject context: None detected.
- search parameters observed: No resource search-parameter inventory is documented.

## Cross-Rule Synthesis
- Rule 1 found three informative-page normative-language findings: one error-level `must` and two warning-level `should` terms. Rules 2 through 6 found no additional issues.

## Blocking Issues
- None. The missing requested XML source path is non-blocking because the matching source context exists at `fhir-repo/source/exchanging-polling.html`.
