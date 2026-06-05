# Implementation Plan: FHIR-54490

## Scope Summary
- Workgroup/source: Direct ticket scope (FHIR-54490)
- Tickets in scope: FHIR-54490
- Primary fix pattern: Clarification wording update for Attachment.url relative-reference interpretation

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-54490 | Attachment url to relative references should be clarified | Resolved - change required | datatypes (Attachment, section 2.1.30.0.3) | Normative clarification wording | Primary source edit surface is the Attachment.url definition row in fhir-fork/source/datatypes/attachment.xml around lines 926-945 (contains current sentence about relative URLs being interpreted like resource references). Secondary verification surface is rendered text in fhir-fork/source/datatypes.html around lines 589-594. |

## Shared Implementation Approach
1. Locate Attachment.url narrative in source spreadsheet XML under fhir-fork/source/datatypes/.
2. Clarify relative-reference structure semantics with minimal wording change aligned to existing reference rules.
3. Keep changes minimal, traceable, and constrained to source content in fhir-fork/source/.

## Execution Steps
1. Confirm ticket intent from jira/active/FHIR-54490/FHIR-54490.md:
   - Clarify what forms are valid for relative Attachment.url references.
   - Clarify interpretation base (FHIR service base URL) and relation to resource-reference rules.
2. Edit canonical source text in fhir-fork/source/datatypes/attachment.xml:
   - Locate Attachment.url row around lines 926-945.
   - Update the definition/comment sentence beginning with "Relative URLs are interpreted..." so examples/wording make expected relative form explicit.
3. Keep existing normative constraints intact:
   - Preserve "If a URL is provided, it SHALL resolve to actual data".
   - Preserve compatibility with cid: and bundle-local URI notes unless ticket intent requires narrowing.
4. Cross-check consistency with existing reference guidance:
   - fhir-fork/source/references.html around lines 163-170 (relative example Patient/034AB16).
   - fhir-fork/source/datatypes/reference.xml around line 862 (relative references are relative to service base URL).
5. Regenerate/render validation target only as needed:
   - Verify resulting wording in fhir-fork/source/datatypes.html around lines 589-594 reflects the intended clarification.
6. Perform scope-control review:
   - Ensure only intended files in fhir-fork/source are changed.
   - Avoid unrelated formatting or terminology drift.

## Validation Checklist
- [ ] Ticket is mapped to at least one concrete source edit location in fhir-fork/source.
- [ ] Planned implementation edits remain within fhir-fork/source only.
- [ ] Attachment.url clarification explicitly addresses relative-reference interpretation base.
- [ ] Updated wording remains aligned with references.html/reference datatype semantics.
- [ ] Existing SHALL constraints for URL/data behavior are preserved unless explicitly changed by ticket intent.
- [ ] Rendered Attachment section text is verified in datatypes.html after source update.
- [ ] No unrelated formatting/tooling/specification changes are introduced.

## Risks and Assumptions
- Risk: Over-clarification could accidentally narrow allowable URI forms beyond current FHIR intent.
- Risk: Editing rendered HTML instead of canonical source could cause non-persistent or inconsistent outcomes.
- Assumption: fhir-fork/source/datatypes/attachment.xml is the canonical source for Attachment.url descriptive text.
- Assumption: Clarification is expected as wording guidance, not a datatype regex or structural constraint change.
- Open questions: Should the clarification include one concrete inline example format (for example ResourceType/id) directly in Attachment narrative, or only reference resource-reference rules?
