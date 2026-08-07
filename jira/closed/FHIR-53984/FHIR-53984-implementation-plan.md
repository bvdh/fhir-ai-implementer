# Implementation Plan: FHIR-53984

## Scope Summary
- Workgroup/source: FHIR Infrastructure; ticket file jira/active/FHIR-53984/FHIR-53984.md
- Tickets in scope: FHIR-53984
- Primary fix pattern: DataRequirement valueFilter type expansion plus invariant addition for path/searchParam exclusivity

## Eligibility Gate
- Resolution present and non-empty: Persuasive (PASS)
- Status is Resolved - change required: yes (PASS)

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-53984 | Allow more types for DataRequirement.valueFilter.value[x] | Resolved - change required | metadatatypes.html, metadatatypes-definitions.html | Structural model update + invariant addition | Resolution text explicitly lists new value[x] types and requires a path/searchParam XOR constraint |

## Likely Edit Surface
- Primary source-of-truth file:
  - fhir-fork/source/datatypes/datarequirement.xml
    - DataRequirement.valueFilter.value[x] row: around line 1265
      - current types: dateTime|Period|Duration
      - needs replacement to: boolean|integer|string|Quantity|Range|Ratio|RatioRange
    - DataRequirement.valueFilter.value[x] definition/short text row: around lines 1278-1280
      - currently says Period/DateTime/Duration; update wording to match new type set
    - Existing filter rows used for invariant style parity:
      - DataRequirement.codeFilter.path: around line 965
      - DataRequirement.codeFilter.searchParam: around line 990
      - DataRequirement.dateFilter.path: around line 1090
      - DataRequirement.dateFilter.searchParam: around line 1115
      - DataRequirement.valueFilter.path: around line 1190
      - DataRequirement.valueFilter.searchParam: around line 1215
- Rendered page anchors expected to change after source update:
  - fhir-fork/source/metadatatypes.html
    - DataRequirement section macro: around line 90 (`[%dt DataRequirement 1%]`)
    - Constraints macro: around line 93 (`[%dt.constraints DataRequirement%]`)
  - fhir-fork/source/metadatatypes-definitions.html
    - DataRequirement dictionary section anchor: around line 48 (`<a name="DataRequirement"></a>`)

## Shared Implementation Approach
1. Apply all semantics in the canonical spreadsheet-style source row set at datatypes/datarequirement.xml.
2. Keep edits minimal and local to DataRequirement.valueFilter model rows plus invariant table rows.
3. Align invariant expression style with existing DataRequirement constraints (drq-1/drq-2 style and naming conventions).

## Execution Steps
1. Open fhir-fork/source/datatypes/datarequirement.xml and locate the row for DataRequirement.valueFilter.value[x] around line 1265.
2. Replace the type column value from `dateTime|Period|Duration` to:
   - `boolean|integer|string|Quantity|Range|Ratio|RatioRange`
3. Update the descriptive text in the same value[x] row so it no longer claims Period/DateTime/Duration and instead reflects the new allowed value types.
4. Add a new DataRequirement invariant for valueFilter to enforce XOR between path and searchParam:
   - intent: exactly one of valueFilter.path or valueFilter.searchParam must be present
   - place the invariant in the same constraint block pattern where drq-1 and drq-2 are defined
   - follow local naming convention for invariant id (likely drq-3, unless already used)
5. Ensure the invariant applies specifically to each valueFilter entry (not globally to unrelated filters).
6. Validate that no changes are introduced outside fhir-fork/source/datatypes/datarequirement.xml unless strictly required by generation conventions.
7. Run targeted checks:
   - confirm new type token exists
   - confirm old type token is removed from valueFilter.value[x] row
   - confirm new invariant id/expression exists and references valueFilter.path/searchParam
8. Review diff for scope control and alignment with ticket resolution text.

## Validation Checklist
- [ ] Ticket eligibility confirmed (Resolution present and Status is Resolved - change required)
- [ ] DataRequirement.valueFilter.value[x] type list matches ticket resolution exactly
- [ ] Legacy type set (`dateTime|Period|Duration`) removed from valueFilter.value[x] row
- [ ] New invariant exists ensuring path/searchParam XOR for valueFilter
- [ ] Invariant id/name does not collide with existing drq-* identifiers
- [ ] Planned edits stay within fhir-fork/source/
- [ ] Diff contains only intended DataRequirement changes
- [ ] Plan remains directly traceable to FHIR-53984 resolution text

## Risks and Assumptions
- Risk: invariant placement in the spreadsheet XML may be non-obvious; incorrect table placement could cause silent generation issues.
- Risk: changing allowed value[x] types may require corresponding narrative wording updates to avoid inconsistency in generated text.
- Assumption: fhir-fork/source/datatypes/datarequirement.xml is the authoritative source for DataRequirement element types and invariants.
- Assumption: the intended XOR rule is exactly one of path/searchParam for each valueFilter item, as stated in ticket resolution.
- Open questions:
  - Whether the invariant should assert exactly-one (`xor`) or at-least-one plus not-both (equivalent but different expression style).
  - Whether any extension references (cqf-valueFilter alignment notes) should be added in narrative text or kept implicit via type alignment only.
