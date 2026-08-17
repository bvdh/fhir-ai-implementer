# Non-Technical FHIR Review Report

## Metadata
- Date: 2026-08-07
- Mode: page
- Target input: imagingselection.html
- Resolved output page: /home/nly98977/SwArchives/bvdh/fhir-ai-implementer/fhir-repo/publish/html/imagingselection.html
- Status: READY-FOR-RULE-AGENTS

## Build Evidence
- Build check command: ./.github/skills/build-fhir/scripts/build-if-needed.sh --repo ./fhir-repo --mode check
- Build check result: BUILD_NEEDED: no

## Inputs Used
- Output file:
  - /home/nly98977/SwArchives/bvdh/fhir-ai-implementer/fhir-repo/publish/html/imagingselection.html
- Source context files:
  - /home/nly98977/SwArchives/bvdh/fhir-ai-implementer/fhir-repo/source/imagingselection/imagingselection-introduction.xml
  - /home/nly98977/SwArchives/bvdh/fhir-ai-implementer/fhir-repo/source/imagingselection/imagingselection-notes.xml
  - /home/nly98977/SwArchives/bvdh/fhir-ai-implementer/fhir-repo/source/imagingselection/structuredefinition-ImagingSelection.xml

## Agent Input Payload
- target_input: imagingselection.html
- resolved_output_page: /home/nly98977/SwArchives/bvdh/fhir-ai-implementer/fhir-repo/publish/html/imagingselection.html
- source_context_hint: fhir-repo/source/**

## Rule 1 Findings: Normative Language on Informative Pages
- No findings.
- Rationale: the page is normative in rendered/source context, so Rule 1 does not apply.

## Rule 2 Findings: Normative Language in note/summary/comment Fields
- No findings.

## Rule 3 Findings: Regulatory Expressions vs Description
- Finding ID: R3-IS-001
  - Rule ID: rule3
  - Severity: warning
  - Confidence: high
  - Location: fhir-repo/publish/html/imagingselection.html
  - Evidence snippet: page description says `A selection of DICOM SOP instances within a single Study and Series`, while constraint text allows validity with `imageRegion3D` present even if `seriesUid` is absent.
  - Rationale: the prose overstates series-context requirements relative to the same-page conformance model.
  - Suggested rewrite: `A selection of DICOM content within a single Study; it may identify a Series and may further specify frames or image regions, allowing linkage to an Observation Resource.`

## Rule 4 Findings: FHIRPath Expressions vs Description
- Finding ID: R4-ISL6-PATH-MISMATCH
  - Rule ID: rule4
  - Severity: warning
  - Confidence: high
  - Location: fhir-repo/publish/html/imagingselection.html
  - Evidence snippet: invariant constrains top-level `imageRegion3D.exists() implies instance.imageRegion2D.empty()`, while narrative refers to `instance.imageRegion3D - A selected 3D image region`.
  - Rationale: narrative describes `imageRegion3D` as instance-scoped, but the constrained path is top-level `ImagingSelection.imageRegion3D`.
  - Suggested rewrite: describe the element as top-level `imageRegion3D` rather than `instance.imageRegion3D`.

## Rule 5 Findings: Contradictions on Page
- Finding ID: R5-IS-001
  - Rule ID: rule5
  - Severity: error
  - Confidence: high
  - Location: notes sections on Imaging Selection Subsets / Use Case 4 and the element definitions table for `ImagingSelection.imageRegion3D`
  - Evidence snippet: notes describe `instance.imageRegion3D`, while formal definitions model `imageRegion3D` as a root-level element.
  - Rationale: the page assigns the 3D region to two incompatible scopes.
  - Suggested rewrite: change notes text from `instance.imageRegion3D` to `imageRegion3D` and restrict instance-level subset wording to actual instance children.

## Rule 6 Findings: subject Field Requires patient and/or subject Search Parameter
- No findings.
- Detected `subject` element context: present.
- Observed search-parameter inventory in rendered documentation set: `patient`, `status`, `study-uid`, `subject`.
- Search pages checked: `fhir-repo/publish/html/imagingselection.html`, `fhir-repo/publish/imagingselection.html`, `fhir-repo/publish/imagingselection-search.html`.
- Rationale: Rule 6 passes because the companion rendered search page defines both `patient` and `subject` for ImagingSelection.

## Cross-Rule Synthesis
- The main issue cluster is element-scope inconsistency around `imageRegion3D`.
- Rule 3, Rule 4, and Rule 5 all point to the same underlying mismatch between prose and the formal model.
- Rule 6 is satisfied when the companion search page is included in scope.
- Rules 1 and 2 did not produce findings for this target.

## Blocking Issues
- None.
