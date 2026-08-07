# Implementation Plan: FHIR-46453

## Scope Summary
- Workgroup/source: FHIR Infrastructure (single ticket, no rollup file supplied)
- Tickets in scope: FHIR-46453
- Primary fix pattern: Technical correction to a normative-vs-tooling gap in the `dateTime` primitive type regex, which currently validates dateTime values that lack a required timezone offset (e.g. `2024-07-23T12:27:16.321661`), contrary to the prose rule "If hours and minutes are specified, a timezone offset SHALL be populated." Reporter notes this is a regression of a defect previously fixed between DSTU1/DSTU2 (FHIR-8889).

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-46453 | dateTime RegEx allows to specify a date & time without timezone | Resolved - change required | Datatypes (`source/datatypes/primitives.xml`, `dateTime` row) | Correction (regex defect) | **Corrected finding**: the authoritative `dateTime` regex is stored in `fhir-fork/source/datatypes/primitives.xml` (an Excel-XML spreadsheet), not only as a `[%regex dateTime%]` narrative placeholder in `source/datatypes.html`. The defect was fixable entirely within `fhir-fork/source/`. |

## Shared Implementation Approach
1. Locate files under `fhir-fork/source/`.
2. Apply edits using consistent wording/style rules.
3. Keep changes minimal and traceable to ticket intent.

(Not a repetitive/batch ticket — single-ticket plan.)

## Investigation Findings (edit-surface search)

- Initial search of `fhir-fork/source/` for `valueRegex`, `regex`, and `StructureDefinition/regex` extension usage tied to the `dateTime` primitive type did not find a per-primitive-type StructureDefinition source file, and `source/datatypes.html` only contains a `[%regex dateTime%]` build-time placeholder (line 184) — this initially looked like an external-tooling-only defect.
- **Follow-up search found the actual source of truth**: [source/datatypes/primitives.xml](fhir-fork/source/datatypes/primitives.xml) is an Excel-XML spreadsheet that defines every primitive type's regex, consumed by kindling to populate the `[%regex <type>%]` placeholders. The `dateTime` row (originally line 198) contains the literal regex used for validation and generated schemas.
- **Root cause confirmed**: comparing the `dateTime` regex to the structurally-identical, correctly-required `instant` regex (line 155) showed the `dateTime` timezone group had two extra `?` quantifiers:
  - Buggy: `(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00)?)?`
  - Correct (matches `instant`): `(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))`
  - This made the entire timezone offset optional even when a time component (`Thh:mm:ss`) was present, directly contradicting the adjacent prose in `source/datatypes.html` line 175 ("If hours and minutes are specified, a timezone offset SHALL be populated") and reproducing the exact reported defect (`2024-07-23T12:27:16.321661` incorrectly validated).
- Confirmed in [source/datatypes.html](fhir-fork/source/datatypes.html):
  - Line 175: `dateTime` narrative row, which already states the correct normative rule (no change needed here).
  - Lines 414–418: existing "Issues with the specified regexes" note block; left unchanged since the regex itself is now corrected rather than merely caveated.
- Searched `fhir-fork/tests/` for any existing regex regression-test convention (found an analogous pattern elsewhere: `source/terminologycapabilities/invariant-tests/*.pass.xml` / `*.fail.xml`). No equivalent fixture set exists for primitive-type regex validation in this repo, and `fhir-fork/tests/` is outside the `fhir-fork/source/` edit boundary this repo enforces — regression-test creation remains a follow-up item (see Out-of-Scope section).

## Execution Steps

1. **Regex correction (implemented)**: In [source/datatypes/primitives.xml](fhir-fork/source/datatypes/primitives.xml), corrected the `dateTime` row's RegEx cell by removing the two extraneous `?` quantifiers on the timezone group, changing `(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00)?)?` to `(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00))`, matching the already-correct `instant` regex's structure.
2. **Behavioral verification (done)**: Ran a Python regex harness against every clause of the narrative description in `source/datatypes.html` (YYYY/YYYY-MM/YYYY-MM-DD forms, timezone-required-with-time, seconds-required, milliseconds-optional, `24:00` disallowed, leap seconds allowed, `+zz:zz` range up to `14:00`). All cases passed, including the exact reported defect string `2024-07-23T12:27:16.321661` (now correctly rejected).
3. **No narrative wording change needed**: `source/datatypes.html` line 175 already states the timezone rule correctly; the existing "Issues with the specified regexes" disclaimer (lines 414–418) remains accurate as a general regex caveat and does not need a ticket-specific addition since the underlying defect is now fixed.
4. **Full-build validation**: recommended before final commit — run `./gradlew publish` (full generate, not `-nogen`) in `fhir-fork/` to confirm the corrected regex round-trips through schema/tooling generation without introducing new validation failures.

## Follow-up Item (outside this ticket's immediate source fix)

- **Regression tests on the regexes** (requested in the ticket's Resolution Description): no in-repo fixture location exists for primitive-type regex regression tests in `fhir-fork/tests/` (outside the `fhir-fork/source/` edit boundary this repo enforces); the closest precedent (`invariant-tests/*.pass.xml`/`*.fail.xml`) is a different mechanism (FHIRPath invariants, not primitive regex). Recommend tracking regression-test creation as a separate follow-up in the `fhir-test-cases` HL7 repository or the kindling/validator test suite, referencing this ticket and the historical regression note (FHIR-8889), so a similar drift doesn't recur silently.

## Validation Checklist
- [x] Ticket mapped to the actual edit surface (`source/datatypes/primitives.xml`, `dateTime` row).
- [x] Implemented edit stays within `fhir-fork/source/`.
- [x] No unrelated formatting/tooling changes.
- [x] Corrected regex verified against every clause of the narrative description in `source/datatypes.html`.
- [x] Plan is review-ready and references ticket intent (FHIR-46453) and the regression history (FHIR-8889).
- [ ] Full `fhir-fork` build run to confirm no downstream generation/validation regressions (recommended before final commit).
- [ ] Regression-test follow-up tracked (outside this repo's `fhir-fork/source/` scope).

## Risks and Assumptions
- **Risk**: The regex is authored inside an Excel-XML spreadsheet (`primitives.xml`); future manual edits to this file carry a higher transcription-error risk than plain text, so the exact paren-balance was verified programmatically (Python `re` harness) rather than by inspection alone.
- **Risk**: This corrected `dateTime` regex is stricter than before; any existing example content elsewhere in `fhir-fork/source/` that used a timezone-less `dateTime` value (matching the old, buggy behavior) could newly fail validation on the next full build. A full `./gradlew publish` run is recommended to surface any such cases before this change is considered fully verified.
- **Assumption**: The existing prose at `source/datatypes.html` line 175 already correctly states the timezone requirement; no wording change was needed there.
- **Resolved question**: The earlier open question about escalating to kindling/validator maintainers is no longer applicable for the regex fix itself — it was fixed directly in `fhir-fork/source/`. Only the regression-test creation remains a legitimate follow-up outside this repo's boundary.
