# Implementation Change Log: FHIR-57408

## Summary
- Plan: jira/active/FHIR-57408/FHIR-57408-implementation-plan.md
- Ticket: jira/active/FHIR-57408/FHIR-57408.md
- Execution date: 2026-06-02

## Files Changed
- fhir-fork/source/datatypes/sampleddata.xml

## Changes Applied
1. Updated the `SampledData.interval` definition text to state that interval applies to samples after the final offset when offsets do not cover all samples.
2. Updated the `SampledData.offsets` definition text to describe fallback behavior when fewer offsets are provided than data points.
3. Replaced the strict offsets data-count rule with conditional behavior:
   - without interval: data points must equal offsets × dimensions
   - with interval: additional data points beyond offsets are allowed
4. Updated SampledData invariant prose and expressions to require interval and/or offsets (instead of XOR), including aligned FHIRPath and XPath expressions.

## Validation Performed
- Boundary validation (`check-changed-paths.sh`): PASS
- Plan/ticket intent alignment check (FHIR-57408 files under jira/active): PASS
- Source consistency check for new invariant and fallback wording in `sampleddata.xml`: PASS
- Stale wording check for prior XOR text in edited section: PASS
- Publish/build validation (`./gradlew publish`): PASS

## Notes
- Specification edits are limited to `fhir-fork/source/datatypes/sampleddata.xml`.
- Other modified files visible in `fhir-fork` are pre-existing and not part of FHIR-57408; they are intentionally excluded from this ticket commit.
