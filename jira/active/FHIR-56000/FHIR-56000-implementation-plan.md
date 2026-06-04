# Implementation Plan: FHIR-56000

## Scope Summary
- Workgroup/source: Direct ticket scope (FHIR-56000)
- Tickets in scope: FHIR-56000
- Primary fix pattern: Terminology and datatype clarification/update for representing approximate quantity semantics via Quantity.comparator using comparator code `~` (not `ap`), including the resolution recommendation text (10% guidance and Quantity Confidence Interval extension reference)

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-56000 | Represent approximate comparator in quantity | Resolved - change required | Datatypes (Quantity, quantity-comparator value set/codelist) | Terminology + specification text update | Primary canonical edit surface is `fhir-fork/source/datatypes/quantity.xml` in the Quantity.comparator definition row around lines 883-898 and the `quantity-comparator` worksheet around lines 6362-6430. Required rendered verification surfaces include `fhir-fork/publish/valueset-quantity-comparator.html`, `fhir-fork/publish/valueset-quantity-comparator.json`, and `fhir-fork/publish/valueset-quantity-comparator.xml` after publish. Existing usages of comparator `ad` in examples (for impact review) include `fhir-fork/source/medication/medicationexample0322.xml:131` and repeated uses in nutrition examples (`fhir-fork/source/nutritionproduct/nutritionproduct-example-peanutbutter.xml` and `fhir-fork/source/nutritionproduct/nutritionproduct-example-shake.xml`). |

## Shared Implementation Approach
1. Update Quantity comparator semantics in canonical datatype spreadsheet source under `fhir-fork/source/datatypes/quantity.xml`.
2. Apply minimal, ticket-aligned terminology changes to represent "approximate" consistently using comparator code `~`.
3. Regenerate and verify `valueset-quantity-comparator` rendered artifacts to ensure the new comparator is reflected in published outputs.
4. Validate narrative and downstream example consistency without introducing unrelated terminology churn.

## Execution Steps
1. Confirm intended policy direction from ticket resolution context:
   - Preferred path: represent approximate semantics through Quantity comparator vocabulary using code `~`.
   - Fallback path: define/document extension only if comparator vocabulary change is explicitly rejected by maintainers.
2. Edit canonical comparator binding text in `fhir-fork/source/datatypes/quantity.xml`:
   - Quantity.comparator element row around lines 883-898 (definition/comments and allowed-code hint text).
   - Binding anchor row around lines 5901-5905 (`QuantityComparator` bound to `#quantity-comparator`).
   - Ensure comparator list includes `~` and does not introduce `ap` for this ticket.
3. Update comparator code list worksheet in `fhir-fork/source/datatypes/quantity.xml`:
   - `quantity-comparator` table around lines 6362-6430.
   - Add or revise code/display/definition to express "approximately" in line with ticket intent using code `~`, while preserving existing comparator semantics.
   - Include the resolution-specific recommendation text for approximation (10% guidance) and reference the Quantity Confidence Interval extension (`http://hl7.org/fhir/StructureDefinition/quantity-confidenceInterval`).
4. Verify generated/rendered narrative alignment:
   - Check Quantity narrative in `fhir-fork/source/datatypes.html` around lines 929-935 for consistency with comparator semantics.
   - Optionally add/update an explicit approximate example in `fhir-fork/source/datatypes-examples.html` around lines 758-768 if needed for clarity.
5. Publish and verify value set outputs:
   - Run `./gradlew publish` from `fhir-fork/` after source edits.
   - Verify `fhir-fork/publish/valueset-quantity-comparator.html`, `fhir-fork/publish/valueset-quantity-comparator.json`, and `fhir-fork/publish/valueset-quantity-comparator.xml` include comparator code `~` with expected display/definition text.
6. Perform downstream impact review for existing `ad` usages:
   - `fhir-fork/source/medication/medicationexample0322.xml:131`
   - `fhir-fork/source/nutritionproduct/nutritionproduct-example-peanutbutter.xml` (multiple comparator `ad` entries)
   - `fhir-fork/source/nutritionproduct/nutritionproduct-example-shake.xml` (multiple comparator `ad` entries)
   - Decide whether examples need no change, selective update, or explanatory notes based on final comparator semantics.
7. Scope-control and consistency pass:
   - Keep edits in `fhir-fork/source/` only.
   - Avoid unrelated formatting or tooling changes.

## Validation Checklist
- [ ] Ticket is mapped to at least one concrete source edit location in `fhir-fork/source/`.
- [ ] Planned edits remain within `fhir-fork/source/` only.
- [ ] Quantity.comparator and `quantity-comparator` code list are updated in canonical source (`datatypes/quantity.xml`) using code `~` for approximate semantics.
- [ ] Resolution recommendation text is represented in canonical source for approximate comparator semantics, including 10% guidance and the Quantity Confidence Interval extension reference.
- [ ] Comparator code `ap` is not introduced for this ticket.
- [ ] `valueset-quantity-comparator` rendered artifacts are updated and verified in `fhir-fork/publish/`.
- [ ] Approximate semantics are unambiguous in code display/definition and narrative wording.
- [ ] Existing `ad` usages in example resources are reviewed for semantic consistency.
- [ ] Any optional example updates remain minimal and directly tied to ticket intent.
- [ ] No unrelated terminology/value set or build/tooling changes are introduced.

## Risks and Assumptions
- Risk: Comparator code introduction/repurposing could conflict with current meaning of existing `ad` code already present in source content.
- Risk: Choosing `~` instead of historical comparator patterns may require downstream confirmation in tooling and examples that parse comparator codes.
- Risk: Updating only rendered HTML text without updating the spreadsheet source would create non-authoritative drift.
- Assumption: `fhir-fork/source/datatypes/quantity.xml` is the canonical authoring source for Quantity comparator binding and comparator code list content.
- Assumption: The ticket expects core specification representation (not IG-only guidance) and therefore should be resolved in core datatype terminology.
- Open questions:
   - Confirm with maintainers that `~` is the accepted wire code for approximate quantity comparator in this release stream.
  - If a new/updated comparator semantic is adopted, should a dedicated explicit Quantity example be added in `datatypes-examples.html`?
