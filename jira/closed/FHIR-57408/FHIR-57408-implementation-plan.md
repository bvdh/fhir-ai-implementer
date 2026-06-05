# Implementation Plan: FHIR-57408

## Scope Summary
- Workgroup/source: Direct ticket scope from `FHIR-57408`
- Tickets in scope: `FHIR-57408`
- Primary fix pattern: Structural + wording update for SampledData timing rules (offsets/interval interplay)

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-57408 | Resolve SampledData.offsets running out behavior | Resolved - change required | Datatypes (SampledData) | Structural invariant adjustment + clarification text | Current rules force a strict offsets/data count and disallow offsets+interval coexistence, conflicting with proposed fallback behavior |

## Shared Implementation Approach
1. Locate SampledData definition and invariant rows in `fhir-fork/source/datatypes/sampleddata.xml`.
2. Update constraints to support the agreed fallback semantics when offsets do not cover all data points.
3. Align element descriptions/comments with the updated constraint behavior.
4. Keep edits minimal and localized to SampledData rows only.

## Likely Edit Surface (Files and Lines)
- `fhir-fork/source/datatypes/sampleddata.xml:1065`
  - `SampledData.offsets` definition text; candidate location to clarify fallback interpretation for offsets.
- `fhir-fork/source/datatypes/sampleddata.xml:1067`
  - Constraint note currently stating data points must equal offsets × dimensions; expected to be relaxed/rewritten for partial-offset scenarios.
- `fhir-fork/source/datatypes/sampleddata.xml:877`
  - `SampledData.interval` short/definition text; candidate location to define behavior when offsets are exhausted.
- `fhir-fork/source/datatypes/sampleddata.xml:3428`
  - Invariant English currently says interval and offsets are mutually exclusive; likely needs revision.
- `fhir-fork/source/datatypes/sampleddata.xml:3429`
  - FHIRPath expression enforcing XOR on interval/offsets; likely needs revision to permit intended coexistence.
- `fhir-fork/source/datatypes/sampleddata.xml:3430`
  - XPath expression equivalent of the XOR rule; must stay semantically aligned with updated FHIRPath.

## Execution Steps
1. Confirm intended normative behavior from ticket wording:
   - Option A: Require offsets to fully cover data points.
   - Option B (ticket-proposed fallback): Permit offsets to run out and apply interval for remaining samples.
2. Update `SampledData.offsets` rule text at `sampleddata.xml:1067` to match chosen behavior.
3. Update `SampledData.interval` narrative at `sampleddata.xml:877` and/or offsets narrative at `sampleddata.xml:1065` to explicitly describe how interval applies when offsets are exhausted (if Option B).
4. Revise invariant prose at `sampleddata.xml:3428` so it no longer contradicts chosen behavior.
5. Revise paired invariant expressions at `sampleddata.xml:3429` and `sampleddata.xml:3430` to match the same logic in both FHIRPath and XPath.
6. Run targeted consistency checks in source:
   - Search for stale wording (e.g., "either an interval and offsets but not both", strict offsets equality wording).
   - Verify no unrelated datatypes were altered.
7. Build/publish validation pass after edits to ensure rendered constraints and definitions are consistent:
   - `./gradlew publish`
8. Verify generated SampledData pages in `publish/` reflect the updated invariant and narrative language.

## Validation Checklist
- [ ] Ticket `FHIR-57408` is mapped to concrete SampledData edit locations.
- [ ] Planned edits remain within `fhir-fork/source/`.
- [ ] Invariant English, FHIRPath, and XPath remain semantically consistent.
- [ ] Offsets/data-count rule aligns with approved ticket intent.
- [ ] Interval fallback behavior is explicitly documented (if chosen).
- [ ] No unrelated formatting/tooling/build-script changes.
- [ ] `./gradlew publish` completes successfully.
- [ ] Rendered SampledData documentation in `publish/` reflects the intended change.

## Risks and Assumptions
- Risk: Changing invariant semantics could unintentionally alter validator behavior for existing SampledData instances.
- Risk: If only narrative text is changed without invariant updates (or vice versa), published guidance and computable constraints may diverge.
- Assumption: Ticket intent favors allowing interval-driven continuation when offsets are present but insufficient.
- Assumption: `sampleddata.xml` remains the single authoritative source for these generated datatypes sections.
- Open questions:
  - Should offsets be allowed to be shorter than data in all cases, or only when interval is present?
  - If offsets and interval both exist, does interval apply immediately after final offset, or from logical start for any sample lacking explicit offset?
  - Should the previous strict equality rule be replaced with a lower-bound rule or removed entirely?
