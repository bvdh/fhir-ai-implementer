# Implementation Plan: FHIR-44639

## Scope Summary
- Workgroup/source: FHIR Infrastructure (single ticket, no rollup file supplied)
- Tickets in scope: FHIR-44639
- Primary fix pattern: Datatype categorization/diagram-source correction. Ticket reports two issues on the Datatypes/Metadata Types pages: (1) `Contributor` still appearing in the metadatatypes diagram and as a place where `ContactDetail` is used, and (2) `CodeableReference` incorrectly rendered under "Special Purpose Datatypes" when it is defined as a general-purpose Complex data type.

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-44639 | Datatype diagrams and some references need fixing | Resolved - change required | Datatypes (`source/datatypes.html`), Metadata Types (`source/metadatatypes.html`) | Correction (diagram source classification) | Two distinct sub-issues; investigation found only one is currently reproducible in this repo's source (see Investigation Findings). |

## Shared Implementation Approach
1. Locate files under `fhir-fork/source/`.
2. Apply edits using consistent wording/style rules.
3. Keep changes minimal and traceable to ticket intent.

(Not a repetitive/batch ticket — single-ticket plan with two sub-issues.)

## Investigation Findings (edit-surface search)

- The Datatypes and Metadata Types pages render their overview diagrams via kindling `[%diagram <name> N%]` macros (`source/datatypes.html` lines 54–55), each backed by a hand-curated `.diagram` source file under `source/datatypes/` (`classes=` list plus `[directions]` x;y placement — these are manually maintained groupings, not auto-derived from each type's `kind`).

- **Sub-issue 2 (CodeableReference) — confirmed reproducible, in scope:**
  - [source/datatypes/specialtypes.diagram](fhir-fork/source/datatypes/specialtypes.diagram) `classes=` line currently includes `CodeableReference` alongside `Reference, Narrative, Extension, Meta, ElementDefinition, Dosage, xhtml, DosageDetails, DosageCondition, DosageSafety` — i.e., it is rendered as a Special Purpose Datatype.
  - [source/datatypes/alltypes.diagram](fhir-fork/source/datatypes/alltypes.diagram) — the General-Purpose Datatypes diagram — does **not** include `CodeableReference` in its `classes=` list (`Identifier, HumanName, Address, ContactPoint, Timing, RelativeTime, Quantity, SimpleQuantity, Attachment, Range, Period, Ratio, RatioRange, CodeableConcept, Coding, SampledData, Age, Distance, Duration, Count, Money, MoneyQuantity, Annotation, Signature`).
  - `source/datatypes.html` line 37's textual "Special purpose datatypes" list (`Reference, Meta, Narrative, Extension, xhtml, ElementDefinition, Dosage`) does **not** mention `CodeableReference` — so only the diagram source file is wrong, not the narrative text.
  - Confirms the ticket's claim exactly: `CodeableReference` is misplaced in the special-purpose diagram and missing from the general-purpose complex-types diagram.

- **Sub-issue 1 (Contributor) — investigated, NOT currently reproducible:**
  - Searched exhaustively for `Contributor` across `source/datatypes/` (all `.diagram` files), `source/metadatatypes.html`, and `source/datatypes.html`: zero matches.
  - Searched for any lingering `type value="Contributor"` reference or a `source/**/Contributor*` file anywhere in `fhir-fork/source/`: none found.
  - [source/datatypes/metadatatypes.diagram](fhir-fork/source/datatypes/metadatatypes.diagram) `classes=` list is `DataType, ContactDetail, DataRequirement, ParameterDefinition, RelatedArtifact, TriggerDefinition, UsageContext, Expression, ExtendedContactDetail, VirtualServiceDetail, Availability, MonetaryComponent` — no `Contributor` entry.
  - Conclusion: the `Contributor` datatype (removed from FHIR core between R4 and R5) has already been fully removed from this repository's current source tree (R6-ballot4 baseline), well after this ticket was filed in 2024. Both the diagram class list and the `ContactDetail`-usage cross-reference (`[%dtusage ContactDetail%]` in `source/metadatatypes.html` line 78) have nothing left in source that could regenerate a `Contributor` entry.
  - This sub-issue appears to have been resolved by natural spec evolution prior to this repo's current baseline, independent of this ticket. No source edit is proposed for it (see Execution Steps and Risks for the recommended confirmation step).

## Execution Steps

1. **Fix CodeableReference categorization** (the only source change needed):
   - In [source/datatypes/specialtypes.diagram](fhir-fork/source/datatypes/specialtypes.diagram): remove `CodeableReference` from the `classes=` line, and remove its corresponding `CodeableReference=-80;-50` entry from `[directions]`.
   - In [source/datatypes/alltypes.diagram](fhir-fork/source/datatypes/alltypes.diagram): add `CodeableReference` to the `classes=` line (grouped near `CodeableConcept`/`Coding`, its closest semantic relatives), and add a corresponding `[directions]` x;y coordinate that does not collide with existing entries (e.g., near `CodeableConcept=-160;00` / `Coding=-160;40`, such as `CodeableReference=-160;-40`), adjusting `[size]` width/height only if the new placement requires more diagram canvas.
2. **Cross-file consistency check**: confirm `source/datatypes.html`'s narrative type-category lists (primitive/general-purpose/special-purpose, lines ~26–38) do not separately enumerate `CodeableReference` in the wrong category (checked — they don't reference it by name at all, so no narrative text change is needed).
3. **Confirm no other `.diagram` file duplicates or omits CodeableReference incorrectly**: `types.diagram`, `types2.diagram`, `types2a.diagram`, `types3.diagram`, `abstracts.diagram`, `primitives.diagram`, `allprimitivetypes.diagram` were not part of this investigation's scope (they render different sub-views); a quick grep for `CodeableReference` across all `.diagram` files should be re-run after the edit to ensure only `alltypes.diagram` now contains it.
4. **Contributor/ContactDetail sub-issue — no source edit planned**: since no reproducible defect exists in current source, do not make a speculative edit; verify via the build step below instead. If it unexpectedly still appears in generated output despite no source reference, that would indicate a kindling/tooling-side issue outside `fhir-fork/source/` (escalate per repository rules), not a source content gap.
5. **Build the spec and check the generated HTML output** (required before considering either sub-issue resolved):
   - Run a full generate build (no `-nogen`) from `fhir-fork/`: `./gradlew publish`.
   - Confirmed output location: generated pages land in `fhir-fork/publish/` (verified `publish/datatypes.html` and `publish/metadatatypes.html` exist from the prior build).
   - **CodeableReference check** — inspect `fhir-fork/publish/datatypes.html`:
     - `grep -n "CodeableReference" fhir-fork/publish/datatypes.html` and confirm it appears only in the General-Purpose Datatypes diagram/section, not under the Special Purpose Datatypes diagram/section.
     - Visually confirm the rendered General-Purpose Datatypes diagram image includes a `CodeableReference` box, and the Special Purpose Datatypes diagram image no longer does.
   - **Contributor check** — inspect `fhir-fork/publish/metadatatypes.html`:
     - `grep -n "Contributor" fhir-fork/publish/metadatatypes.html` and confirm zero matches (i.e., it does not appear in the rendered metadatatypes diagram or in the `ContactDetail is used in the following places` cross-reference list).
   - Record the grep output (or lack of matches) in the implementation change log as verification evidence once the CodeableReference edit is implemented and the build is rerun.

## Validation Checklist
- [x] Each ticket sub-issue mapped to at least one file/page (`specialtypes.diagram` + `alltypes.diagram` for CodeableReference; `metadatatypes.diagram`/`metadatatypes.html` investigated for Contributor).
- [x] Planned edits stay within `fhir-fork/source/`.
- [x] No unrelated formatting/tooling changes.
- [x] `classes=` and `[directions]` entries stay consistent (no orphaned coordinate without a matching class, and vice versa) in both edited `.diagram` files.
- [x] Plan is review-ready and references ticket intent (FHIR-44639).
- [x] Full build run (`./gradlew publish`, no `-nogen`) completed after the CodeableReference edit — BUILD SUCCESSFUL in 24m 48s.
- [x] `fhir-fork/publish/datatypes.html` inspected: `CodeableReference` appears in the General-Purpose Datatypes diagram/section (line 224, within the 217–237 SVG range) and no longer in the Special Purpose Datatypes diagram/section (237+).
- [x] `fhir-fork/publish/metadatatypes.html` inspected: `Contributor` matches (12) are all inside an unrelated version-diff changelog block, not the diagram or the `ContactDetail` usage cross-reference — confirms sub-issue 1 is not present.

See [FHIR-44639-implementation-change-log.md](FHIR-44639-implementation-change-log.md) for full verification detail.

## Risks and Assumptions
- **Risk**: `.diagram` files use manually-maintained pixel coordinates; adding `CodeableReference` to `alltypes.diagram` could visually overlap an existing class box depending on the renderer's layout behavior. A full build and visual check of the generated SVG/diagram image is recommended before considering this complete.
- **Risk**: Because `Contributor` is not reproducible in current source, there is a chance the reporter's 2024 observation was tied to an older spec version's generated output (possibly a stale cached page) rather than a persistent source defect — recommend confirming with a fresh full build rather than assuming the ticket is fully moot without verification.
- **Assumption**: The manually-curated `classes=`/`[directions]` structure in `.diagram` files is the correct and only edit surface for these diagrams (no auto-generation from `kind` metadata was found to override this).
- **Open question**: Should the `Contributor` sub-issue be marked as already-resolved/no-action in the ticket disposition, or should a full-build confirmation step be performed first and its result recorded before closing that portion of the ticket?
