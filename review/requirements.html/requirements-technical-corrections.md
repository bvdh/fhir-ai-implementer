# Technical Corrections Review Report

## Metadata

- Review ID: requirements-technical-2026-08-14
- Date: 2026-08-14
- Mode: page
- Target: `fhir-repo/publish/requirements.html`
- Ticket: None

## Build Evidence

- Build check command: `./.github/skills/build-fhir/scripts/build-if-needed.sh --repo ./fhir-repo --mode check`
- Build check result: `BUILD_NEEDED: no`
- Build status used for review: current
- Additional evidence: The rendered target resolved to `fhir-repo/publish/requirements.html`.

## Inputs Used

- Source files:
  - `fhir-repo/source/requirement.xml`
  - `fhir-repo/source/requirements/requirements-introduction.xml`
  - `fhir-repo/source/requirements/requirements-notes.xml`

- Output files:
  - `fhir-repo/publish/requirements.html`
  - `fhir-repo/publish/requirements-search.html`

## W3C Findings

### Section 7.2

- None identified.

### Section 7.3

- None identified.

### Section 11

- **Finding W3C-001: Missing Verb (Grammar)**
  - Location: Section "Scope and Usage", line ~181
  - Current text: "The Requirements Resource a set of statements that are requirements for some design artifact to meet."
  - Issue: Subject-verb agreement error; missing copula verb "is"
  - Severity: error
  - Confidence: high
  - Suggested correction: "The Requirements Resource **is** a set of statements that are requirements for some design artifact to meet."

- **Finding W3C-002: Repeated Word**
  - Location: Navigation breadcrumb, line ~162
  - Current text: "Directory of published versions for published versions"
  - Issue: Violates W3C Section 11 requirement to avoid repeated words; "published versions" appears twice consecutively
  - Severity: warning
  - Confidence: high
  - Suggested correction: "Directory of published versions"

### Section 13

- No violations detected. Document uses proper capitalization and spelling conventions (e.g., "URIs" not "URI's").

## Link Target Validation Findings

- No issues detected. All six prose links reviewed (ImplementationGuide, PlanDefinition, ActivityDefinition, Requirements Satisfied extension, CanonicalResource, Provenance) resolve to valid targets.

## Link Description Correspondence Findings

- No issues detected. All link text aligns appropriately with target headings and content intent.

## Spelling Findings

- No spelling issues found in the review scope. Document adheres to W3C English spelling conventions.

## Non-W3C Technical Corrections

- None identified.

## Patch-Ready Change Set

### CHG-001: Fix Missing Verb

- Target file: `fhir-repo/source/requirements/requirements-introduction.xml` (or source generating this section)
- Anchor: Scope and Usage
- Edit type: replace
- Current text (exact): `The Requirements Resource a set of statements that are requirements for some design artifact to meet.`
- Proposed text (exact): `The Requirements Resource is a set of statements that are requirements for some design artifact to meet.`
- Pre-context (exact): `<p><strong>This resource is a <em>definition</em>`
- Post-context (exact): `The requirements resource is intended to meet two principle use cases:`
- Occurrence rule: First and only occurrence in this section
- Rationale: Subject-verb agreement error violates W3C Section 11 grammar requirements. Sentence is missing the copula verb "is" between subject and predicate nominative.
- Validation check: After applying, read the sentence to confirm it flows grammatically and makes logical sense.

### CHG-002: Remove Repeated Word

- Target file: `fhir-repo/publish/requirements.html` (generated; source location would be in template or navigation generation)
- Anchor: Navigation breadcrumb
- Edit type: replace
- Current text (exact): `Directory of published versions for published versions`
- Proposed text (exact): `Directory of published versions`
- Pre-context (exact): `See the <a href="http://hl7.org/fhir/directory.html">`
- Post-context (exact): `<img src="external.png" alt="icon"`
- Occurrence rule: First and only occurrence in file
- Rationale: Violates W3C Section 11 requirement to "avoid repeated words." The phrase "published versions" appears twice consecutively, reducing clarity.
- Validation check: Verify link text is still meaningful and guides user appropriately.

## Apply Sequence

1. CHG-001 (Fix missing verb – highest priority, affects core prose)
2. CHG-002 (Remove repeated word – improves link clarity)

## Blocking Issues

- None
