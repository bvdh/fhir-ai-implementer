## PR Title (Suggested)
Narrative guidance technical corrections (FHIR-48338, FHIR-54755, FHIR-54765)

## Scope Source
- Branch: `narrative`
- Scope file: `currentTickets.md`
- Included tickets:
  - [FHIR-48338](https://jira.hl7.org/browse/FHIR-48338)
  - [FHIR-54755](https://jira.hl7.org/browse/FHIR-54755)
  - [FHIR-54765](https://jira.hl7.org/browse/FHIR-54765)

## Ticket Summaries
- [FHIR-48338](https://jira.hl7.org/browse/FHIR-48338): Consolidate narrative id-reference guidance by moving detailed content to the linking section, clarifying that cross-resource narrative links use resource references (not XML ID/IDREF), and retaining Bundle scope rules for narrative fragment ids.
- [FHIR-54755](https://jira.hl7.org/browse/FHIR-54755): Clarify narrative links to other resources with a dedicated section, relative/absolute href guidance, and an explicit Patient/example anchor example.
- [FHIR-54765](https://jira.hl7.org/browse/FHIR-54765): Clarify narrative image references in document bundles, including use of `fullUrl` and an implementer-focused explanation of same-bundle expectations.

## Commit Coverage (fhir-fork)
Detected in `master..narrative`:
- `e5dc94ea0a` FHIR-54765: Clarify narrative image references in bundles
- `5eba80ade5` FHIR-54755: Clarify narrative resource-link guidance
- `c093101086` FHIR-48338: Consolidate narrative id-reference guidance

Coverage check:
- Tickets in scope with matching branch commits: FHIR-48338, FHIR-54755, FHIR-54765
- Tickets in scope without matching branch commits: none
- Ticket commits detected outside scope: none

## Validation Notes
- Ticket implementations were executed with source-boundary checks enforcing changes under `fhir-fork/source`.
- Publish/build verification was run during ticket execution workflow.
- Jira implementation artifacts for each ticket are present under `jira/active/<ticket>/`.

## Ready-to-Use PR Body
## Summary
This PR applies technical corrections for narrative guidance tickets in the FHIR specification source.

- [FHIR-48338](https://jira.hl7.org/browse/FHIR-48338): Consolidate narrative id-reference guidance by moving detailed content to the linking section, clarifying cross-resource references, and preserving Bundle fragment-id scope rules.
- [FHIR-54755](https://jira.hl7.org/browse/FHIR-54755): Clarify narrative links to other resources with explicit relative/absolute href guidance and a concrete Patient/example anchor example.
- [FHIR-54765](https://jira.hl7.org/browse/FHIR-54765): Clarify narrative image reference behavior in document bundles, including use of entry fullUrl and same-bundle expectations.

## Validation
- Built and published with `./gradlew publish` during ticket implementation workflow.
- Changes are limited to `fhir-fork/source` for specification-source compliance.
