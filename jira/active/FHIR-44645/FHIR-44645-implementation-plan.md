# Implementation Plan: FHIR-44645

## Scope Summary
- Workgroup/source: FHIR Infrastructure; jira/active/FHIR-44645/FHIR-44645.md
- Tickets in scope: FHIR-44645
- Primary fix pattern: Structural anchor/link reliability fix for HumanName with canonical definition target on Datatypes Definitions

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-44645 | HumanName anchor isn't working | Resolved - change required (Persuasive) | datatypes-definitions (definition target), datatypes/examples/mappings/profiles (cross-links) | Structural anchor/link fix | HumanName definition target is `datatypes-definitions.html#HumanName`; links should not incorrectly target `datatypes.html#HumanName` when definition intent is required |

## Determined Cause (Planning Analysis)
- HumanName definition content is now on `datatypes-definitions.html` and should resolve via `datatypes-definitions.html#HumanName`.
- Some generated links and navigation paths may still target `datatypes.html#HumanName`, which can create jump ambiguity or land on a non-definition section.
- The reported behavior is consistent with link-target mismatch (definition links aimed at Datatypes page instead of Datatypes Definitions page).
- Most likely correction is to normalize HumanName definition-oriented links to `datatypes-definitions.html#HumanName` and verify generated output resolves consistently.

## Initial Fragment Retarget Map
| Fragment currently seen as `datatypes.html#...` | Expected canonical target | Likely source ownership hint | Notes |
|---|---|---|---|
| HumanName | `datatypes-definitions.html#HumanName` | `source/datatypes*.html` cross-link blocks; datatype nav include templates | Definition content moved to Datatypes Definitions |
| DataRequirement | `metadatatypes.html#DataRequirement` | `source/metadatatypes*.html`; generated qa/search datatype link emitters | Metadata datatype |
| Expression | `metadatatypes.html#Expression` | `source/metadatatypes*.html`; generated qa/search datatype link emitters | Metadata datatype |
| ExtendedContactDetail | `metadatatypes.html#ExtendedContactDetail` | `source/metadatatypes*.html`; generated qa/search datatype link emitters | Metadata datatype |
| MonetaryComponent | `metadatatypes.html#MonetaryComponent` | `source/metadatatypes*.html`; generated qa/search datatype link emitters | Metadata datatype |
| TriggerDefinition | `metadatatypes.html#TriggerDefinition` | `source/metadatatypes*.html`; generated qa/search datatype link emitters | Metadata datatype |
| VirtualServiceDetail | `metadatatypes.html#VirtualServiceDetail` | `source/metadatatypes*.html`; generated qa/search datatype link emitters | Metadata datatype |
| Reference / reference | `references.html#Reference` | `source/references*.html`; case-normalization in generated link builders | Normalize case to canonical `Reference` |
| CodeableReference | `references.html#CodeableReference` | `source/references*.html`; generated qa/uml/search link emitters | Reference-family datatype |
| xhtml | `narrative.html#xhtml` | `source/narrative.html`; search index/template link emitters | Narrative section target |
| ElementDefinition | `elementdefinition.html#ElementDefinition` | `source/elementdefinition*.html`; datatype index or qa link emitters | Standalone datatype page |
| MarketingStatus | `marketingstatus.html#MarketingStatus` | `source/marketingstatus*.html`; datatype index or qa link emitters | Standalone datatype page |
| ProductShelfLife | `productshelflife.html#ProductShelfLife` | `source/productshelflife*.html`; datatype index or qa link emitters | Standalone datatype page |
| number | `search.html#number` | Search page templates/index generation (not datatypes source) | Search-page local fragment; not a Datatypes target |
| token | `search.html#token` | Search page templates/index generation (not datatypes source) | Search-page local fragment; not a Datatypes target |

Apply this map as the default retarget baseline during execution, and only deviate when source intent or generator rules show a different canonical destination.

## Shared Implementation Approach
1. Confirm the HumanName definition anchor in `fhir-fork/source/datatypes-definitions.html` is explicit and stable.
2. Retarget definition-oriented HumanName links to `datatypes-definitions.html#HumanName` where appropriate.
3. Keep all changes minimal and limited to anchor/link behavior in `fhir-fork/source/`.

## Execution Steps
1. Baseline current anchor behavior:
   - Inspect `fhir-fork/source/datatypes-definitions.html` around the HumanName section heading and nearby anchor tags.
   - Inspect generated `fhir-fork/publish/datatypes-definitions.html` for `name="HumanName"` (and alias if present) and section self-link behavior.
   - Treat `fhir-fork/publish/` as the authoritative validation target for this ticket.
   - If `fhir-fork/publish/datatypes-definitions.html` is missing or does not reflect current source, run `./gradlew publish` from `fhir-fork/` once, then continue validation.
2. Implement minimal source correction (only if required):
   - In `fhir-fork/source/datatypes-definitions.html`, ensure HumanName definition section includes explicit anchor aliases before/at the heading:
     - `<a name="HumanName"></a>`
     - `<a name="humanname"></a>`
   - Ensure no unrelated content or formatting is touched.
3. Verify inbound links:
   - Confirm definition-oriented references in these pages point to `datatypes-definitions.html#HumanName` (or an intentional alias if normalized):
     - `fhir-fork/source/datatypes.html`
     - `fhir-fork/source/datatypes-definitions.html`
     - `fhir-fork/source/datatypes-examples.html`
     - `fhir-fork/source/datatypes-mappings.html`
     - `fhir-fork/source/datatypes-profiles.html`
   - Confirm any same-pattern fragments in generated `publish/qa.html`, `publish/search.html`, and `publish/uml.html` are retargeted according to the map above.
4. Rebuild and validate:
   - Only run `./gradlew publish` when required (missing/stale publish output or post-edit regeneration).
   - Inspect `fhir-fork/publish/datatypes-definitions.html` to confirm anchor presence.
   - Click-test (or equivalent URL-fragment test) for `datatypes-definitions.html#HumanName` in generated output.
5. Record ticket artifacts after implementation:
   - `jira/active/FHIR-44645/FHIR-44645-implementation-change-log.md`
   - `jira/active/FHIR-44645/FHIR-44645-commit-message.txt`

## Validation Checklist
- [ ] HumanName definition target exists in generated Datatypes Definitions page (`datatypes-definitions.html#HumanName`)
- [ ] Optional lowercase alias (`#humanname`) resolves to the same section
- [ ] Definition-oriented cross-page references to HumanName resolve correctly after publish
- [ ] Planned edits remain within `fhir-fork/source/`
- [ ] No unrelated formatting/tooling changes were introduced
- [ ] Plan remains directly traceable to `jira/active/FHIR-44645/FHIR-44645.md`

## Risks and Assumptions
- Risk: The issue may depend on publication-time transforms rather than source-only markup.
- Risk: Duplicate IDs/anchors generated by downstream templates could still interfere with jump behavior.
- Assumption: Datatypes Definitions is the canonical target for HumanName definition links.
- Assumption: Ticket intent is limited to HumanName jump/link behavior, not broad Datatypes reformatting.
- Assumption: `fhir-fork/publish/` is kept current enough for validation; when stale, a single targeted publish rebuild is sufficient.
- Open questions: Whether the original failure was browser-specific or tied to a particular ballot snapshot/build.
