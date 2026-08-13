# Non-Technical FHIR Review Report

## Metadata
- Date: 2026-08-07
- Mode: page
- Target input: search.html
- Resolved output page: /home/nly98977/SwArchives/bvdh/fhir-ai-implementer/fhir-repo/publish/search.html
- Status: READY-FOR-RULE-AGENTS

## Build Evidence
- Build check command: ./.github/skills/build-fhir/scripts/build-if-needed.sh --repo ./fhir-repo --mode check
- Build check result: BUILD_NEEDED: no

## Inputs Used
- Output file:
  - /home/nly98977/SwArchives/bvdh/fhir-ai-implementer/fhir-repo/publish/search.html
- Source context files:
  - /home/nly98977/SwArchives/bvdh/fhir-ai-implementer/fhir-repo/source/search.html
  - /home/nly98977/SwArchives/bvdh/fhir-ai-implementer/fhir-repo/source/searchparameter/searchparameter-introduction.xml
  - /home/nly98977/SwArchives/bvdh/fhir-ai-implementer/fhir-repo/source/searchparameter/searchparameter-notes.xml

## Agent Input Payload
- target_input: search.html
- resolved_output_page: /home/nly98977/SwArchives/bvdh/fhir-ai-implementer/fhir-repo/publish/search.html
- source_context_hint: fhir-repo/source/**

## Rule 1 Findings: Normative Language on Informative Pages
- No findings.
- Rationale: the page is normative in source context, so Rule 1 does not apply.

## Rule 2 Findings: Normative Language in note/summary/comment Fields
- No findings.

## Rule 3 Findings: Regulatory Expressions vs Description
- Finding ID: R3-SEARCH-001
  - Rule ID: rule3
  - Severity: warning
  - Confidence: high
  - Location: fhir-repo/source/search.html#L5289
  - Evidence snippet: description says "Only elements that are listed are to be returned." while later conformance text says servers "SHOULD return mandatory and modifier elements whether they are requested or not."
  - Rationale: the first sentence reads as absolute, but the later rule creates an explicit exception, which is a same-page alignment issue.
  - Suggested rewrite: "Only listed elements are to be returned, except that servers may also return mandatory and modifier elements, and clients should expect those elements to be present."

## Rule 4 Findings: FHIRPath Expressions vs Description
- No findings.

## Rule 5 Findings: Contradictions on Page
- Finding ID: rule5-001
  - Rule ID: rule5
  - Severity: error
  - Confidence: high
  - Location: fhir-repo/publish/search.html (section on `below` with `uri` search parameters)
  - Evidence snippet: GET example uses `url:below=http://acme.org/fhir` while paired POST example uses `url:above=http://acme.org/fhir`.
  - Rationale: the POST example reverses the modifier direction in what is presented as the same example, creating an internal contradiction.
  - Suggested rewrite: change the POST example to `url:below=http://acme.org/fhir`.

## Rule 6 Findings: subject Field Requires patient and/or subject Search Parameter
- No findings.
- Detected `subject` element context: not present.
- Observed search-parameter inventory on the page: not applicable; this is the general search documentation page, not a resource page.
- Search pages checked: `fhir-repo/publish/search.html`; derived companion `fhir-repo/publish/search-search.html` not present.
- Rationale: Rule 6 only triggers for resource pages with a `subject` element.

## Cross-Rule Synthesis
- The page is generally consistent, but there are two important clarity defects:
- Rule 3: `_elements` description overstates exclusivity relative to later mandatory/modifier-element guidance.
- Rule 5: the `below`/`above` example pair is contradictory and likely to mislead implementers.
- Rules 1, 2, 4, and 6 did not produce findings for this target.

## Blocking Issues
- None.
