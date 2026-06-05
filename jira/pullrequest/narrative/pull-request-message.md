## Summary
This PR applies technical corrections for narrative guidance tickets in the FHIR specification source.

- [FHIR-48338](https://jira.hl7.org/browse/FHIR-48338): Consolidate narrative id-reference guidance by moving detailed content to the linking section, clarifying cross-resource references, and preserving Bundle fragment-id scope rules.
- [FHIR-54755](https://jira.hl7.org/browse/FHIR-54755): Clarify narrative links to other resources with explicit relative/absolute href guidance and a concrete Patient/example anchor example.
- [FHIR-54765](https://jira.hl7.org/browse/FHIR-54765): Clarify narrative image reference behavior in document bundles, including use of entry fullUrl and same-bundle expectations.

## Validation
- Built and published with `./gradlew publish` during ticket implementation workflow.
- Changes are limited to `fhir-fork/source` for specification-source compliance.
