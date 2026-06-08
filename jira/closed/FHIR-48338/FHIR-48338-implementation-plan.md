# Implementation Plan: FHIR-48338

## Scope Summary
- Workgroup/source: FHIR Infrastructure; ticket file `jira/active/FHIR-48338/FHIR-48338.md`
- Tickets in scope: FHIR-48338
- Primary fix pattern: Narrative structural clarification and cross-section consolidation for id/idref and cross-resource linking semantics

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-48338 | Update narrative for id/idref | Resolved - change required | `fhir-fork/source/narrative.html` (references/linking sections) | Structural + wording clarification | Resolution requires consolidating internal-id guidance into linking guidance and clarifying cross-resource references in document bundles |

## Likely Edit Surface
- `fhir-fork/source/narrative.html:246` (anchor `internal` and section text currently titled "References to other resources")
- `fhir-fork/source/narrative.html:261` (anchor `linking`, section "Linking between Data and Narrative")
- `fhir-fork/source/narrative.html:296` (Bundle/Composition example used to explain cross-resource originalText references)
- `fhir-fork/source/narrative.html:317` (`valueUrl` example using `Composition/...#a1`)

## Shared Implementation Approach
1. Locate existing internal/reference/linking narrative content in `fhir-fork/source/narrative.html`.
2. Align wording so that internal-id semantics and cross-resource links are explained in one coherent narrative flow, consistent with ticket resolution text.
3. Keep anchors stable (`internal`, `linking`) and keep edits minimal to avoid unrelated churn.

## Execution Steps
1. Baseline review
- Read `jira/active/FHIR-48338/FHIR-48338.md` and confirm acceptance intent from resolution and comments.
- Confirm current wording around `internal` and `linking` in `fhir-fork/source/narrative.html`.

2. Consolidation edit
- Ensure the internal-id guidance is not split across conflicting sections.
- Move/merge any remaining id/idref-specific guidance into the linking-oriented narrative, per ticket resolution.
- Clarify that links to other resources in narrative are ordinary resource references (`href` with relative/absolute references), not XML `IDREF` constraints.

3. Bundle/Composition clarification
- In the linking example block, explicitly preserve and/or refine wording that a narrative-to-resource reference in a document context uses normal resource references and bundle identity context rules.
- Keep the `Composition/...#fragment` style explanation in examples where needed for mapping `originalText` to narrative spans.

4. Consistency pass
- Verify there is no remaining contradictory text implying XHTML/XML `IDREF` processing semantics for cross-resource links.
- Ensure section order and transitions are coherent for readers moving from generic links to data-narrative linking.

5. Minimality and formatting
- Restrict changes to `fhir-fork/source/narrative.html`.
- Preserve existing examples unless wording correction is needed to satisfy ticket intent.

## Validation Checklist
- [ ] FHIR-48338 is mapped to at least one concrete file and section
- [ ] Planned edits are restricted to `fhir-fork/source/`
- [ ] Anchors for narrative navigation remain intact (`internal`, `linking`)
- [ ] Wording no longer implies invalid XML `IDREF` requirements for cross-resource narrative links
- [ ] Bundle/Composition guidance is technically consistent with resource reference semantics
- [ ] No unrelated formatting/tooling/build file changes are introduced
- [ ] Final diff is reviewable and traceable to FHIR-48338 intent

## Risks and Assumptions
- Risk: Existing nearby edits from other narrative tickets may overlap this same section and cause accidental semantic drift.
- Risk: Over-editing examples can change normative interpretation beyond ticket scope.
- Assumption: `narrative.html` is the primary and sufficient source artifact for this correction.
- Assumption: Maintaining current anchor names is required for stable deep links.
- Open questions: None currently blocking plan execution; if workgroup expects additional updates in Composition-specific pages, raise before implementation.
