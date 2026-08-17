# Technical Corrections Review Report

## Metadata
- Date: 2026-08-07
- Mode: page
- Target input: search.html
- Resolved output page: /home/nly98977/SwArchives/bvdh/fhir-ai-implementer/fhir-repo/publish/search.html
- Status: READY-FOR-TECHNICAL-CHECKS

## Build Evidence
- Build check command: ./.github/skills/build-fhir/scripts/build-if-needed.sh --repo ./fhir-repo --mode check
- Build check result: BUILD_NEEDED: no

## Inputs Used
- Source files:
  - /home/nly98977/SwArchives/bvdh/fhir-ai-implementer/fhir-repo/source/search.html
  - /home/nly98977/SwArchives/bvdh/fhir-ai-implementer/fhir-repo/source/searchparameter/searchparameter-introduction.xml
  - /home/nly98977/SwArchives/bvdh/fhir-ai-implementer/fhir-repo/source/searchparameter/searchparameter-notes.xml
- Output files:
  - /home/nly98977/SwArchives/bvdh/fhir-ai-implementer/fhir-repo/publish/search.html

## Technical Findings: W3C Style (Sections 7.2, 7.3, 11, 13)
- Section 7.2 Citation: no findings.
- Section 7.3 Citing references within a document: no findings.
- Section 11 Editorial guidelines:
  - Finding ID: F-11-001
  - Severity: low
  - Confidence: high
  - Location: fhir-repo/source/search.html#L154
  - Evidence snippet: `when describing the format of token parameters`
  - Rationale: sentence starts with lowercase after a full stop.
  - Patch-ready proposed text: `When describing the format of <code>token</code> parameters,`
  - Finding ID: F-11-002
  - Severity: low
  - Confidence: high
  - Location: fhir-repo/source/search.html#L225
  - Evidence snippet: `Note: There is a special search`
  - Rationale: awkward sentence break weakens editorial flow.
  - Patch-ready proposed text: `There is also a special search`
  - Finding ID: F-11-003
  - Severity: medium
  - Confidence: high
  - Location: fhir-repo/source/search.html#L673
  - Evidence snippet: `The kinds of comparators allowed depends on the type`
  - Rationale: subject-verb disagreement.
  - Patch-ready proposed text: `The kinds of comparators allowed depend on the type`
  - Finding ID: F-11-004
  - Severity: medium
  - Confidence: high
  - Location: fhir-repo/source/search.html#L680
  - Evidence snippet: `Generally, an single search test can be broken down`
  - Rationale: incorrect article usage.
  - Patch-ready proposed text: `Generally, a single search test can be broken down`
  - Finding ID: F-11-005
  - Severity: medium
  - Confidence: high
  - Location: fhir-repo/source/search.html#L690
  - Evidence snippet: `Each of these 'parts' of a search test have a lot of flexibility.`
  - Rationale: singular subject requires singular verb.
  - Patch-ready proposed text: `Each of these 'parts' of a search test has a lot of flexibility.`
- Section 13 Commonly misspelled terms: no findings.

## Technical Findings: Link Target Validation
- Finding ID: LNK-001
  - Severity: error
  - Confidence: high
  - Location: fhir-repo/publish/search.html#L388
  - Evidence snippet: repeated in-page links `#get` and `#post` have no matching anchors on the page.
  - Rationale: broken internal toggle links.
- Finding ID: LNK-002
  - Severity: warning
  - Confidence: high
  - Location: fhir-repo/publish/search.html#L6528
  - Evidence snippet: repeated in-page links `#json` and `#xml` have no matching anchors on the page.
  - Rationale: broken internal format-toggle links.
- Finding ID: LNK-003
  - Severity: warning
  - Confidence: high
  - Location: fhir-repo/publish/search.html#L6392
  - Evidence snippet: `_summary` value links such as `#summary-true` target anchors that do not exist.
  - Rationale: broken internal row links.
- Finding ID: LNK-004
  - Severity: warning
  - Confidence: high
  - Location: fhir-repo/publish/search.html#L6526
  - Evidence snippet: `bundle-definitions.html#Bundle.entry.score`
  - Rationale: target file exists but anchor does not; likely intended target is `Bundle.entry.search.score`.
- Finding ID: LNK-005
  - Severity: info
  - Confidence: high
  - Location: fhir-repo/publish/search.html#L6814
  - Evidence snippet: external GraphDefinition URL returns HTTP 404.
  - Rationale: unreachable external reference.

## Technical Findings: Link Description Alignment
- Finding ID: LNK-006
  - Severity: warning
  - Confidence: high
  - Location: fhir-repo/publish/search.html#L8475
  - Evidence snippet: `<a href="datatypes.html#Annotation">Attachment</a>`
  - Rationale: visible text says `Attachment` but target anchor is `Annotation`.

## Technical Findings: Spelling
- No findings under the spelling-specific pass.

## Technical Findings: Other Technical Corrections
- No additional findings.

## Patch-Ready Changes
- Change ID: CHG-001
  - Target file: fhir-repo/source/search.html
  - Anchor: HTTP verb selector blocks
  - Edit type: insert-before
  - Current text (exact): `<span class="http-verb-selector">Show as unencoded: <a href="#get">HTTP GET</a> | <a href="#post">HTTP POST</a></span>`
  - Proposed text (exact): `<a name="get"></a><a name="post"></a><span class="http-verb-selector">Show as unencoded: <a href="#get">HTTP GET</a> | <a href="#post">HTTP POST</a></span>`
  - Occurrence rule: first occurrence under `Notes on URL-Encoding`; assess whether shared template logic should emit anchors once per page.
  - Rationale: restores in-page targets for repeated GET/POST toggle links.
  - Validation check: rebuilt page contains anchors `#get` and `#post`.
- Change ID: CHG-002
  - Target file: fhir-repo/source/search.html
  - Anchor: first FHIR example block in `_score`
  - Edit type: insert-before
  - Current text (exact): `<span class="example-format-selector">Show as: <a href="#json">FHIR+JSON</a> | <a href="#xml">FHIR+XML</a></span>`
  - Proposed text (exact): `<a name="json"></a><a name="xml"></a><span class="example-format-selector">Show as: <a href="#json">FHIR+JSON</a> | <a href="#xml">FHIR+XML</a></span>`
  - Occurrence rule: first occurrence under `Relevance (_score)`; assess whether shared template logic should emit anchors once per page.
  - Rationale: restores in-page targets for repeated JSON/XML toggle links.
  - Validation check: rebuilt page contains anchors `#json` and `#xml`.
- Change ID: CHG-003
  - Target file: fhir-repo/source/search.html
  - Anchor: `_summary` value table
  - Edit type: insert-before / repeat pattern
  - Current text (representative exact): `<td><a href="#summary-true">true</a></td>`
  - Proposed text (representative exact): `<td><a name="summary-true"></a><a href="#summary-true">true</a></td>`
  - Occurrence rule: apply same pattern for `summary-true`, `summary-text`, `summary-data`, `summary-count`, and `summary-false`.
  - Rationale: creates local anchor targets for `_summary` row links.
  - Validation check: rebuilt page contains all five `_summary` anchors.
- Change ID: CHG-004
  - Target file: fhir-repo/source/search.html
  - Anchor: `Relevance (_score)`
  - Edit type: replace
  - Current text (exact): `bundle-definitions.html#Bundle.entry.score`
  - Proposed text (exact): `bundle-definitions.html#Bundle.entry.search.score`
  - Occurrence rule: unique in file.
  - Rationale: current anchor is missing; likely intended nested search score anchor.
  - Validation check: rebuilt link resolves to existing anchor in `bundle-definitions.html`.
- Change ID: CHG-005
  - Target file: fhir-repo/source/search.html
  - Anchor: `_graph` paragraph
  - Edit type: replace
  - Current text (exact): `http://build.fhir.org/HL7/api-incubator/StructureDefinition-GraphDefinition`
  - Proposed text (exact): BLOCKED
  - Occurrence rule: unique in file.
  - Rationale: current URL 404s, but replacement target was not verified in this run.
  - Validation check: replacement URL returns 2xx/3xx.
- Change ID: CHG-006
  - Target file: fhir-repo/source/search.html
  - Anchor: datatype summary table row for `Attachment`
  - Edit type: replace
  - Current text (exact): `<td><a href="datatypes.html#Annotation">Attachment</a></td>`
  - Proposed text (exact): `<td><a href="datatypes.html#Attachment">Attachment</a></td>`
  - Occurrence rule: unique in file.
  - Rationale: aligns visible link text with target datatype heading.
  - Validation check: rebuilt page points `Attachment` to `Attachment` anchor in `datatypes.html`.

## Blocking Issues
- None.
