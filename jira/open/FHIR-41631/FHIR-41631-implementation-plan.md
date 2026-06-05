# Implementation Plan: FHIR-41631

## Scope Summary
- Workgroup/source: FHIR Infrastructure / Jira ticket FHIR-41631
- Tickets in scope: FHIR-41631
- Primary fix pattern: Curating work group reference correction from obsolete MnM ownership to FHIR Infrastructure on datatype-related pages

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-41631 | Modeling and Methodology is incorrectly stated as the curating work group for the datatypes page | Resolved - change required | datatypes*.html and metadatatypes*.html pages listed in ticket comments | Wording/owner metadata correction | Ensure responsible work group display resolves to FHIR Infrastructure consistently |

## Shared Implementation Approach
1. Locate all in-scope datatype and metadatatype pages under `fhir-fork/source/`.
2. Identify work-group ownership markers (for example `[%wg ...%]`, `[%wgt ...%]`, explicit links/text, or generated owner rows).
3. Apply minimal owner-token/text updates so pages render with FHIR Infrastructure as the curating work group.

## Execution Steps
1. Inspect the following files in `fhir-fork/source/` (from ticket discussion) and identify current owner markers:
   - `datatypes.html`
   - `datatypes-definitions.html`
   - `datatypes-examples.html`
   - `datatypes-mappings.html`
   - `datatypes-profiles.html`
   - `metadatatypes.html`
   - `metadatatypes-definitions.html`
   - `metadatatypes-examples.html`
   - `metadatatypes-mappings.html`
   - `metadatatypes-profiles.html`
2. Determine the smallest consistent edit strategy for owner fields:
   - Prefer token-level correction where page headers are generated from owner tokens.
   - If explicit hard-coded owner text exists, update only those lines.
3. Apply updates so each in-scope page shows FHIR Infrastructure as responsible/curating work group.
4. Review neighboring sections to ensure no unrelated wording or formatting changes are introduced.
5. Perform targeted search checks for legacy MnM ownership references in the in-scope files.
6. Optionally run a local publish/validation pass if available; otherwise rely on focused content + diff validation.

## Validation Checklist
- [ ] Ticket FHIR-41631 maps to at least one file/page in `fhir-fork/source/`
- [ ] Planned edits stay within `fhir-fork/source/`
- [ ] No unrelated formatting/tooling/config changes are included
- [ ] All listed datatype and metadatatype pages show FHIR Infrastructure as owner after edits
- [ ] In-scope files no longer contain obsolete MnM curating work group references
- [ ] Diff remains minimal and directly aligned with ticket intent

## Risks and Assumptions
- Risk: Some pages may derive owner text from shared generation templates, requiring an upstream token/template update rather than per-page edits.
- Assumption: The ticket comment’s file list is complete for datatype-related pages requiring owner correction.
- Open questions:
  - Is there a single canonical owner token change point that should be updated instead of direct page edits?
  - Should any historical mentions of MnM remain in narrative context (non-owner metadata), or should only owner headers change?
