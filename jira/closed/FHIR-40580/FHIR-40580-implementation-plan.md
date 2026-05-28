# Implementation Plan: FHIR-40580

## Scope Summary
- Ticket: FHIR-40580
- Summary: Typo: HealthcareService is misspelled as HealthCareService
- Status: Resolved - change required
- Resolution: Persuasive
- Planning scope: confirm and correct `HealthCareService` to `HealthcareService` for the Request pattern `deliverTo` type list.
- Implementation boundary: limit edits to `fhir-fork/source/` only.

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-40580 | Typo: HealthcareService is misspelled as HealthCareService | Resolved - change required | Primary: `fhir-fork/source/request/request-spreadsheet.xml` | Typographical correction | `Request.deliverTo` type list should use `HealthcareService` (not `HealthCareService`). |

## Concrete Target File Mapping
- Primary edit/verification target:
  - `fhir-fork/source/request/request-spreadsheet.xml`
  - Reason: canonical request pattern spreadsheet source contains `Request.deliverTo` row and reference type list.
- Secondary verification target:
  - `fhir-fork/source/` scoped search
  - Reason: ensure no remaining `HealthCareService` typo survives in source content.

## Shared Implementation Approach
1. Locate the `Request.deliverTo` row in `request-spreadsheet.xml`.
2. Confirm whether any `HealthCareService` token exists in the relevant type list.
3. If present, replace only `HealthCareService` -> `HealthcareService`.
4. If absent, record verification-only/no-op execution during implementation.

## Execution Steps
1. Open `fhir-fork/source/request/request-spreadsheet.xml`.
2. Locate row with `Request.deliverTo` and corresponding type expression.
3. If `HealthCareService` is present, update it to `HealthcareService`.
4. Run a scoped search across `fhir-fork/source/` for `HealthCareService`.
5. Confirm no unrelated wording changes are introduced.

## Validation Checklist
- [ ] Target row `Request.deliverTo` reviewed in `fhir-fork/source/request/request-spreadsheet.xml`.
- [ ] Any `HealthCareService` typo corrected to `HealthcareService`.
- [ ] Search check: `rg -n "HealthCareService" fhir-fork/source` returns no unintended remaining typo occurrences relevant to this ticket.
- [ ] Diff is limited to typo correction scope only.
- [ ] No files outside `fhir-fork/source/` are edited for source implementation.

## Risks and Assumptions
- Risk: typo may already be fixed upstream; execution may be verification-only.
- Assumption: `request-spreadsheet.xml` remains authoritative source for this pattern content wording.
- Open question: if token is already corrected everywhere, mark ticket as already-applied/no-op at execution time.
