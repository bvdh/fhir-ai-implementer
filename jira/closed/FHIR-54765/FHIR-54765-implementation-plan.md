# Implementation Plan: FHIR-54765

## Scope Summary
- Workgroup/source: FHIR Infrastructure; ticket source is jira/active/FHIR-54765/FHIR-54765.md
- Tickets in scope: FHIR-54765
- Primary fix pattern: Narrative guidance enhancement for image references (contained `id` plus document-bundle `fullUrl`) with example and implementer note

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-54765 | Links from images in narrative | Resolved - change required | narrative.html#id | Narrative text clarification + example addition + implementer note update | Resolution requests adding support language for `fullUrl` in document bundles and adding example + note about same-bundle tracking |

## Likely Edit Surface (Files and Lines)
1. Primary narrative section update (image references)
- fhir-fork/source/narrative.html:189
- fhir-fork/source/narrative.html:193
- fhir-fork/source/narrative.html:212
2. New/expanded bundle-oriented example placement
- fhir-fork/source/narrative.html:197
- fhir-fork/source/narrative.html:209
- fhir-fork/source/narrative.html:218
3. Cross-reference pattern for `fullUrl` usage in bundle examples (reference-only anchor)
- fhir-fork/source/narrative.html:374
- fhir-fork/source/narrative.html:376

## Shared Implementation Approach
1. Update the Image References prose in `narrative.html` to retain existing contained-resource `id` behavior and add the new option for `fullUrl` when contained in a document bundle.
2. Add or extend an example showing how image references resolve when narrative content is rendered from resources contained in a document bundle context.
3. Add an implementer note emphasizing both constraints from resolution intent:
- The reference must resolve within the same bundle context.
- Implementations need to track referenced resources so narrative can be rebuilt/rendered reliably.
4. Keep all edits localized to the image-reference subsection; avoid unrelated narrative section changes.

## Execution Steps
1. Edit `narrative.html` in the Image References section to adjust this sentence:
- Existing: image `src` may refer to contained DocumentReference/Binary by `id`.
- Add: it may also refer by `fullUrl` when the resource is contained within a document bundle.
2. Add a concrete example under the same section demonstrating image `src` resolution via bundle `fullUrl` (in addition to existing `#id` form).
3. Update the `[%impl-note%]` block under Image References to include both requirements:
- Resolution must be in the same bundle.
- Resource tracking is needed to rebuild narrative safely.
4. Verify consistency with existing bundle `fullUrl` narrative examples to avoid contradictory guidance.
5. Review diff for minimal scope in `fhir-fork/source/narrative.html` only (unless a second narrative-specific example file is strictly required by local rendering conventions).

## Validation Checklist
- [ ] Ticket FHIR-54765 mapped to at least one concrete source file/section
- [ ] Planned edits stay within `fhir-fork/source/`
- [ ] Image References prose includes the new `fullUrl` option for document bundles
- [ ] Example content for bundle `fullUrl` image reference is present
- [ ] Implementer note explicitly states same-bundle scope and resource-tracking need
- [ ] No unrelated formatting/tooling/config changes
- [ ] Plan is review-ready and traceable to ticket resolution wording

## Risks and Assumptions
- Risk: Ambiguous phrasing could imply cross-bundle `fullUrl` resolution; wording must clearly constrain to same bundle.
- Risk: Adding example text in the wrong narrative subsection could reduce discoverability of the new guidance.
- Assumption: The required example and implementer note can be satisfied within `narrative.html` without modifying generated/published artifacts.
- Open questions: Whether workgroup prefers replacing the current `id` example, or keeping it and adding a second `fullUrl` bundle example side-by-side.
