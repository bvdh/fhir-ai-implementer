# Implementation Plan: FHIR-40984

## Scope Summary

- Workgroup/source: direct ticket scope (single ticket request).
- Tickets in scope: FHIR-40984.
- Primary fix pattern: wording/typo correction.

## Ticket Matrix

- Ticket: FHIR-40984
- Summary: Typo in documentation
- Status: Resolved - change required
- Target page(s): `fhir-fork/source/resource/resource-notes.xml` (versions section)
- Change type: wording/typo correction
- Notes: Resolution is Persuasive; correct `the busines version` to `the business version`.

## Shared Implementation Approach

1. Start with the resource versioning narrative source file and locate the exact typo string from the ticket.
2. Apply a minimal one-word spelling correction only where the ticket phrase occurs.
3. Keep changes traceable and avoid unrelated wording, formatting, or tooling changes.

## Target File Mapping

- Primary target: `fhir-fork/source/resource/resource-notes.xml`
- Mapping rationale: this file contains the authoritative source narrative for "Record Versions vs Business Versions vs FHIR Versions" and includes the sentence pattern about "the business version" referenced by the ticket.

## Execution Steps

1. Verify the target file exists before editing:
   - `test -f fhir-fork/source/resource/resource-notes.xml`
2. Locate exact ticket typo and nearest context:
   - `rg -n "the busines version|busines version" fhir-fork/source/resource/resource-notes.xml`
   - `rg -n "Record Versions vs Business Versions vs FHIR Versions|the business version" fhir-fork/source/resource/resource-notes.xml`
3. Primary execution path (if typo match is found):
   - Edit only `fhir-fork/source/resource/resource-notes.xml` and replace `busines` -> `business` in the ticket-target sentence.
   - Do not alter surrounding semantics or punctuation.
4. Already-applied fallback (if no typo match is found):
   - Treat ticket as already implemented in current branch state.
   - Record in execution notes that `busines version` is absent and no source edit is required.
5. Post-edit/readback verification:
   - `rg -n "busines version" fhir-fork/source/resource/resource-notes.xml`
   - `rg -n "the business version" fhir-fork/source/resource/resource-notes.xml`
   - `git -C fhir-fork diff -- source/resource/resource-notes.xml`

## Validation Checklist

- [ ] Ticket mapped to a concrete source file (`fhir-fork/source/resource/resource-notes.xml`)
- [ ] Planned edits stay within `fhir-fork/source/`
- [ ] No unrelated formatting/tooling/build changes
- [ ] Exact typo search performed for `busines version`
- [ ] If edit is made, only intended typo text is changed
- [ ] If typo is absent, already-applied no-op is documented with search evidence
- [ ] Plan is review-ready and implementation-specific

## Risks and Assumptions

- Risk: Similar wording may appear in generated/published artifacts outside `fhir-fork/source/` and could be mistaken as in-scope for this ticket.
- Assumption: Ticket intent is limited to correcting the exact misspelling in specification source narrative content.
- Open questions: If no typo remains in source, should ticket execution be recorded as no-op/already applied without any source commit?
