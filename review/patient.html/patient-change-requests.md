# Non-Technical FHIR Review Report

## Metadata
- Date: 2026-08-07
- Mode: page
- Target input: patient.html
- Resolved output page: /home/nly98977/SwArchives/bvdh/fhir-ai-implementer/fhir-repo/publish/html/patient.html
- Status: READY-FOR-RULE-AGENTS

## Build Evidence
- Build check command: ./.github/skills/build-fhir/scripts/build-if-needed.sh --repo ./fhir-repo --mode check
- Build check result: BUILD_NEEDED: no

## Inputs Used
- Output file:
  - /home/nly98977/SwArchives/bvdh/fhir-ai-implementer/fhir-repo/publish/html/patient.html
- Source context files:
  - /home/nly98977/SwArchives/bvdh/fhir-ai-implementer/fhir-repo/source/patient/patient.xml
  - /home/nly98977/SwArchives/bvdh/fhir-ai-implementer/fhir-repo/source/patient/patient-notes.xml
  - /home/nly98977/SwArchives/bvdh/fhir-ai-implementer/fhir-repo/source/patient/patient-introduction.xml

## Agent Input Payload
- target_input: patient.html
- resolved_output_page: /home/nly98977/SwArchives/bvdh/fhir-ai-implementer/fhir-repo/publish/html/patient.html
- source_context_hint: fhir-repo/source/**

## Rule 1 Findings: Normative Language on Informative Pages
- Finding ID: R1-PAT-001
  - Rule ID: rule1
  - Severity: error
  - Confidence: high
  - Location: fhir-repo/publish/html/patient.html#Patient.modifierExtension
  - Evidence snippet: "Modifier extensions SHALL NOT change the meaning of any elements..."
  - Rationale: Uses normative force (SHALL NOT) in informative-page explanatory text.
  - Suggested rewrite: "Modifier extensions do not change the meaning of any elements..."
- Finding ID: R1-PAT-002
  - Rule ID: rule1
  - Severity: warning
  - Confidence: high
  - Location: fhir-repo/publish/html/patient.html#Patient.gender
  - Evidence snippet: "To be conformant, the concept in this element SHALL be from the specified value set."
  - Rationale: Uses SHALL in informative explanatory text.
  - Suggested rewrite: "For conformance, the concept in this element is expected to come from the specified value set."
- Finding ID: R1-PAT-003
  - Rule ID: rule1
  - Severity: warning
  - Confidence: medium
  - Location: fhir-repo/publish/html/patient.html#Patient.deceased_x_
  - Evidence snippet: "If hours and minutes are specified, a UTC offset SHALL be populated."
  - Rationale: Uses SHALL in informative datatype prose shown on this page.
  - Suggested rewrite: "If hours and minutes are specified, include a UTC offset."
- Finding ID: R1-PAT-004
  - Rule ID: rule1
  - Severity: warning
  - Confidence: high
  - Location: fhir-repo/publish/html/patient.html#Patient.multipleBirth_x_
  - Evidence snippet: "...live births and fetal losses, which MAY be tracked in the patient-multipleBirthTotal extension."
  - Rationale: Uses MAY in informative explanatory text.
  - Suggested rewrite: "...live births and fetal losses, which can be tracked in the patient-multipleBirthTotal extension."

## Rule 2 Findings: Normative Language in note/summary/comment Fields
- Finding ID: R2-PAT-001
  - Rule ID: rule2
  - Severity: error
  - Confidence: medium
  - Location: fhir-repo/publish/html/patient.html (Patient.multipleBirth[x] explanatory text)
  - Evidence snippet: "...live births and fetal losses, which MAY be tracked in the patient-multipleBirthTotal extension."
  - Rationale: MAY appears in note/comment-like explanatory text for a resource element.
  - Suggested rewrite: "...live births and fetal losses, which can be tracked in the patient-multipleBirthTotal extension."

## Rule 3 Findings: Regulatory Expressions vs Description
- No findings.

## Rule 4 Findings: FHIRPath Expressions vs Description
- No findings.
- Evidence note: no explicit FHIRPath expressions detected on this page to compare.

## Rule 5 Findings: Contradictions on Page
- No findings.

## Rule 6 Findings: subject Field Requires patient and/or subject Search Parameter
- No findings.
- Detected subject element context: no `Patient.subject` element exists on the page.
- Observed search-parameter inventory on page: none displayed on this page.
- Rationale: Rule 6 only triggers when a `subject` element exists for the reviewed resource.

## Cross-Rule Synthesis
- Primary issue pattern is normative language leakage into informative/tabular explanatory content (Rules 1 and 2).
- Rules 3, 4, and 5 did not show semantic inconsistencies or contradictions.
- Rule 6 is not applicable for this page because the Patient resource does not define a `subject` element.

## Blocking Issues
- None.
