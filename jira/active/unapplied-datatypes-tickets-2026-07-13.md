# Unapplied Datatypes Tickets (2026-07-13)

## Scope

- Source folders scanned: `jira/open` and `jira/active`
- Inclusion rule: canonical ticket file (`FHIR-xxxxx.md`) contains `datatypes` (case-insensitive)
- "Unapplied" interpretation: tickets not in `jira/closed`

## Totals

- Total unapplied datatypes-related tickets: 17
- Status `Resolved - change required`: 13
- Status `Waiting for Input`: 4

## Ticket List

| Key | Status | Summary | Jira |
|---|---|---|---|
| FHIR-26023 | Resolved - change required | Create a recommended set of timing choice datatypes | https://jira.hl7.org/browse/FHIR-26023 |
| FHIR-40405 | Resolved - change required | Need profile on Identifer datatype that is holding a User identity | https://jira.hl7.org/browse/FHIR-40405 |
| FHIR-40628 | Resolved - change required | eld-11 constraint for ElementDefinition.binding precludes CodeableReference | https://jira.hl7.org/browse/FHIR-40628 |
| FHIR-41191 | Resolved - change required | Regex for base64 datatype does not comply with RFC | https://jira.hl7.org/browse/FHIR-41191 |
| FHIR-44049 | Resolved - change required | Format on data types page is faulty | https://jira.hl7.org/browse/FHIR-44049 |
| FHIR-44639 | Resolved - change required | Datatype diagrams and some references need fixing | https://jira.hl7.org/browse/FHIR-44639 |
| FHIR-44988 | Resolved - change required | Add an identifier type for FHIR resource id's | https://jira.hl7.org/browse/FHIR-44988 |
| FHIR-45021 | Waiting for Input | Datatype Range, definition not clear for age ranges | https://jira.hl7.org/browse/FHIR-45021 |
| FHIR-46130 | Resolved - change required | Remove (e.g., ...) from Data Absent Reason not-applicable description | https://jira.hl7.org/browse/FHIR-46130 |
| FHIR-46453 | Resolved - change required | dateTime RegEx allows to specify a date & time without timezone | https://jira.hl7.org/browse/FHIR-46453 |
| FHIR-48493 | Resolved - change required | UseageContext should be sliced to match valueCodeableConcept domains to code | https://jira.hl7.org/browse/FHIR-48493 |
| FHIR-48692 | Resolved - change required | Clarification on the Use of Identifiers in FHIR Specification | https://jira.hl7.org/browse/FHIR-48692 |
| FHIR-48958 | Waiting for Input | Clarify expectations around canonical version uniqueness | https://jira.hl7.org/browse/FHIR-48958 |
| FHIR-50586 | Resolved - change required | "constraints" box is missing for RelativeTime and SampledData | https://jira.hl7.org/browse/FHIR-50586 |
| FHIR-51098 | Waiting for Input | Add a new element for the canoncaization algorithm to Signature | https://jira.hl7.org/browse/FHIR-51098 |
| FHIR-51218 | Waiting for Input | Add concepts to the Identifier-type value set http://hl7.org/fhir/ValueSet/identifier-type | https://jira.hl7.org/browse/FHIR-51218 |
| FHIR-53984 | Resolved - change required | Allow more types for DataRequirement.valueFilter.value[x] | https://jira.hl7.org/browse/FHIR-53984 |

## Short Summary

- Most unapplied datatypes tickets are implementation-ready (`Resolved - change required`) and cluster around datatype correctness/clarity: regex constraints, value set coverage, identifier handling, and datatype page consistency.
- Four items are still blocked on clarification (`Waiting for Input`): FHIR-45021, FHIR-48958, FHIR-51098, and FHIR-51218.
- Candidate immediate execution queue (resolved items): FHIR-26023, FHIR-40405, FHIR-40628, FHIR-41191, FHIR-44049, FHIR-44639, FHIR-44988, FHIR-46130, FHIR-46453, FHIR-48493, FHIR-48692, FHIR-50586, FHIR-53984.
