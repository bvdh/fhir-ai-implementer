# Implementation Plan: FHIR-48738

## Scope Summary
- Workgroup/source: SDC-CORE ticket metadata from jira/active/FHIR-48738/FHIR-48738.md
- Tickets in scope: FHIR-48738
- Primary fix pattern: Replace expired external reference URL in Questionnaire notes with current NSW Blue Book page

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-48738 | Link to external document has an expired link | Resolved - change required | questionnaire-notes (Questionnaire notes) | External link update | Existing URL points to an old PDF endpoint that appears expired |

## Shared Implementation Approach
1. Locate and confirm the exact stale link occurrence under fhir-fork/source/.
2. Replace only the href value while preserving surrounding prose and link label text unless needed for correctness.
3. Keep the edit minimal and traceable to FHIR-48738 intent.

## Execution Steps
1. Open fhir-fork/source/questionnaire/questionnaire-notes.xml and navigate to the Questionnaire structure section where the blue book example is referenced.
2. Confirm current link target is the old URL:
   - http://www.health.nsw.gov.au/Kids/Publications/my-personal-health-record.pdf
3. Update only the href target for "Australian New South Wales blue book" to the ticket-proposed replacement URL:
   - https://www.health.nsw.gov.au/kidsfamilies/MCFhealth/Pages/child-blue-book.aspx
4. Keep anchor text "Australian New South Wales blue book" unchanged unless a style/conformance review indicates otherwise.
5. Perform a local consistency check to ensure no additional stale copies of the same URL remain in fhir-fork/source/.
6. Review resulting diff to verify no unrelated formatting or content changes were introduced.

## Validation Checklist
- [ ] FHIR-48738 mapped to at least one concrete file/page
- [ ] Planned edit is confined to fhir-fork/source/
- [ ] Link target updated from old PDF URL to current NSW page URL
- [ ] Anchor text and surrounding narrative remain semantically unchanged
- [ ] No unrelated formatting/tooling or generated-output edits
- [ ] Search confirms no remaining instances of the old NSW PDF URL in fhir-fork/source/
- [ ] Result is review-ready and directly tied to ticket intent

## Risks and Assumptions
- Risk: External URL may change again or redirect behavior may vary over time.
- Risk: Destination page may require periodic maintenance if NSW site structure changes.
- Assumption: Ticket-proposed URL is the accepted canonical replacement for this reference.
- Assumption: Only one source occurrence requires update.
- Open questions: None identified for planning; if governance prefers a more stable source, consider replacing with a persistent identifier or alternate authoritative endpoint during implementation review.
