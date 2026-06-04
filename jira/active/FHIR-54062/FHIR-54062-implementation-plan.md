# Implementation Plan: FHIR-54062

## Scope Summary
- Workgroup/source: Direct ticket scope from FHIR-54062
- Tickets in scope: FHIR-54062
- Primary fix pattern: Structural constraint rework plus explanatory wording alignment for Timing.repeat startOffset and endOffset

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-54062 | Rework startOffset/endOffset constraint | Resolved - change required | Datatypes, Timing section | Constraint logic + supporting narrative/examples | Existing tim-11/tim-12 only require frequency > 1 and do not enforce period/frequency/offset coherence for unambiguous schedules |

## Shared Implementation Approach
1. Locate Timing.repeat element definitions and invariant rows in fhir-fork/source/datatypes/timing.xml.
2. Rework tim-11 and tim-12 constraint text and expressions so startOffset/endOffset use is clearly bounded by repeat-cycle semantics.
3. Align Timing narrative and examples so they match revised invariants and intended interpretation.
4. Keep edits minimal, traceable, and limited to files under fhir-fork/source.

## Likely Edit Surface (Files and Lines)
- fhir-fork/source/datatypes/timing.xml:1181
  - Timing.repeat.startOffset element row; short/definition/comment may require clarification to match revised constraints.
- fhir-fork/source/datatypes/timing.xml:1206
  - Timing.repeat.endOffset element row; short/definition/comment may require clarification to match revised constraints.
- fhir-fork/source/datatypes/timing.xml:3723
  - tim-11 English text currently tied only to frequency > 1.
- fhir-fork/source/datatypes/timing.xml:3725
  - tim-11 FHIRPath currently startOffset.exists() implies (frequency > 1).
- fhir-fork/source/datatypes/timing.xml:3733
  - tim-12 English text currently tied only to frequency > 1.
- fhir-fork/source/datatypes/timing.xml:3735
  - tim-12 FHIRPath currently endOffset.exists() implies (frequency > 1).
- fhir-fork/source/datatypes.html:1667
  - Timing criteria table includes startOffset/endOffset examples that should remain coherent with new rules.
- fhir-fork/source/datatypes.html:1691
  - Explanatory paragraph describing offset vs startOffset/endOffset semantics.
- fhir-fork/source/dosage-examples.html:1351
  - End-offset dosage cycle example that may need minor wording adjustment for consistency with reworked constraints.

## Execution Steps
1. Confirm intended normative behavior from ticket context:
   - Ensure offsets are only allowed when frequency and period define an interpretable repeat cycle.
   - Decide whether constraints require period when startOffset or endOffset is present.
   - Decide whether additional integer-divisibility or boundary checks are desired versus narrative guidance.
2. Update tim-11 and tim-12 English statements in fhir-fork/source/datatypes/timing.xml to reflect the approved rule logic.
3. Update tim-11 and tim-12 FHIRPath expressions in fhir-fork/source/datatypes/timing.xml to match approved logic.
4. If invariant identifiers or names are adjusted, keep naming stable or explicitly justified to avoid downstream confusion.
5. Update Timing.repeat.startOffset and Timing.repeat.endOffset descriptive text in fhir-fork/source/datatypes/timing.xml to align with revised invariants.
6. Review Timing narrative in fhir-fork/source/datatypes.html around the criteria table and offset explanation paragraph; revise wording only where needed for consistency.
7. Review dosage cycle example in fhir-fork/source/dosage-examples.html for alignment with revised constraint semantics; adjust wording/example only if mismatch exists.
8. Run source-level consistency checks:
   - Search for stale frequency > 1-only wording tied to startOffset/endOffset rules.
   - Verify no unrelated datatypes or non-source files are modified.
9. Validate build output:
   - Run ./gradlew publish from fhir-fork.
   - Confirm generated Timing constraints and narrative in publish output reflect intended updates.

## Validation Checklist
- [ ] FHIR-54062 is mapped to concrete source files and line targets.
- [ ] Planned edits are confined to fhir-fork/source.
- [ ] tim-11 and tim-12 English and FHIRPath remain semantically aligned.
- [ ] Timing element definitions and narrative text are consistent with revised constraints.
- [ ] Example content remains valid under revised constraints (or is updated accordingly).
- [ ] No unrelated formatting/tooling/build-script changes are introduced.
- [ ] ./gradlew publish completes successfully.
- [ ] Published Timing pages reflect the approved constraint behavior.

## Risks and Assumptions
- Risk: Over-constraining offsets could invalidate existing legitimate schedules.
- Risk: Under-constraining offsets could preserve ambiguity the ticket intends to remove.
- Risk: Constraint changes may require synchronized updates in examples and explanatory prose to avoid mixed guidance.
- Assumption: Ticket intent is to increase semantic clarity for schedules using startOffset/endOffset, not just wording polish.
- Assumption: timing.xml remains authoritative for Timing invariant definitions rendered in published artifacts.
- Open questions:
  - Should both frequency and period be mandatory when either startOffset or endOffset is present?
  - Should offset-based schedules require evenly divisible active windows, or should non-divisible cases be allowed with guidance only?
  - Should constraints enforce lower/upper bounds on offsets relative to period, or remain descriptive in narrative text?
