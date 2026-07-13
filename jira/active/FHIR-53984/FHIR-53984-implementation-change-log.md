# FHIR-53984 Implementation Change Log

## Summary
Implemented the approved plan for FHIR-53984 by expanding `DataRequirement.valueFilter.value[x]` allowed types and adding an explicit XOR invariant on `DataRequirement.valueFilter` to enforce mutual exclusivity between `path` and `searchParam`.

## Files Changed
- `fhir-fork/source/datatypes/datarequirement.xml`

## Source Edits
1. Updated the type list for `DataRequirement.valueFilter.value[x]`:
- From: `dateTime|Period|Duration`
- To: `boolean|integer|string|Quantity|Range|Ratio|RatioRange`

2. Updated valueFilter descriptive text to match the expanded type list and comparator semantics.

3. Added a new invariant row for `DataRequirement.valueFilter`:
- Human: `Either a path or a searchParam must be provided, but not both`
- FHIRPath: `path.exists() xor searchParam.exists()`
- XPath: `(exists(f:path) and not(exists(f:searchParam))) or (not(exists(f:path)) and exists(f:searchParam))`

## Validation Performed
- Confirmed `git diff` in `fhir-fork` contains only intended semantic changes in `source/datatypes/datarequirement.xml`.
- Confirmed old `dateTime|Period|Duration` remained unchanged for `DataRequirement.dateFilter.value[x]` (no accidental dateFilter regression).
- Confirmed new invariant row targets `DataRequirement.valueFilter` and uses XOR expression.

## Plan Conformance
Matches `jira/active/FHIR-53984/FHIR-53984-implementation-plan.md`:
- Target file is correct.
- Type expansion implemented as planned.
- XOR invariant implemented as planned.
- No out-of-scope edits introduced.
