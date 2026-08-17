# Technical Corrections Review: biologically-derived-product-module.html

## Metadata
- **Target input:** biologically-derived-product-module.html
- **Resolved output page:** fhir-repo/publish/biologically-derived-product-module.html
- **Source context:** fhir-repo/source/
- **Review date:** 2026-08-14
- **Build evidence:** BUILD_NEEDED: no (verified current)

## Input Files
- Output: fhir-repo/publish/biologically-derived-product-module.html
- Source: fhir-repo/source/biologically-derived-product-module.html

## W3C Style Deviations (Sections 7.2, 7.3, 11, 13)
### Section 11: Grammar and Article Issues
Total violations: 7

**CHG-001:** Line 37, Introduction
- **Current:** `In most countries BDP are regulated`
- **Proposed:** `In most countries BDPs are regulated`
- **Rationale:** Corrects plural subject agreement
- **Context:** `Examples of non-human derived products include: porcine dermis and porcine heart valves.` → `separately from medicines and medical devices`

**CHG-002:** Line 40, Introduction
- **Current:** `Some BDP are regulated`
- **Proposed:** `Some BDPs are regulated`
- **Rationale:** Corrects plural subject agreement
- **Context:** `traceability records for very long periods (e.g., 30 years from time of use for tissues and cells clinically applied in the EU).` → `as medical devices in some jurisdictions`

**CHG-003:** Line 43, Introduction
- **Current:** `For BDP derived from a human donor`
- **Proposed:** `For a BDP derived from a human donor`
- **Rationale:** Adds required article for singular resource
- **Context:** `as Tissues and Cells in the EU.` → `(an MPHO) bi-directional traceability is essential.`

**CHG-004:** Line 273, Common Use Cases
- **Current:** `BDP provider/manufacturer creates`
- **Proposed:** `The BDP provider/manufacturer creates`
- **Rationale:** Adds missing article before singular role noun
- **Context:** `critical information that varies by BDP type.` → `a BiologicallyDerivedProduct resource`

**CHG-005:** Line 312, Common Use Cases
- **Current:** `Product is requested from`
- **Proposed:** `A product is requested from`
- **Rationale:** Adds missing article before singular count noun
- **Context:** `The clinician responsible for the patient requests application of a biologically derived product.` → `the appropriate BDP Custodian using a ServiceRequest resource.`

**CHG-006:** Line 351, Common Use Cases
- **Current:** `BDP Custodian initiates a search of all BiologicallyDerivedProductDispense resources`
- **Proposed:** `The BDP Custodian initiates a search of all BiologicallyDerivedProductDispense resources`
- **Rationale:** Adds missing article before singular role noun

**CHG-007:** Line 360, Common Use Cases
- **Current:** `BDP Custodian initiates a search of inventory`
- **Proposed:** `The BDP Custodian initiates a search of inventory`
- **Rationale:** Adds missing article before singular role noun

## Link Target Validation
No issues. All local links resolve in `fhir-repo/publish/`. External OO incubator links verified (HTTP 200).

## Link Description Alignment
No issues. Link text corresponds to linked artifact names.

## Spelling Findings
No spelling issues found.

## Other Technical Corrections
None.

## Summary
- Total technical corrections: 7
- W3C style: 7 (all Section 11 grammar/article issues)
- Link issues: 0
- Spelling: 0
- Other: 0
