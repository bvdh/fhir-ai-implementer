# Implementation Plan: FHIR-54022

## Scope Summary
- Workgroup/source: Direct ticket input from jira/active/FHIR-54022/FHIR-54022.md
- Tickets in scope: FHIR-54022
- Primary fix pattern: Terminology standardization (editorial technical correction)
- Ticket status: Waiting for Input (Unresolved)

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-54022 | Standardize spelling of "payer" - FHIRI | Waiting for Input | fhir-fork/source/financial-module.html; fhir-fork/source/coverage/structuredefinition-Coverage.xml; fhir-fork/source/enrollmentrequest/structuredefinition-EnrollmentRequest.xml; fhir-fork/source/coverageeligibilityrequest/structuredefinition-CoverageEligibilityRequest.xml; fhir-fork/source/paymentnotice/paymentnotice-introduction.xml; fhir-fork/source/paymentreconciliation/paymentreconciliation-introduction.xml; fhir-fork/source/coverageeligibilityresponse/coverageeligibilityresponse-introduction.xml; fhir-fork/source/processresponse/processresponse-example-error.xml | Wording standardization | Replace narrative/definition uses of "payor" with "payer" while preserving model element names, ids, and machine-facing tokens where applicable |

## Shared Implementation Approach
1. Locate all occurrences of the word "payor" under fhir-fork/source/.
2. Classify each occurrence before editing:
   - Edit: human-readable narrative text, definition prose, and example display text.
   - Do not edit: element/tag names, ids, reference fragments, invariant keys, code/system values, or other machine-facing identifiers.
3. Apply minimal editorial replacements from "payor" to "payer" in scoped text-only locations.
4. Keep changes strictly within fhir-fork/source/.

## Execution Steps
1. Confirm ticket details in jira/active/FHIR-54022/FHIR-54022.md.
2. Generate candidate list:
   - Run targeted search for whole-word "payor" under fhir-fork/source/.
   - Exclude generated diagram payloads from primary edit pass (for example, *.gen.svg and large generated single-line assets) unless directly maintained in source workflow.
3. Perform file-by-file classification pass on candidate files, prioritizing known likely surfaces:
   - financial narrative pages: paymentnotice/paymentnotice-introduction.xml, paymentreconciliation/paymentreconciliation-introduction.xml, coverageeligibilityresponse/coverageeligibilityresponse-introduction.xml, financial-module.html
   - definitional prose: coverage/structuredefinition-Coverage.xml, enrollmentrequest/structuredefinition-EnrollmentRequest.xml, coverageeligibilityrequest/structuredefinition-CoverageEligibilityRequest.xml
   - example human text: processresponse/processresponse-example-error.xml
4. Apply edits only where "payor" appears in human-readable narrative/definition text.
5. Skip occurrences that are likely structural identifiers, including patterns such as:
   - XML/JSON element names like <payor>...</payor>
   - local references like #payor
   - ids or anchors named payor
6. Run post-edit verification:
   - Re-run whole-word "payor" search and review residual matches.
   - Confirm residual matches are intentional machine-facing identifiers or out-of-scope generated artifacts.
7. Review diff for minimality and consistency (no unrelated formatting or tooling changes).
8. Prepare commit after approval with ticket key in the title.

## Validation Checklist
- [ ] Ticket FHIR-54022 is mapped to concrete candidate source files
- [ ] Planned edits stay within fhir-fork/source/
- [ ] All edited occurrences are human-readable narrative/definition text
- [ ] Element/tag names, ids, references, and machine-facing tokens are unchanged
- [ ] Residual "payor" matches are reviewed and documented as intentional
- [ ] No unrelated formatting/tooling changes are introduced
- [ ] Plan is review-ready and aligned to ticket intent

## Risks and Assumptions
- Risk: Some occurrences of "payor" are part of formal model artifacts (element names/ids) and changing them could break compatibility.
- Risk: Generated diagram/content files may contain copied narrative text; editing generated artifacts without source-of-truth confirmation can create churn.
- Assumption: Ticket intent is editorial terminology harmonization in human-readable FHIRI financial text, not resource model renaming.
- Open questions: Should generated diagram assets be regenerated from source as part of this ticket, or left unchanged unless the publication pipeline handles regeneration automatically?

## Acceptance Criteria
- Human-readable occurrences targeted by this ticket use "payer" consistently in the scoped financial specification content.
- No model element names or machine-facing identifiers are renamed.
- All implementation edits remain under fhir-fork/source/ and are minimal, traceable, and ticket-focused.
