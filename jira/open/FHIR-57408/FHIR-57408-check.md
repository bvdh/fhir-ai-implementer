# Check: FHIR-57408

## Verdict
- Status: ALIGNED

## Assessment
- Resolution requires removing the strict offsets-running-out behavior, defining interval fallback, and handling no-interval mismatch as error.
- Plan/changelog align by replacing strict rule with conditional behavior and updated interval/offset semantics.

## Evidence
- Change log records interval fallback semantics and conditional rule behavior (with and without interval).

## Attention
- None.
