# Implementation Plan: FHIR-54062 (Forced Refresh)

## Scope Summary
- Workgroup/source: Direct ticket scope from FHIR-54062
- Tickets in scope: FHIR-54062
- Primary fix pattern: Verify and complete Timing.repeat startOffset/endOffset constraint + narrative alignment in datatypes content

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-54062 | Rework startOffset/endOffset constraint | Resolved - change required | Datatypes (Timing), Dosage examples | Constraint/narrative consistency | Current branch already includes period-required invariant logic; plan focuses on closure against resolution text |

## Shared Implementation Approach
1. Confirm what is already implemented in `timing.xml` invariants and element comments.
2. Close any remaining gaps from the approved resolution wording (especially notes/section references).
3. Keep edits minimal and constrained to `fhir-fork/source/`.

## Likely Edit Surface (Files and Lines)
- fhir-fork/source/datatypes/timing.xml:1194
  - `Timing.repeat.startOffset` definition already states period+frequency requirement; verify final wording against resolution text.
- fhir-fork/source/datatypes/timing.xml:1218
  - `Timing.repeat.endOffset` short text already uses "stop once" language; verify this is the intended final wording.
- fhir-fork/source/datatypes/timing.xml:1219
  - `Timing.repeat.endOffset` definition already states period+frequency requirement; verify consistency with notes text.
- fhir-fork/source/datatypes/timing.xml:3723
  - Invariant #11 English text currently: startOffset requires `frequency > 1` and `period` present.
- fhir-fork/source/datatypes/timing.xml:3725
  - Invariant #11 FHIRPath currently: `startOffset.exists() implies (frequency > 1 and period.exists())`.
- fhir-fork/source/datatypes/timing.xml:3730
  - Invariant name currently `endOffset1`; verify naming expectation for ticket narrative/reference clarity.
- fhir-fork/source/datatypes/timing.xml:3733
  - Invariant #12 English text currently: endOffset requires `frequency > 1` and `period` present.
- fhir-fork/source/datatypes/timing.xml:3735
  - Invariant #12 FHIRPath currently: `endOffset.exists() implies (frequency > 1 and period.exists())`.
- fhir-fork/source/datatypes.html:1691
  - Offset explanation paragraph; verify it aligns with "effective period" explanation from ticket resolution.
- fhir-fork/source/dosage-examples.html:1351
  - 28-day cycle example with `endOffset = 7 d`; verify narrative matches period-minus-offset interpretation.

## Execution Steps
1. Reconcile the ticket resolution text with current content:
   - Confirm period-required invariants are present for both `startOffset` and `endOffset`.
   - Confirm endOffset short text correction ("stop once") is present and typo-free.
2. Add or adjust notes text for "Periods with start or end offsets" if not yet explicitly represented in the Timing narrative/comment fields.
3. Ensure startOffset/endOffset comments point readers to the relevant notes section (or equivalent canonical explanatory location).
4. Review invariant display names/labels for consistency and reviewer clarity (including whether `endOffset1` should remain or be normalized).
5. Re-check dosage narrative examples so they reflect:
   - Frequency over full period when no offsets are present.
   - Frequency over effective period (`period - offsets`) when offsets are present.
6. Run focused consistency checks in source:
   - Search for stale wording that implies only frequency is required.
   - Confirm all modified files remain under `fhir-fork/source/`.
7. Validate rendered output with a publish build (`./gradlew publish`) and inspect generated datatypes/dosage pages for the updated wording.

## Validation Checklist
- [ ] Ticket intent mapped to concrete source lines in `timing.xml`, `datatypes.html`, and `dosage-examples.html`.
- [ ] `tim-11` and `tim-12` English and FHIRPath rows remain semantically aligned.
- [ ] `startOffset` and `endOffset` definitions explicitly support period-required repeat-cycle interpretation.
- [ ] Notes/guidance text for "Periods with start or end offsets" is present or equivalently represented and discoverable.
- [ ] End-offset wording uses the approved "stop once" meaning.
- [ ] Example narrative remains consistent with the effective-period interpretation.
- [ ] No non-source or unrelated files are modified.
- [ ] `./gradlew publish` succeeds and rendered pages reflect the final text.

## Risks and Assumptions
- Risk: Over-editing may duplicate or conflict with already-implemented wording now present in `timing.xml`.
- Risk: Changing invariant labels (for clarity) could affect references in downstream discussions or tooling.
- Risk: Narrative updates without synchronized example text can reintroduce ambiguity.
- Assumption: This ticket is near-complete in current branch, and remaining work is primarily consistency/traceability closure.
- Assumption: Timing guidance may be split between XML element comments and datatypes narrative, and both must align.
- Open questions:
  - Should the notes section title literally be "Periods with start or end offsets", or is equivalent prose acceptable?
  - Should invariant display name `endOffset1` be renamed for readability, or retained to avoid churn?
