## Scope
One or more commits addressing the tickets listed below.

## Per-Ticket Change Summary
- [FHIR-40696](https://jira.hl7.org/browse/FHIR-40696): Replaced broken literal timezone extension text in datatypes instant value-domain note.
- [FHIR-41631](https://jira.hl7.org/browse/FHIR-41631): Verified all in-scope datatypes and metadatatypes pages already use [%wg fhir%]/[%wgt fhir%].
- [FHIR-44639](https://jira.hl7.org/browse/FHIR-44639): Fixed CodeableReference datatype categorization (moved from Special Purpose to General-Purpose Datatypes diagram) and corrected diagram canvas heights so bottom-row boxes no longer clip.
- [FHIR-44645](https://jira.hl7.org/browse/FHIR-44645): Re-execute ticket validation against source and published output for HumanName anchors.
- [FHIR-46202](https://jira.hl7.org/browse/FHIR-46202): Update code primitive regex in datatypes source to the approved expression.
- [FHIR-46453](https://jira.hl7.org/browse/FHIR-46453): Fixed dateTime regex so a timezone offset is required whenever an hours/minutes time component is present.
- [FHIR-47129](https://jira.hl7.org/browse/FHIR-47129): update the Duration drt-1 FHIRPath expression in duration.xml.
- [FHIR-48493](https://jira.hl7.org/browse/FHIR-48493): Added additional binding uc-bind-age (purpose preferred) on UsageContext.code=age, pointing to http://terminology.hl7.org/ValueSet/v3-AgeGroupObservationValue; fixed purpose value typo "exetensible" -> "extensible" on the existing uc-bind-jurisdiction additional binding.
- [FHIR-50260](https://jira.hl7.org/browse/FHIR-50260): Clarified SampledData datatype and lower/upper limit definitions to use scaled semantics (factor + origin).
- [FHIR-50586](https://jira.hl7.org/browse/FHIR-50586): Add RelativeTime constraints box to datatypes page.
- [FHIR-51735](https://jira.hl7.org/browse/FHIR-51735): Verified decimal regex in source/datatypes/primitives.xml has no trailing extra brace.
- [FHIR-53636](https://jira.hl7.org/browse/FHIR-53636): Clarified id primitive description to explicitly prohibit all whitespace characters.
- [FHIR-53984](https://jira.hl7.org/browse/FHIR-53984): Allow more types for DataRequirement.valueFilter.value[x].
- [FHIR-54058](https://jira.hl7.org/browse/FHIR-54058): Add endOffset column to the Timing criteria examples table.
- [FHIR-54062](https://jira.hl7.org/browse/FHIR-54062): Add Timing notes section for periods with start or end offsets.
- [FHIR-54490](https://jira.hl7.org/browse/FHIR-54490): Clarify that Attachment.url relative references resolve against the FHIR service base URL.
- [FHIR-56000](https://jira.hl7.org/browse/FHIR-56000): Add comparator code ~ to the QuantityComparator code list in datatypes/quantity.xml.
- [FHIR-57408](https://jira.hl7.org/browse/FHIR-57408): Allow SampledData to have interval and/or offsets instead of requiring XOR.

## Notes on Overlaps
- No duplicate or overlapping implementations detected based on normalized per-ticket summaries.
