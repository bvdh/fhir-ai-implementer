# Non-Technical FHIR Review Report

## Metadata

- Review ID: requirements-2026-08-14
- Date: 2026-08-14
- Mode: page
- Target input: `requirements.html`
- Resolved output page: `fhir-repo/publish/requirements.html`
- Status: ready

## Build Evidence

- Build check command: `./.github/skills/build-fhir/scripts/build-if-needed.sh --repo ./fhir-repo --mode check`
- Build check result: `BUILD_NEEDED: no`
- Notes: The review used the current published page. The page is normative.

## Inputs Used

- Source files:
  - `fhir-repo/source/requirement.xml`
  - `fhir-repo/source/requirements/requirements-introduction.xml`
  - `fhir-repo/source/requirements/requirements-notes.xml`

- Output files:
  - `fhir-repo/publish/requirements.html`
  - `fhir-repo/publish/requirements-search.html`

## Rule 1 Findings: Normative Language on Informative Pages

- None. The page is marked normative. This rule is inapplicable to normative pages.

## Rule 2 Findings: Normative Language in note/summary/comment Fields

- **Finding R2-001**
  - Rule ID: rule2
  - Severity: error
  - Confidence: high
  - Location: Requirements.url (element description field)
  - Evidence snippet: "This SHOULD be globally unique and SHOULD be a literal address at which an authoritative instance of this Requirements is (or will be) published"
  - Rationale: SHOULD is normative language and appears in a resource element description, which should be non-normative in element field documentation.
  - Suggested rewrite: "This is typically globally unique and typically a literal address at which an authoritative instance of this Requirements is (or will be) published"

- **Finding R2-002**
  - Rule ID: rule2
  - Severity: error
  - Confidence: high
  - Location: Requirements.date (element description field)
  - Evidence snippet: "The date must change when the business version changes and it must change if the status code changes"
  - Rationale: "must" is normative language in a resource element description field.
  - Suggested rewrite: "The date should be updated when the business version changes and when the status code changes"

- **Finding R2-003**
  - Rule ID: rule2
  - Severity: error
  - Confidence: high
  - Location: modifierExtension (inherited base element description)
  - Evidence snippet: "Modifier extensions SHALL NOT change the meaning of any elements on Resource or DomainResource"
  - Rationale: SHALL NOT is normative language in element description.
  - Suggested rewrite: "Modifier extensions do not change the meaning of any elements on Resource or DomainResource"

- **Finding R2-004**
  - Rule ID: rule2
  - Severity: warning
  - Confidence: medium
  - Location: Requirements.statement.actor (constraint description)
  - Evidence snippet: "Statement Actors must match a defined actor"
  - Rationale: "must" appears in rule constraint, which functions as normative guidance.
  - Suggested rewrite: "Statement Actors match defined actors" or move to formal invariant

## Rule 3 Findings: Regulatory Expressions vs Description

- None. All regulatory expressions (SHOULD, SHALL, SHALL NOT) align properly with their corresponding same-page descriptions.

## Rule 4 Findings: FHIRPath Expressions vs Description

- None. All four FHIRPath expressions (cnl-0, cnl-1, req-1, req-2) align correctly with their descriptive text.

## Rule 5 Findings: Contradictions on Page

- **Finding REQ-5-001**
  - Rule ID: rule5
  - Severity: error
  - Confidence: high
  - Location: Scope and Usage vs Boundaries and Relationships sections
  - Evidence snippet 1 (Scope and Usage): "in most cases, it is expected that the specifications and designs that meet the requirements will provide traceability to the requirement"
  - Evidence snippet 2 (Boundaries and Relationships): "If requirements are satisfied by an existing specification, they SHOULD reference a FHIR resource"
  - Rationale: These claims describe contradictory directions of referencing. Claim 1 says specs/designs typically reference requirements (designs→requirements), while Claim 2 says requirements should reference specs (requirements→specs). These cannot both be true for "most cases" without clarification.
  - Suggested rewrite: "Requirements can directly identify features of specifications that satisfy them via satisfiedBy references. However, in most cases, the specifications and designs that meet requirements will also provide complementary traceability back to the requirements, creating mutual reference patterns."

## Rule 6 Findings: subject Field Requires patient and/or subject Search Parameter

- None. The Requirements resource has no `subject` element, so this rule is not triggered.
  - subject context: No `subject` element appears in the Requirements element definitions.
  - search parameters observed: Requirements-actor, CanonicalResource-context, CanonicalResource-date, Requirements-derived-from, CanonicalResource-description, Requirements-experimental, CanonicalResource-identifier, CanonicalResource-jurisdiction, CanonicalResource-name, CanonicalResource-publisher, CanonicalResource-status, CanonicalResource-title, CanonicalResource-url, CanonicalResource-version (no patient or subject parameters)

## Cross-Rule Synthesis

- Four Rule 2 violations identified in element descriptions and constraints using normative language (SHOULD, SHALL NOT, must).
- One Rule 5 contradiction identified between two sections describing the direction of Requirements-to-Specification references.
- Rules 1, 3, 4, and 6 produced no findings. The page's normative status makes Rule 1 inapplicable, and remaining checks found no alignment or subject-parameter issues.

## Blocking Issues

- None
