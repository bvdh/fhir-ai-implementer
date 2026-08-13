# Non-Technical FHIR Review Report

## Metadata
- Date: 2026-08-07
- Mode: page
- Target input: imagingstudy.html
- Resolved output page: /home/nly98977/SwArchives/bvdh/fhir-ai-implementer/fhir-repo/publish/html/imagingstudy.html
- Status: READY-FOR-RULE-AGENTS

## Build Evidence
- Build check command: ./.github/skills/build-fhir/scripts/build-if-needed.sh --repo ./fhir-repo --mode check
- Build check result: BUILD_NEEDED: no

## Inputs Used
- Output file:
  - /home/nly98977/SwArchives/bvdh/fhir-ai-implementer/fhir-repo/publish/html/imagingstudy.html
- Source context files:
  - /home/nly98977/SwArchives/bvdh/fhir-ai-implementer/fhir-repo/source/imagingstudy/imagingstudy-introduction.xml
  - /home/nly98977/SwArchives/bvdh/fhir-ai-implementer/fhir-repo/source/imagingstudy/imagingstudy-notes.xml
  - /home/nly98977/SwArchives/bvdh/fhir-ai-implementer/fhir-repo/source/imagingstudy/imagingstudy-example.xml

## Agent Input Payload
- target_input: imagingstudy.html
- resolved_output_page: /home/nly98977/SwArchives/bvdh/fhir-ai-implementer/fhir-repo/publish/html/imagingstudy.html
- source_context_hint: fhir-repo/source/**

## Rule 1 Findings: Normative Language on Informative Pages
- No findings.
- Rationale: page is in normative context (Standards Status = Normative), so normative keywords observed in constraints/tooltips are not Rule 1 informative-page violations.

## Rule 2 Findings: Normative Language in note/summary/comment Fields
- No findings.

## Rule 3 Findings: Regulatory Expressions vs Description
- Finding ID: R3-IMG-001
  - Rule ID: rule3
  - Severity: error
  - Confidence: high
  - Location: fhir-repo/publish/html/imagingstudy.html (ImagingStudy.numberOfInstances)
  - Evidence snippet: Description allows partial instance population, while constraint text requires numberOfInstances to equal total instance count when both are present.
  - Rationale: same-page wording creates semantic ambiguity between permissive prose and SHALL-equality constraints.
  - Suggested rewrite: clarify conditional behavior, e.g. equality required when both values are present; permissive wording only when instance lists are not fully populated.
- Finding ID: R3-IMG-002
  - Rule ID: rule3
  - Severity: error
  - Confidence: high
  - Location: fhir-repo/publish/html/imagingstudy.html (ImagingStudy.series.numberOfInstances)
  - Evidence snippet: "numberOfInstances SHALL match number of instance elements" vs prose saying value MAY be larger than number of instance elements.
  - Rationale: direct contradiction unless conditioned on partial population.
  - Suggested rewrite: add explicit condition so MAY-be-larger applies only when instance elements are not fully populated.

## Rule 4 Findings: FHIRPath Expressions vs Description
- No findings.
- Evidence note: no explicit inline FHIRPath expressions were detected on this rendered page for comparison.

## Rule 5 Findings: Contradictions on Page
- No findings.

## Rule 6 Findings: subject Field Requires patient and/or subject Search Parameter
- No findings.
- Detected `subject` element context: present.
- Observed search-parameter inventory in rendered documentation set: `based-on`, `body-site`, `body-structure`, `dicom-class`, `encounter`, `endpoint`, `identifier`, `instance`, `modality`, `patient`, `performer`, `procedure`, `reason-concept`, `reason-reference`, `referrer`, `series`, `started`, `status`, `subject`.
- Search pages checked: `fhir-repo/publish/html/imagingstudy.html`, `fhir-repo/publish/imagingstudy.html`, `fhir-repo/publish/imagingstudy-search.html`.
- Rationale: Rule 6 passes because companion rendered search documentation defines both `patient` and `subject` for ImagingStudy.

## Cross-Rule Synthesis
- Main risk is consistency: Rule 3 shows high-severity wording conflicts around instance-count semantics.
- Rule 6 is satisfied when the companion rendered search page is included in the review scope.
- Rules 1, 2, 4, 5, and 6 are otherwise clean for this target.

## Blocking Issues
- None.
