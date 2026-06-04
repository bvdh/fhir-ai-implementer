## Scope
One or more commits addressing the tickets listed below.

## Tickets Addressed
- FHIR-41631
- FHIR-40696
- FHIR-44645
- FHIR-46202
- FHIR-47129
- FHIR-53636
- FHIR-51735
- FHIR-54058
- FHIR-54062
- FHIR-54490
- FHIR-56000
- FHIR-57408
- FHIR-50260

## Per-Ticket Change Summary
- FHIR-41631: Verified all in-scope datatypes and metadatatypes pages already use [%wg fhir%]/[%wgt fhir%].
- FHIR-40696: Replaced broken literal timezone extension text in datatypes instant value-domain note.
- FHIR-44645: Re-execute ticket validation against source and published output for HumanName anchors.
- FHIR-46202: Update code primitive regex in datatypes source to the approved expression.
- FHIR-47129: update the Duration drt-1 FHIRPath expression in duration.xml.
- FHIR-53636: Clarified id primitive description to explicitly prohibit all whitespace characters.
- FHIR-51735: Verified decimal regex in source/datatypes/primitives.xml has no trailing extra brace.
- FHIR-54058: Add endOffset column to the Timing criteria examples table.
- FHIR-54062: Add Timing notes section for periods with start or end offsets.
- FHIR-54490: Clarify that Attachment.url relative references resolve against the FHIR service base URL.
- FHIR-56000: Add comparator code ~ to the QuantityComparator code list in datatypes/quantity.xml.
- FHIR-57408: Allow SampledData to have interval and/or offsets instead of requiring XOR.
- FHIR-50260: Clarified SampledData datatype and lower/upper limit definitions to use scaled semantics (factor + origin).

## Notes on Overlaps
- No duplicate or overlapping implementations detected based on normalized per-ticket summaries.

## Commit Coverage Check
- Branch: datatypes.
- Branch commit tickets detected: FHIR-40696, FHIR-44645, FHIR-46202, FHIR-47129, FHIR-50260, FHIR-53636, FHIR-54058, FHIR-54062, FHIR-54490, FHIR-56000, FHIR-57408.
- Tickets without branch commit: FHIR-41631 (verification-only confirmed), FHIR-51735 (verification-only confirmed).
- Branch commit tickets not in currentTickets.md: none.

## Validation Notes
- Summary artifacts present for 13/13 tickets.
- Summary source used: commit-message bullet line for all tickets.
- Commit-message vs change-log first-change wording differs (commit-message precedence applied): FHIR-41631, FHIR-40696, FHIR-44645, FHIR-46202, FHIR-47129, FHIR-53636, FHIR-51735, FHIR-54058, FHIR-54062, FHIR-54490, FHIR-56000, FHIR-57408, FHIR-50260.
- Missing summary artifacts: none.
