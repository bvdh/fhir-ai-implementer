# Non-Technical Review: bindings-list.html

## Metadata
- **Target input:** bindings-list.html
- **Resolved output page:** fhir-repo/publish/bindings-list.html
- **Source context:** fhir-repo/source/
- **Review date:** 2026-08-14
- **Build evidence:** BUILD_NEEDED: no (verified current)

## Input Files
- Output: fhir-repo/publish/bindings-list.html
- Source: fhir-repo/source/bindings-list.html

## Rule 1: Normative Language in Informative Pages
No findings for Rule 1.

## Rule 2: Normative Language in Resource Fields
No findings for Rule 2.

## Rule 3: Regulatory Alignment
- **Finding ID:** rule3-001
- **Rule ID:** Rule 3
- **Severity:** error
- **Confidence:** high
- **Location:** fhir-repo/publish/bindings-list.html#L4416-L4425, `ImplementationGuide.license`
- **Evidence snippet:** Regulatory expression: `Strength: required`  
  Corresponding description: "The license that applies to an Implementation Guide (using an SPDX license Identifiers, or 'not-open-source'). **The binding is required but new SPDX license Identifiers are allowed**."
- **Rationale:** A `required` binding indicates that the coded value must come from the bound value set. The description simultaneously states that new SPDX license identifiers are allowed, which permits values outside the required binding and therefore contradicts the regulatory expression.
- **Suggested rewrite:** Either change the strength to `extensible` if new SPDX license identifiers are intentionally permitted, or revise the description to: "The license that applies to an Implementation Guide. The value must be an SPDX license identifier or `not-open-source`."

## Rule 4: FHIRPath Alignment
No findings for Rule 4.

## Rule 5: Contradictions
- **Finding ID:** rule5-001
- **Rule ID:** Rule 5
- **Severity:** error
- **Confidence:** high
- **Location:** fhir-repo/publish/bindings-list.html - Bindings List, `ImplementationGuide.license` row
- **Evidence snippet:** "Strength: `required`" and "The binding is required but new SPDX license Identifiers are allowed to be used"
- **Rationale:** A required binding constrains values to the referenced value set, while the description explicitly permits new SPDX identifiers outside the listed value set. These are contradictory requirements for the same element.
- **Suggested rewrite:** Either change the strength to `extensible`, or revise the description to state that only identifiers in the SPDX License value set are permitted.

## Rule 6: Subject Search Parameter Coverage
No findings for Rule 6.

- **Detected subject element context:** None. `bindings-list.html` is an informative bindings index, not a resource page.
- **Observed search-parameter inventory:** None applicable.

## Cross-Rule Synthesis
Rules 3 and 5 both identify the same issue: `ImplementationGuide.license` has a `required` binding strength that contradicts its description allowing new SPDX identifiers. This is a single underlying error manifesting in both regulatory alignment (Rule 3) and internal contradiction (Rule 5) checks.

## Blocking Issues
- **rule3-001 / rule5-001:** The `ImplementationGuide.license` binding strength and description contradict each other. Resolution required: align binding strength with intended extensibility policy.

## Summary
- Total findings: 2 (1 unique issue reported by both Rule 3 and Rule 5)
- Severity breakdown: 2 errors
- Blocking issues: 1
