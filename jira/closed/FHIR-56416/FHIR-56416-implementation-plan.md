# Implementation Plan: FHIR-56416

## Scope Summary

- Workgroup/source: Direct ticket input (single-ticket planning).
- Tickets in scope: FHIR-56416.
- Primary fix pattern: wording clarity correction.

## Ticket Matrix

- Ticket: FHIR-56416
- Summary: Comment for ElementDefinition.constraint.source is poorly structured and confusing.
- Status: Resolved - change required.
- Target page(s): fhir-fork/source/datatypes/elementdefinition.xml.
- Change type: wording clarity correction.
- Notes: Resolution is Persuasive. Replace confusing sentence with clearer equivalent wording from ticket description.

## Shared Implementation Approach

1. Locate the ElementDefinition.constraint.source comment text in the mapped source file.
2. Apply a minimal, sentence-level wording update that preserves original meaning while improving readability.
3. Keep the change strictly scoped to the ticket text and avoid unrelated edits.

## Execution Steps

1. Open fhir-fork/source/datatypes/elementdefinition.xml and navigate to the ElementDefinition.constraint.source definition row.
2. Confirm the existing comment text matches the ticket description:
   - "This is used when, e.g. rendering, where it is not useful to present inherited constraints when rendering the snapshot"
3. Replace it with the proposed clarified wording from the ticket:
   - "This is used when it is not useful to present inherited constraints while rendering the snapshot."
4. Verify no other neighboring narrative text was changed and whitespace/format remains consistent with file conventions.
5. Run a focused search to ensure the old phrasing no longer exists in fhir-fork/source and the new phrasing appears in the expected location.

## Validation Checklist

- [ ] Ticket mapped to at least one concrete source file/page under fhir-fork/source/
- [ ] Planned edits stay within fhir-fork/source/
- [ ] No unrelated formatting/tooling/build changes
- [ ] Updated sentence preserves intent while improving readability
- [ ] Old sentence removed and new sentence present in target location
- [ ] Plan is review-ready and implementation-specific

## Risks and Assumptions

- Risk: Minor punctuation/terminal-period differences may be required by local style conventions in spreadsheet-backed source rows.
- Assumption: The correction is fully resolved by updating this single narrative comment instance.
- Open questions: If the same wording appears in generated artifacts outside source, should those be excluded here and handled by normal publication/build outputs only?
