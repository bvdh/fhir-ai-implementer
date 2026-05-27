# Implementation Plan: FHIR-48872

## Scope Summary
- Workgroup/source: currentTickets.md batch planning run (unimplemented tickets only).
- Tickets in scope: FHIR-48872.
- Primary fix pattern: title normalization and curating work group verification/correction.

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-48872 | Title and curating work group of the Metadata Types page | Resolved - change required | Primary: `fhir-fork/source/metadatatypes.html`; Secondary: `fhir-fork/source/hierarchy.xml`; Optional consistency target: `fhir-fork/source/datatypes.html` | wording/typo correction | Primary title issue is in `<h1>MetaDatatypes</h1>` in `metadatatypes.html`; navigation title variant is `MetaData Types` in `hierarchy.xml`; curating WG row in `metadatatypes.html` uses `%wg/%wgt` tokenization and may already resolve to FHIR Infrastructure. |

## Shared Implementation Approach
1. Apply direct title correction in primary target first (`metadatatypes.html`).
2. Align navigation label in secondary target (`hierarchy.xml`) to avoid mixed variants.
3. Treat curating work group correction as already-applied when `%wg/%wgt` tokenized output already resolves to FHIR Infrastructure; do not force unrelated template rewrites.
4. Keep diffs minimal, scoped to the mapped files, and avoid unrelated formatting or tooling changes.

## Execution Steps
1. Primary target edit: in `fhir-fork/source/metadatatypes.html`, change `<h1>MetaDatatypes</h1>` to `<h1>Metadata Types</h1>`.
2. Secondary target edit: in `fhir-fork/source/hierarchy.xml`, change `title="MetaData Types"` to `title="Metadata Types"` for the `metadatatypes.html` page node.
3. Optional consistency edit (only if requested by reviewer during implementation): in `fhir-fork/source/datatypes.html`, update the category list item text `MetaDatatypes` to `Metadata Types` where it references `metadatatypes.html`.
4. Curating WG fallback decision:
	- Check for literal legacy text in mapped files (`MnM`, `Modeling and Methodology`, `Modelling and Methodology`).
	- If absent and `metadatatypes.html` continues to use `%wg/%wgt` tokens for owner display, record as already-applied and do not add a WG text edit.
5. Execute validation commands:
	- `rg -n "<h1>MetaDatatypes</h1>|<h1>Metadata Types</h1>" fhir-fork/source/metadatatypes.html`
	- `rg -n "<page title=\"MetaData Types\"|<page title=\"Metadata Types\"" fhir-fork/source/hierarchy.xml`
	- `rg -n "MnM|Modeling and Methodology|Modelling and Methodology" fhir-fork/source/metadatatypes.html fhir-fork/source/hierarchy.xml`
	- `rg -n "Responsible Owner|%wg fhir|%wgt fhir" fhir-fork/source/metadatatypes.html`

## Validation Checklist
- [ ] Primary target mapped and planned: `fhir-fork/source/metadatatypes.html`
- [ ] Secondary target mapped and planned: `fhir-fork/source/hierarchy.xml`
- [ ] Optional consistency target explicitly scoped: `fhir-fork/source/datatypes.html` (only if needed)
- [ ] Validation commands are executable and confirm title normalization
- [ ] Validation confirms absence of legacy WG literal in mapped files, or identifies exact file if present
- [ ] Planned edits stay within `fhir-fork/source/`
- [ ] No unrelated formatting/tooling/build changes
- [ ] Plan is review-ready and implementation-specific

## Risks and Assumptions
- Risk: Mixed legacy naming variants (`MetaDatatypes` vs `MetaData Types` vs `Metadata Types`) may exist beyond primary/secondary targets.
- Assumption: Curating WG correction is already handled by `%wg/%wgt` owner tokenization unless a literal MnM string is found in the mapped files.
- Open questions: If additional `MetaDatatypes` variants are found outside mapped files during implementation, should they be included under this ticket or tracked as follow-up editorial cleanup?
