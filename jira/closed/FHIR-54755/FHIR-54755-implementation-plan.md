# Implementation Plan: FHIR-54755

## Scope Summary
- Workgroup/source: FHIR Infrastructure; ticket source is jira/active/FHIR-54755/FHIR-54755.md
- Tickets in scope: FHIR-54755
- Primary fix pattern: Narrative guidance restructuring and clarification for links from narrative to other resources

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-54755 | Narrative - please explain more clearly how to refer from a narrative to a resource | Resolved - change required | narrative.html#linking and narrative.html#internal | New section + section reordering/removal + anchor preservation | Resolution requests adding a new section above Internal Id References, removing Internal Id References content, and moving Linking between Data and Narrative up while keeping anchor tags |

## Likely Edit Surface (Files and Lines)
1. Existing Internal Id References section (to be replaced/restructured)
- fhir-fork/source/narrative.html:246
- fhir-fork/source/narrative.html:247
- fhir-fork/source/narrative.html:271
2. Existing Linking between Data and Narrative section (to be moved up while preserving anchor)
- fhir-fork/source/narrative.html:366
- fhir-fork/source/narrative.html:367
- fhir-fork/source/narrative.html:370
3. New section insertion point (above current Internal Id References)
- fhir-fork/source/narrative.html:246

## Shared Implementation Approach
1. Add a new `References to other resources` section above the current Internal Id References location with the resolution-provided explanatory text and example.
2. Remove the current `Internal Id References` section content as requested.
3. Move the existing `Linking between Data and Narrative` section upward to the location where Internal Id References currently appears.
4. Preserve both named anchors (`internal` and `linking`) to maintain backward compatibility with existing links.
5. Keep all edits localized to `fhir-fork/source/narrative.html` and avoid unrelated style/content modifications.

## Execution Steps
1. In `narrative.html`, insert section `References to other resources` directly above the current internal-id block with this core guidance:
- A narrative may include a link to another resource using an `<a/>` tag with `href` set to relative or absolute resource reference.
- When navigating such a link, the rendering system SHOULD make the target available via its normal resource rendering mechanism.
- Include explicit example: `<p>Patient: <a href="Patient/example">(link)</a></p>`.
2. Remove the `Internal Id References` section body per resolution request.
3. Move `Linking between Data and Narrative` section to the former internal-id position, while retaining `a name="internal"` and `a name="linking"` anchors in the final structure.
4. Ensure resulting section order in this part of page is:
- Image References
- References to other resources
- Linking between Data and Narrative
- (next existing section)
5. Diff-review for minimal scope and anchor preservation.

## Validation Checklist
- [ ] Ticket FHIR-54755 mapped to concrete file/anchors under `fhir-fork/source/`
- [ ] Planned edits stay within `fhir-fork/source/`
- [ ] New `References to other resources` section exists with resolution-aligned wording
- [ ] Example `<p>Patient: <a href="Patient/example">(link)</a></p>` is present
- [ ] Internal Id References section content removed as requested
- [ ] Linking between Data and Narrative appears in moved/upstream position
- [ ] Both `internal` and `linking` anchor tags are preserved
- [ ] No unrelated formatting/tooling/config changes

## Risks and Assumptions
- Risk: Removing the Internal Id References text may unintentionally lose normative guidance that other sections depend on.
- Risk: Anchor movement could break generated links if tags are not preserved exactly.
- Assumption: Resolution intent is to replace internal-id prose with the new cross-resource linking guidance while keeping deep-link compatibility.
- Open questions: Whether any concise replacement sentence for internal-id semantics is still desired under the moved linking section after removing the original internal-id block.
