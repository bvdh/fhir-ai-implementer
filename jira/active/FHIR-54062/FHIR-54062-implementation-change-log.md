# Implementation Change Log: FHIR-54062

## Summary
- Plan: jira/active/FHIR-54062/FHIR-54062-implementation-plan.md
- Ticket: jira/active/FHIR-54062/FHIR-54062.md
- Execution date: 2026-06-02

## Files Changed
- fhir-fork/source/datatypes/timing.xml

## Changes Applied
1. Updated tim-11 invariant text and FHIRPath expression to require `period` in addition to `frequency > 1` when `startOffset` is present.
2. Updated tim-12 invariant text and FHIRPath expression to require `period` in addition to `frequency > 1` when `endOffset` is present.
3. Updated `Timing.repeat.startOffset` and `Timing.repeat.endOffset` definitions to explicitly state that both `frequency` and `period` are required to define the repeat cycle.

## Validation Performed
- Stale invariant text search in `fhir-fork/source/datatypes/timing.xml` (old frequency-only expressions): PASS
- Localized source review around edited Timing element and invariant rows: PASS
- Scoped diff review (`git diff -- source/datatypes/timing.xml`): PASS
- `./gradlew publish` from `fhir-fork`: INTERRUPTED (manual cancel after long-running publish; no completion status captured)

## Notes
- Source edits are limited to `fhir-fork/source/datatypes/timing.xml` and align to ticket intent that period and frequency both matter for offset semantics.
- Timing narrative/example pages were reviewed for alignment; no additional wording edits were required for this minimal constraint-focused implementation.
- Other modified files visible in `fhir-fork` are pre-existing and not part of FHIR-54062.
