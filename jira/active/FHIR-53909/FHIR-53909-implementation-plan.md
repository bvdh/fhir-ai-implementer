# Implementation Plan: FHIR-53909

## Scope Summary
- Workgroup/source: FHIR Infrastructure; ticket file jira/active/FHIR-53909/FHIR-53909.md
- Tickets in scope: FHIR-53909
- Primary fix pattern: Add normative guidance note to reference-search behavior for additionalReference extension

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-53909 | How do reference search params interact with the alternate-reference extension? | Resolved - change required (Resolution: Persuasive) | search.html#reference (source: fhir-fork/source/search.html around line 3232) | Clarification note insertion | Add resolution-provided note in reference search type section; confirm extension naming/link style in surrounding content |

## Shared Implementation Approach
1. Use the ticket resolution text as the canonical wording for the new note.
2. Insert the note in the `reference` search type section in `fhir-fork/source/search.html`.
3. Keep edits minimal and localized; avoid unrelated wording updates.

## Execution Steps
1. Open `fhir-fork/source/search.html` and navigate to the `<a name="reference"></a>` / `<h4>reference</h4>` section (near line 3232).
2. Add a note paragraph in this section using the ticket resolution wording:
   - "Instead of Reference.reference, some elements might instead contain the [additionalReference]() extension. Systems SHOULD support indexing and searching against content found in this extension as well unless there are constraints in place that ensure that additionalReference is never present."
3. Replace placeholder link syntax `[additionalReference]()` with repository-consistent hyperlink markup to the actual extension target used in this codebase.
4. Ensure the note placement is within the reference-search guidance flow (near existing explanation of `Reference.reference` matching semantics).
5. Confirm no edits outside `fhir-fork/source/search.html` unless link-target clarification requires one supporting wording update in `fhir-fork/source/references.html`.

## Likely Impacted Files and Lines
- Primary target: `fhir-fork/source/search.html`
  - Reference search section anchor and heading around line 3231-3232
  - Existing `Reference.reference` semantics examples around lines 3234-3330
- Verification context only: `fhir-fork/source/references.html`
  - alternate-reference guidance around line 320

## Validation Checklist
- [ ] Ticket is eligible for planning/execution (`Resolution` present, `Status` = `Resolved - change required`)
- [ ] New note appears in `search.html` reference search type section
- [ ] Wording remains faithful to approved resolution intent
- [ ] Extension link syntax is valid for this source format (no unresolved placeholder markdown)
- [ ] Diff is scoped to planned file(s) and excludes unrelated formatting changes
- [ ] Added guidance explicitly states expected indexing/searching behavior for extension-based references

## Risks and Assumptions
- Risk: Resolution text uses markdown-style `[additionalReference]()` placeholder that is not directly valid in this HTML source; link conversion choice may be ambiguous.
- Risk: Extension naming in ticket (`additionalReference`) may differ from current source naming (`alternate-reference`), requiring careful alignment.
- Assumption: Primary edit should be in `search.html` reference section, not in general references page.
- Open questions:
  - What exact link target should be used for `additionalReference` in this release branch?
  - Should wording explicitly mention both "additionalReference" and "alternate-reference" for discoverability?
