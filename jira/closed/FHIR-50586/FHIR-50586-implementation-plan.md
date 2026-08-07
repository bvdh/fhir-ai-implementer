# Implementation Plan: FHIR-50586

## Scope Summary
- Workgroup/source: FHIR Infrastructure; ticket file jira/open/FHIR-50586/FHIR-50586.md
- Tickets in scope: FHIR-50586
- Primary fix pattern: Datatypes main-page rendering alignment (ensure RelativeTime constraints box appears, consistent with SampledData)
- Selected disposition: A (Accept As Requested)

## Eligibility Gate
- Resolution present and non-empty: `Persuasive` (PASS)
- Status is `Resolved - change required`: yes (PASS)

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-50586 | "constraints" box is missing for RelativeTime and SampledData | Resolved - change required | datatypes.html (`RelativeTime` section) | Rendering/template wiring correction | Resolution description says SampledData fixed; RelativeTime still broken |

## Likely Edit Surface (Files + Anchors)
- Primary edit target:
  - `fhir-fork/source/datatypes.html`
    - RelativeTime section header: around line 1773 (`<h2 ...>RelativeTime</h2>`)
    - Datatype rendering macro: around line 1783 (`[%dt RelativeTime 14%]`)
    - Missing constraints block insertion point: immediately after the datatype macro and before explanatory paragraphs
- Consistency reference (no edit expected):
  - `fhir-fork/source/datatypes.html`
    - SampledData constraints block: around line 1366 (`[%dt.constraints SampledData%]` inside `<div class="use">`)
- Evidence that RelativeTime constraints exist in source data (no edit expected):
  - `fhir-fork/source/datatypes/relativetime.xml`: around lines 3722 and 3731 (constraint text for `rlt-1`/`rlt-2` semantics)

## Shared Implementation Approach
1. Keep the change minimal and local to `fhir-fork/source/datatypes.html`.
2. Reuse the same constraints-box structure already used in SampledData.
3. Do not alter constraints definitions themselves; only make main-page rendering surface them.

## Detailed Execution Steps
1. Open `fhir-fork/source/datatypes.html` and locate the `RelativeTime` section anchor and heading.
2. Find the line containing `[%dt RelativeTime 14%]`.
3. Insert the constraints-box block directly below that line, mirroring existing style:
   - `<div class="use">`
   - `<p><b>Constraints</b></p>`
   - `[%dt.constraints RelativeTime%]`
   - `</div>`
4. Ensure placement is before narrative explanation paragraphs so rendering matches other datatype sections.
5. Confirm no additional wording changes or formatting churn in unrelated sections.
6. Run targeted checks:
   - Verify macro presence:
     - `rg -n "\[%dt\.constraints\s+RelativeTime%\]" fhir-fork/source/datatypes.html`
   - Verify both macros exist for parity:
     - `rg -n "\[%dt\.constraints\s+(SampledData|RelativeTime)%\]" fhir-fork/source/datatypes.html`
7. Optional build validation (if executing implementation in this session):
   - Run the standard local build command used for spec validation in `fhir-fork` and confirm the generated datatypes page shows a constraints box for RelativeTime.
8. Capture implementation evidence in ticket artifacts after code edit is complete (outside this planning step).

## Validation Checklist
- [ ] Ticket eligibility confirmed (`Resolution` present; `Status` = `Resolved - change required`)
- [ ] Planned edit is mapped to at least one concrete file and anchor
- [ ] Planned edit scope remains within `fhir-fork/source/`
- [ ] RelativeTime section includes a constraints-box macro after implementation
- [ ] SampledData behavior remains unchanged
- [ ] No unrelated formatting/tooling/build-script changes
- [ ] Plan is specific enough to execute without reinterpretation

## Risks and Assumptions
- Risk: Constraints data might not be available to the macro pipeline in some build contexts; insertion alone may render an empty box if upstream extraction is broken.
- Risk: Section order/styling could diverge if insertion point differs from established datatype conventions.
- Assumption: `[%dt.constraints RelativeTime%]` is supported by the same rendering pipeline as `[%dt.constraints SampledData%]`.
- Assumption: Existing RelativeTime constraints in `relativetime.xml` are authoritative and do not require semantic edits.
- Open question: Whether a regression test can be added in the datatype rendering pipeline to prevent future missing constraints-box regressions.

## Expected Outcome
After implementation, the main Datatypes page will display the `Constraints` box for `RelativeTime` (including `rlt-1` and `rlt-2`) consistently with `SampledData`, matching Disposition A and ticket intent.
