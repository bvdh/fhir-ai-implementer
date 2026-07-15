# Implementation Change Log: FHIR-46453

## Summary

Fixed the `dateTime` primitive type regex in `fhir-fork/source/datatypes/primitives.xml` so it no longer validates a `dateTime` value that has an hours/minutes time component but no timezone offset, matching the normative prose rule already documented in `source/datatypes.html`: "If hours and minutes are specified, a timezone offset SHALL be populated."

## Root Cause

The `dateTime` regex's timezone group had two extraneous `?` quantifiers compared to the structurally-identical, correctly-required `instant` regex in the same file, making the entire timezone offset optional even when a time component was present.

## Change

- File: `fhir-fork/source/datatypes/primitives.xml`
- Location: `dateTime` row, RegEx column (Imports worksheet, row 11; originally line 198)
- Before:
  ```
  ([0-9]([0-9]([0-9][1-9]|[1-9]0)|[1-9]00)|[1-9]000)(-(0[1-9]|1[0-2])(-(0[1-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:([0-5][0-9]|60)(\.[0-9]{1,9})?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00)?)?)?)?)?
  ```
- After:
  ```
  ([0-9]([0-9]([0-9][1-9]|[1-9]0)|[1-9]00)|[1-9]000)(-(0[1-9]|1[0-2])(-(0[1-9]|[1-2][0-9]|3[0-1])(T([01][0-9]|2[0-3]):[0-5][0-9]:([0-5][0-9]|60)(\.[0-9]{1,9})?(Z|(\+|-)((0[0-9]|1[0-3]):[0-5][0-9]|14:00)))?)?)?
  ```
- No other files were modified. `source/datatypes.html` (narrative prose and disclaimer notes) was left unchanged — it already correctly stated the timezone rule.

## Verification

Ran a Python `re` harness (`^` / `$` anchored) against the corrected pattern, covering every clause of the narrative description in `source/datatypes.html`:

| Case | Input | Expected | Result |
|---|---|---|---|
| Year only | `2018` | valid | pass |
| Year-month | `1973-06` | valid | pass |
| Full date | `1905-08-23` | valid | pass |
| Full timestamp, offset | `2015-02-07T13:28:17-05:00` | valid | pass |
| Full timestamp, Z + ms | `2017-01-01T00:00:00.000Z` | valid | pass |
| **Original defect case** | `2024-07-23T12:27:16.321661` | **invalid** | **now correctly rejected** |
| Time, no tz, no ms | `2024-07-23T12:27:16` | invalid | rejected |
| Time, Z, no ms | `2024-07-23T12:27:16Z` | valid | pass |
| Seconds omitted | `2024-07-23T12:27Z` | invalid | rejected |
| Milliseconds (1 digit) | `2024-07-23T12:27:16.1Z` | valid | pass |
| Milliseconds (9 digits) | `2024-07-23T12:27:16.123456789Z` | valid | pass |
| `24:00` disallowed | `2024-07-23T24:00:00Z` | invalid | rejected |
| `23:59:59` boundary | `2024-07-23T23:59:59Z` | valid | pass |
| Leap second | `2024-06-30T23:59:60Z` | valid | pass |
| Invalid second (61) | `2024-06-30T23:59:61Z` | invalid | rejected |
| Max positive offset | `2024-07-23T12:27:16+14:00` | valid | pass |
| Max negative offset | `2024-07-23T12:27:16-14:00` | valid | pass |
| Offset hour > 14 | `2024-07-23T12:27:16+15:00` | invalid | rejected |
| Offset `13:59` | `2024-07-23T12:27:16+13:59` | valid | pass |
| Offset `00:00` | `2024-07-23T12:27:16+00:00` | valid | pass |

All cases passed as expected.

## Not Implemented (Follow-up)

- **Regression test fixtures** for primitive-type regexes: no existing convention in `fhir-fork/tests/` for this, and that directory is outside the `fhir-fork/source/` edit boundary enforced for this repo. Recommend tracking as a separate follow-up in the `fhir-test-cases` HL7 repository or the kindling/validator test suite, referencing this ticket and the historical regression note (FHIR-8889).
- **Full repository build**: recommended (`./gradlew publish`, full generate) before this change is considered fully verified end-to-end, to confirm no other `fhir-fork/source/` example content relied on the previous (incorrect) permissive behavior.
