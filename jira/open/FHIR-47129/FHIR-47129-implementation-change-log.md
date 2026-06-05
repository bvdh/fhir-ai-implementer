# Implementation Change Log: FHIR-47129

## Summary
- Plan: jira/active/FHIR-47129/FHIR-47129-implementation-plan.md
- Ticket: jira/active/FHIR-47129/FHIR-47129.md
- Execution date: 2026-05-28

## Files Changed
- fhir-fork/source/datatypes/duration.xml
- fhir-fork/source/evidencevariable/evidencevariable-example-outcome-death-or-major-injury.xml
- fhir-fork/source/plandefinition/plandefinition-options-example.xml
- fhir-fork/source/plandefinition/plandefinition-protocol-example.xml
- fhir-fork/source/requestorchestration/requestorchestration-example.xml

## Changes Applied
1. Updated the `drt-1` FHIRPath expression in `duration.xml` from `code.exists() implies ((system = %ucum) and value.exists())` to `value.exists() implies ((system = %ucum) and code.exists())`.
2. Updated the `drt-1` XPath expression from `(f:code or not(f:value)) and (not(exists(f:system)) or f:system/@value='http://unitsofmeasure.org')` to `not(exists(f:value)) or (exists(f:code) and exists(f:system) and f:system/@value='http://unitsofmeasure.org')` so it matches the same value-implies-code-and-UCUM rule.
3. Matched the current Duration invariant to the accepted historical fix from commit `0fa9bbb48c1eb0f222045bc1f95b20b217e47894` for FHIR-28415.
4. Updated `evidencevariable-example-outcome-death-or-major-injury.xml` to add UCUM `system` and `code` for `offsetDuration` where only `value` was present.
5. Updated `plandefinition-options-example.xml` to add UCUM `system` and `code` for `offsetDuration`.
6. Updated `requestorchestration-example.xml` to add UCUM `system` and `code` for `offsetDuration`.
7. Updated `plandefinition-protocol-example.xml` to add UCUM `system` and `code` for `goal.target.due` Duration.

## Historical Commits Referenced
- `c999ceec6362b8d87f983f22d770cff82ea5bfe7` - `#12408 - clarifying Duration`; introduced the mismatched `code.exists() implies ((system = %ucum) and value.exists())` expression.
- `f4c36d8a9ac96e7b746f0476e6321406e37ec381` - large 2018 rewrite that last touched the current row formatting in blame output, but did not establish the accepted semantics.
- `0fa9bbb48c1eb0f222045bc1f95b20b217e47894` - `Change to Duration and TriggerDefinition, Consent, and Questionnaire per FHIR-28415 and FHIR-25088`; restored the intended `value.exists() implies ((system = %ucum) and code.exists())` expression.

## Validation Performed
- Historical precedent lookup (`git show 0fa9bbb48c^..0fa9bbb48c -- source/datatypes/duration.xml`): PASS
- Source spot check in `fhir-fork/source/datatypes/duration.xml`: PASS
- Source spot checks in the four updated example files for Duration UCUM fields: PASS
- Old expression absent from `fhir-fork/source/datatypes/duration.xml`: PASS
- Old XPath absent from `fhir-fork/source/datatypes/duration.xml`: PASS
- Diff scope limited to intended files under `fhir-fork/source/`: PASS
- Publish regeneration for rendered `publish/datatypes.html`: SKIPPED

## Notes
- The prior `./gradlew publish` validation run was interrupted before completion, leaving `publish/datatypes.html` stale.
- A rerun of `./gradlew publish` in a dedicated terminal was not completed because the tool call was skipped, so rendered-output verification remains outstanding.
- No reusable new edit pattern was identified beyond the existing rule to keep ticket implementations constrained to `fhir-fork/source/`.