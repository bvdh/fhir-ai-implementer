# Implementation Change Log: FHIR-44639

## Summary

Fixed the datatype categorization defect: `CodeableReference` was incorrectly rendered under "Special Purpose Datatypes" instead of "General-Purpose Datatypes" on the Datatypes page. Investigated the ticket's second sub-issue (`Contributor` appearing in the metadatatypes diagram / `ContactDetail` usage list) and confirmed it is not reproducible in this repository's current source or generated output.

## Changes

### 1. `fhir-fork/source/datatypes/specialtypes.diagram`
- Removed `CodeableReference` from the `classes=` list.
- Removed the corresponding `CodeableReference=-80;-50` line from `[directions]`.

### 2. `fhir-fork/source/datatypes/alltypes.diagram`
- Added `CodeableReference` to the `classes=` list (placed adjacent to `CodeableConcept`).
- Added `CodeableReference=-160;-80` to `[directions]`.
- Increased `[size] width` from `500` to `560` and `height` from `248` to `278` to give the new box clearance from neighboring entries (`Ratio=-160;-120`, `CodeableConcept=-160;-40`, `Annotation=-160;0`).
- Repositioned several existing boxes to eliminate overlap after adding `CodeableReference` and enlarging the canvas: `DataType` (`0;-40` -> `20;-40`), `BackboneType` (`-10;0` -> `0;20`), `SampledData` (`150;80` -> `170;80`), plus most `[directions]` y-coordinates for the right-hand column (`Ratio`, `Period`, `Range`, `RatioRange`, `Attachment`, `Identifier`, `HumanName`, `Address`, `Signature`, `ContactPoint`) shifted to fit the taller canvas.
- Removed a duplicate stray `SimpleQuantity=165;160` line (leftover second entry for a class already positioned at `SimpleQuantity=165;120`).

### 3. `fhir-fork/source/datatypes/specialtypes.diagram` (canvas height)
- Increased `[size] height` from `148` to `260`. Not part of the original ticket description, but folded into this same commit at explicit user request: the taller canvas keeps this diagram's proportions matched to `metadatatypes.diagram` and gives bottom-row boxes clearance.

### 4. `fhir-fork/source/datatypes/metadatatypes.diagram` (canvas height)
- Increased `[size] height` from `188` to `260`. Not part of the original ticket description; folded into this commit at explicit user request. Root cause: `MonetaryComponent=-50;120` and `VirtualServiceDetail=100;120` sit past the usable half-height of the previous `188`-tall canvas, clipping them off the bottom of the rendered diagram.

No changes were made to `source/datatypes.html` or `source/metadatatypes.html` — their narrative text already correctly excluded `CodeableReference` from the special-purpose list and contained no reference to `Contributor`.

## Verification (full build + generated HTML inspection)

Ran a full generate build: `./gradlew publish` (no `-nogen`) — **BUILD SUCCESSFUL in 24m 48s**.

- `grep -n "General-Purpose Datatypes\|Special Purpose Datatypes" publish/datatypes.html` located the two diagram SVG blocks: General-Purpose at line 217 (width now `560`, confirming the size change took effect), Special Purpose at line 237.
- `grep -n "CodeableReference" publish/datatypes.html` returned 4 matches:
  - Line 224 — inside the General-Purpose Datatypes SVG (217–237 range). **Correct.**
  - Line 2510 — a narrative cross-reference link (`CodeableConcept is used in the following places: ... CodeableReference ...`), unrelated to diagram placement. Benign.
  - Lines 9697, 10329 — narrative content in `CodeableReference`'s own type-definition section. Benign/expected.
  - No matches fell within the Special Purpose Datatypes SVG range (237+). **Confirms the defect is fixed.**
- `grep -c "Contributor" publish/metadatatypes.html` returned 12 matches; `grep -o '.\{40\}Contributor.\{40\}'` showed all 12 are inside a version-diff changelog block (`"diff-right"><ul><li>Remove codes <code>Contributor</code>, ...`), documenting the historical removal of `Contributor` — not the metadatatypes diagram or the `ContactDetail` "used in the following places" cross-reference. **Confirms sub-issue 1 is not present as a defect in current generated output.**

## Outcome

- **Sub-issue 2 (CodeableReference categorization): Fixed and verified.**
- **Sub-issue 1 (Contributor in metadatatypes diagram): Confirmed not reproducible** in this repository's current source or full-build generated output; no action taken beyond verification, consistent with the implementation plan's recommendation.

## Not Verified

- Visual/pixel-level layout correctness of the updated `alltypes.diagram` SVG (no box overlap) was not manually inspected as a rendered image in this pass; the `[size]`/`[directions]` values were chosen with generous spacing based on neighboring coordinates, and the SVG did generate successfully with the expected width, but a human visual check of `publish/datatypes.html`'s rendered diagram is recommended as a final sanity check.
