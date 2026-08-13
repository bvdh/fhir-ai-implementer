# Non-Technical FHIR Review Template

## Metadata

- Review ID: [auto-or-manual-id]
- Date: [YYYY-MM-DD]
- Mode: [page]
- Target input: [path/name]
- Resolved output page: [fhir-repo/output/...|fhir-repo/publish/...]
- Status: [ready|blocked]

## Build Evidence

- Build check command: `./.github/skills/build-fhir/scripts/build-if-needed.sh --repo ./fhir-repo --mode check`
- Build check result: [BUILD_NEEDED: no|yes]
- Notes: [optional]

## Inputs Used

- Source files:
  - [fhir-repo/source/...]

- Output files:
  - [fhir-repo/output/...|fhir-repo/publish/...]

## Rule 1 Findings: Normative Language on Informative Pages

- [finding or None]

## Rule 2 Findings: Normative Language in note/summary/comment Fields

- [finding or None]

## Rule 3 Findings: Regulatory Expressions vs Description

- [finding or None]

## Rule 4 Findings: FHIRPath Expressions vs Description

- [finding or None]

## Rule 5 Findings: Contradictions on Page

- [finding or None]

## Rule 6 Findings: subject Field Requires patient and/or subject Search Parameter

- [finding or None]

## Cross-Rule Synthesis

- [summary or None]

## Finding Record Format

For each finding, include:

- Finding ID: [R1-001, R2-001, ...]
- Rule ID: [rule1|rule2|rule3|rule4|rule5|rule6]
- Severity: [error|warning|info]
- Confidence: [high|medium|low]
- Location: [file + heading/anchor]
- Evidence snippet: [exact excerpt]
- Rationale: [brief reason]
- Suggested rewrite: [optional]

Rule 6 finding evidence must also include:

- subject context: [where subject element was detected]
- search parameters observed: [list from the page]

## Blocking Issues

- [None|details]
