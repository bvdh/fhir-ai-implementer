# PR #4130: Narrative tickets

- Repository: [HL7/fhir](https://github.com/HL7/fhir)
- Pull request: [#4130](https://github.com/HL7/fhir/pull/4130)
- Status: `MERGED`
- Draft: false
- Branches: `narrative` → `master`
- Review decision: not reported
- Created: 2026-06-05T14:11:22Z
- Updated: 2026-06-05T15:51:55Z
- Closed: 2026-06-05T15:51:55Z
- Merged: 2026-06-05T15:51:55Z
- Synced: 2026-10-20T14:46:47Z

## Checks

| Check | Status | Conclusion |
|---|---|---|
| triage / eligibility | COMPLETED | SUCCESS |
| triage / build_timeout_alert | COMPLETED | SKIPPED |
| triage / triage | COMPLETED | SUCCESS |
| Master Branch Pipeline | COMPLETED | NEUTRAL |
| Pull Request Pipeline | COMPLETED | SUCCESS |


## Description

## Summary
This PR applies technical corrections for narrative guidance tickets in the FHIR specification source.

- [FHIR-48338](https://jira.hl7.org/browse/FHIR-48338): Consolidate narrative id-reference guidance by moving detailed content to the linking section, clarifying cross-resource references, and preserving Bundle fragment-id scope rules.
- [FHIR-54755](https://jira.hl7.org/browse/FHIR-54755): Clarify narrative links to other resources with explicit relative/absolute href guidance and a concrete Patient/example anchor example.
- [FHIR-54765](https://jira.hl7.org/browse/FHIR-54765): Clarify narrative image reference behavior in document bundles, including use of entry fullUrl and same-bundle expectations.

## Validation
- Built and published with `./gradlew publish` during ticket implementation workflow.
- Changes are limited to `fhir-fork/source` for specification-source compliance.


## Comments

No comments or reviews reported.

