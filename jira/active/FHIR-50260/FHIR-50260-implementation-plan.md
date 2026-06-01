# Implementation Plan: FHIR-50260

## Scope Summary
- Workgroup/source: FHIR Infrastructure ticket markdown (`jira/active/FHIR-50260/FHIR-50260.md`)
- Tickets in scope: FHIR-50260
- Primary fix pattern: Wording clarification for `SampledData.lowerLimit` and `SampledData.upperLimit` semantics (unscaled measured bounds)

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-50260 | clarify SampledData limits | Resolved - change required | Datatypes, section 2.24.0.11 (`datatypes.html#SampledData`) | Wording clarification | Resolution: Not Persuasive with Modification; clarify that limits are measured-value bounds (not scaled values) |

## Likely Edit Surface (Files and Lines)
| File | Likely line(s) | Why |
|---|---:|---|
| `fhir-fork/source/datatypes/sampleddata.xml` | ~952 | `SampledData.lowerLimit` row anchor |
| `fhir-fork/source/datatypes/sampleddata.xml` | ~965 | `lowerLimit` definition text cell |
| `fhir-fork/source/datatypes/sampleddata.xml` | ~977 | `SampledData.upperLimit` row anchor |
| `fhir-fork/source/datatypes/sampleddata.xml` | ~990 | `upperLimit` definition text cell |
| `fhir-fork/source/datatypes/sampleddata.xml` | ~842 | Datatype intro text mentioning lower/upper limits and visualization range |
| `fhir-fork/source/datatypes.html` | ~1319-1320 | `L`/`U` detection-limit narrative consistency check |

## Shared Implementation Approach
1. Use `fhir-fork/source/datatypes/sampleddata.xml` as the authoritative edit surface.
2. Keep wording aligned with measured/unscaled semantics and preserve `L`/`U` detection-limit behavior.
3. Minimize changes to only text required by ticket intent.

## Execution Steps
1. Confirm current baseline in `fhir-fork/source/datatypes/sampleddata.xml` at the lines listed above.
2. Compare baseline text to ticket intent:
- `lowerLimit`: "lowest possible measured value" and "not scaled".
- `upperLimit`: "highest possible measured value" and "not scaled".
3. Decision branch:
- If wording is missing or ambiguous, apply minimal text edits at the targeted definition cells (~965 and ~990).
- If wording already matches ticket intent, record as no-op for source edits and proceed with validation evidence only.
4. Run cross-check in `fhir-fork/source/datatypes.html` around lines ~1319-1320 to ensure no contradiction with `L`/`U` detection-limit narrative.
5. Verify scope discipline:
- No edits outside `fhir-fork/source/`.
- No formatting-only churn or unrelated terminology updates.
6. Optional verification pass (if source edits were applied): run project publication/build workflow and inspect generated SampledData output text.

## Validation Checklist
- [ ] Ticket FHIR-50260 mapped to concrete source targets with line references
- [ ] Planned edits constrained to `fhir-fork/source/`
- [ ] `lowerLimit` text explicitly states lowest possible measured value, not scaled
- [ ] `upperLimit` text explicitly states highest possible measured value, not scaled
- [ ] `L`/`U` detection-limit semantics remain intact
- [ ] No unrelated files or build/tooling scripts changed
- [ ] Plan is executable without reinterpretation and traceable to ticket intent

## Risks and Assumptions
- Risk: Existing text may already satisfy the requested clarification, leading to unnecessary churn if edited again.
- Risk: Broad narrative edits in `datatypes.html` could exceed ticket scope if not constrained.
- Assumption: `fhir-fork/source/datatypes/sampleddata.xml` is the normative source for detailed element definitions.
- Assumption: Ticket scope is clarification only, not redesign of `SampledData.dimensions` or additional examples.
- Open questions: None blocking. If reviewers request explicit examples, handle as a separate follow-up ticket or explicit scope extension.
