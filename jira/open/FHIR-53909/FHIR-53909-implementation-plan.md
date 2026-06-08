# Implementation Plan: FHIR-53909

## Scope Summary
- Workgroup/source: FHIR Infrastructure; ticket file `jira/active/FHIR-53909/FHIR-53909.md`
- Tickets in scope: FHIR-53909
- Primary fix pattern: Clarification note for reference-search behavior when `additionalReference` extension is used

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-53909 | How do reference search params interact with the alternate-reference extension? | Resolved - change required (Resolution: Persuasive) | `search.html#reference` | Clarification / conformance guidance | Resolution text requires explicit indexing/searching guidance for `additionalReference` content |

## Shared Implementation Approach
1. Treat ticket `Resolution Description` as the source-of-truth wording intent.
2. Keep implementation constrained to `fhir-fork/source/` and localized to reference-search guidance.
3. Prefer minimal edits (single-paragraph insertion/update) and avoid unrelated reflow.

## Execution Steps
1. Open `fhir-fork/source/search.html` and navigate to the `<a name="reference"></a>` / `<h4>reference</h4>` section.
2. Ensure a paragraph exists in this section stating:
   - elements may contain the `additionalReference` extension instead of `Reference.reference`
   - systems SHOULD index/search against extension content unless constraints guarantee it is absent
3. Ensure `additionalReference` is linked to the extension definition URL used in this branch.
4. If wording is missing or materially different from resolution intent, update only that paragraph.
5. Do not modify other search-type sections unless required for consistency with this note.

## Likely Impacted Files and Lines
- Primary target: `fhir-fork/source/search.html`
  - Anchor and heading: around lines 3231-3232
  - Inserted/updated guidance paragraph: around lines 3259-3260
- Verification-only context: `fhir-fork/source/references.html`
  - Additional-resource reference guidance near line 319

## Validation Checklist
- [x] Ticket eligibility confirmed (`Resolution` present, `Status` = `Resolved - change required`)
- [ ] Guidance paragraph is present in `search.html` reference section
- [ ] Paragraph reflects resolution intent (extension-aware reference searching)
- [ ] Link target for `additionalReference` is valid
- [ ] Diff is limited to intended file/paragraph if edits are needed
- [ ] No unrelated formatting/tooling changes introduced

## Risks and Assumptions
- Risk: Minor wording drift could occur if paragraph is edited without preserving conformance intent.
- Risk: Extension naming (`alternate-reference` URL vs `additionalReference` label) may be confusing if not kept consistent.
- Assumption: Primary implementation location remains `search.html` reference section.
- Open question: whether any additional cross-links are needed from `references.html` for discoverability.

## Current Source Check
- As of planning time, `fhir-fork/source/search.html` already contains the expected guidance paragraph near lines 3259-3260.
- Execution may therefore be verification-only unless subsequent review requests wording adjustment.
