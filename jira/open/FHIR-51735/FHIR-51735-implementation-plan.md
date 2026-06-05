# Implementation Plan: FHIR-51735

## Scope Summary
- Workgroup/source: FHIR Infrastructure; ticket file `jira/active/FHIR-51735/FHIR-51735.md`
- Tickets in scope: FHIR-51735
- Primary fix pattern: Regex technical correction (remove unintended trailing `}` in decimal regex)

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-51735 | Extra '}' in decimal regex | Resolved - change required | Datatypes (decimal primitive) | Regex correction | Keep edit minimal and constrained to decimal regex definition source |

## Likely Edit Surface (Files and Line References)
- `fhir-fork/source/datatypes/primitives.xml:134`
  - Decimal primitive regex definition cell; expected primary edit location.
- `fhir-fork/source/datatypes.html:197`
  - `[%regex decimal%]` rendering location; verification surface only (edit only if source wiring issue is discovered).

## Shared Implementation Approach
1. Locate decimal regex source definition under `fhir-fork/source/datatypes/primitives.xml`.
2. Remove only the extra closing brace from the decimal regex while preserving the intended numeric/exponent constraints.
3. Confirm downstream rendered documentation still references the same regex token pattern without introducing unrelated content changes.

## Execution Steps
1. Open `fhir-fork/source/datatypes/primitives.xml` and navigate to the decimal row near line 134.
2. Compare the current decimal regex against the expected pattern and remove the superfluous trailing `}` only.
3. Check the new regex for compliance against the decimal definition: "ational numbers that have a decimal representation. Decimals in FHIR cannot have more than 18 digits and a decimal point. See below about the precision of the number"
4. Re-scan `fhir-fork/source/datatypes/primitives.xml` for decimal regex duplicates to ensure consistency.
5. Check `fhir-fork/source/datatypes.html` near line 197 to confirm decimal still renders via `[%regex decimal%]` placeholder.
6. Run a focused diff review to verify only ticket-related source changes under `fhir-fork/source/` are present.

## Validation Checklist
- [ ] FHIR-51735 maps to at least one concrete source edit location
- [ ] Planned edits remain within `fhir-fork/source/`
- [ ] Decimal regex no longer has the extra `}` and remains syntactically valid
- [ ] No unrelated formatting/tooling/build changes are introduced
- [ ] `datatypes.html` decimal regex placeholder remains correctly wired
- [ ] Diff is traceable to ticket intent: "Extra '}' in decimal regex"

## Risks and Assumptions
- Risk: The current branch may already contain a partially corrected regex; re-editing could accidentally alter validated constraints.
- Assumption: The authoritative regex source is `fhir-fork/source/datatypes/primitives.xml`, and `datatypes.html` is token-driven output text.
- Open questions: If the extra `}` is no longer present in source, should implementation be treated as already satisfied and documented as no-op for this branch?
