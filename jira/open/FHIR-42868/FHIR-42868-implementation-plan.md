# Implementation Plan: FHIR-42868

## Scope Summary
- Workgroup/source: FHIR Infrastructure; ticket file jira/active/FHIR-42868/FHIR-42868.md
- Tickets in scope: FHIR-42868
- Primary fix pattern: Standards-status correction for a required-bound value set used by a normative artifact

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-42868 | Narrative-status should be normative | Resolved - change required | narrative status value set/binding source (Narrative datatype source artifacts) | Metadata/status correction | Narrative is normative; required binding target ValueSet narrative-status must carry normative status consistently |

## Likely Edit Surface
- fhir-fork/source/datatypes/narrative.xml:5629 (binding name NarrativeStatus)
- fhir-fork/source/datatypes/narrative.xml:5633 (binding target #narrative-status)
- fhir-fork/source/datatypes/narrative.xml:6090 (worksheet narrative-status starts)
- fhir-fork/source/datatypes/narrative.xml:6114 (code row generated)
- fhir-fork/source/datatypes/narrative.xml:6125 (code row extensions)
- fhir-fork/source/datatypes/narrative.xml:6136 (code row additional)
- fhir-fork/source/datatypes/narrative.xml:6147 (code row empty)
- fhir-fork/source/bindings.ini:57 (NarrativeStatus binding index reference, for consistency verification only)

## Shared Implementation Approach
1. Treat the Narrative datatype source spreadsheet (narrative.xml) as the authoritative source for the narrative-status code list and metadata.
2. Update only the metadata fields needed to reflect normative status for narrative-status, preserving existing code semantics.
3. Keep edits minimal and scoped to ticket intent; avoid changing unrelated value set/binding definitions.

## Execution Steps
1. Baseline confirmation
- Confirm ticket intent from jira/active/FHIR-42868/FHIR-42868.md and current narrative-status source rows in datatypes/narrative.xml.
- Identify where standards-status metadata for the #narrative-status code list/value set is carried in the worksheet structure.

2. Apply standards-status correction
- Update the narrative-status source metadata in datatypes/narrative.xml so generated narrative-status value set content reflects normative status aligned with normative Narrative.
- Do not alter narrative-status codes (generated/extensions/additional/empty) unless required by ticket intent.

3. Cross-reference consistency checks
- Verify the NarrativeStatus binding row still points to #narrative-status and remains required.
- Verify binding index linkage in source/bindings.ini remains coherent (NarrativeStatus = 50) unless the metadata location requires coordinated update.

4. Scope control
- Ensure implementation edits are only in fhir-fork/source/ files directly related to this ticket.
- Exclude tooling/script/build changes.

## Validation Checklist
- [ ] FHIR-42868 mapped to concrete source files and line-level targets
- [ ] Planned edits are limited to fhir-fork/source/
- [ ] NarrativeStatus binding remains required and still references #narrative-status
- [ ] Narrative-status standards metadata is updated to normative in authoritative source
- [ ] No code-level semantic changes to narrative-status concepts
- [ ] Diff is minimal and traceable to ticket intent

## Risks and Assumptions
- Risk: Standards-status metadata location in spreadsheet XML may be non-obvious and easy to over-edit.
- Risk: Status propagation may involve generator expectations beyond a single row; incorrect placement could be ignored.
- Assumption: datatypes/narrative.xml is the authoritative source for the narrative-status value set content/metadata used in publication.
- Assumption: No additional terminology artifact needs direct manual edits if metadata is correctly updated at source.
- Open questions: If no explicit normative-status field exists in the narrative-status worksheet row, confirm whether a coordinated update is required in another source metadata table before implementation.
