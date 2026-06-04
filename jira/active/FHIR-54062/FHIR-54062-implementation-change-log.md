# Implementation Change Log: FHIR-54062

## Summary
- Plan: jira/active/FHIR-54062/FHIR-54062-implementation-plan.md
- Ticket: jira/active/FHIR-54062/FHIR-54062.md
- Execution date: 2026-06-04

## Files Changed
- fhir-fork/source/datatypes.html
- fhir-fork/source/datatypes/timing.xml

## Changes Applied
1. Updated Timing narrative in fhir-fork/source/datatypes.html to clarify that startOffset/endOffset use requires both frequency > 1 and period.
2. Added a named notes section, "Periods with start or end offsets", with effective-period guidance and a concrete 28-day/7-day-off example.
3. Updated Timing.repeat.startOffset and Timing.repeat.endOffset definitions in fhir-fork/source/datatypes/timing.xml to point to the new notes section.
4. Retained and validated existing ticket-aligned invariant and short-text updates present in fhir-fork/source/datatypes/timing.xml (period-required tim-11/tim-12 logic and "stop once" wording).

## Validation Performed
- Notes-section and cross-reference search in fhir-fork/source/datatypes.html and fhir-fork/source/datatypes/timing.xml: PASS
- Localized source review around edited Timing narrative and Timing.repeat start/end rows: PASS
- Scoped diff review in fhir-fork for source/datatypes.html and source/datatypes/timing.xml: PASS
- ./gradlew publish from fhir-fork: PASS (EXIT_CODE=0, BUILD SUCCESSFUL in 8m 51s; 0 Errors / 17 Warnings / 386 Hints)

## Notes
- Source edits in this execution are limited to fhir-fork/source/ and tied to FHIR-54062 resolution text.
- Existing in-progress changes in the ticket plan file are outside specification source execution scope.

## Proposed Instruction Update
Pattern observed: Resolution-driven wording changes for datatypes often require synchronized edits in both element-level definitions (timing.xml) and narrative notes (datatypes.html) to avoid contradictory guidance.

Suggested addition to .github/instructions/fhir-fork.instructions.md:
- When a ticket introduces or revises usage semantics for a datatype element, update both the element definition rows in source/datatypes/*.xml and the corresponding narrative section in source/datatypes.html in the same ticket change set.
- If the ticket specifies a named notes section, add or update that section title verbatim and ensure element comments/definitions explicitly point to it.
- During validation, require a targeted search proving the named notes section exists and is referenced from each changed element definition.
