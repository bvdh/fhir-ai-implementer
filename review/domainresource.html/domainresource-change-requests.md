# Non-Technical FHIR Review Report

## Metadata

- Review ID: domainresource-2026-08-13
- Date: 2026-08-13
- Mode: page
- Target input: `domainresource.html`
- Resolved output page: `fhir-repo/publish/domainresource.html`
- Status: ready

## Build Evidence

- Build check command: `./.github/skills/build-fhir/scripts/build-if-needed.sh --repo ./fhir-repo --mode check`
- Build check result: `BUILD_NEEDED: no`
- Notes: The review used the current published page. The page is normative, so Rule 1's informative-page restriction does not apply.

## Inputs Used

- Source files:
  - `fhir-repo/source/domainresource/domainresource-introduction.xml`
  - `fhir-repo/source/domainresource/domainresource-notes.xml`

- Output files:
  - `fhir-repo/publish/domainresource.html`
  - `fhir-repo/publish/domainresource-search.html`

## Rule 1 Findings: Normative Language on Informative Pages

- None. The page is marked normative from v4.0.0. Normative terms in the resource definition are therefore in scope for the normative page and do not violate this rule.

## Rule 2 Findings: Normative Language in note/summary/comment Fields

- None. No normative language was identified in resource element note, summary, or comment fields.

## Rule 3 Findings: Regulatory Expressions vs Description

- None. The contained-resource invariants, modifier-extension guidance, narrative guidance, and extension search-parameter guidance align with their corresponding descriptions.

## Rule 4 Findings: FHIRPath Expressions vs Description

- None. The `dom-2` through `dom-6` expressions and the extension search-parameter example align with the same-page descriptions.

## Rule 5 Findings: Contradictions on Page

- None. The claims in Scope and Usage, Resource Content, Constraints, Contained Resources, and Searching Extensions are internally consistent across the repeated Structure, UML, and All views.

## Rule 6 Findings: subject Field Requires patient and/or subject Search Parameter

- None. `DomainResource` has no `subject` element, so this rule is not triggered.
  - subject context: No `subject` element appears in the DomainResource element definitions.
  - search parameters observed: `_text`

## Cross-Rule Synthesis

- No non-technical findings were identified. The page's normative status makes Rule 1 inapplicable, and the remaining rule checks found no language, alignment, contradiction, or subject-search-parameter issue.

## Blocking Issues

- None
