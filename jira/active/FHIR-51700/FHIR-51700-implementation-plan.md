# Implementation Plan: FHIR-51700

## Scope Summary
- Workgroup/source: Direct ticket scope from `FHIR-51700` markdown (`jira/active/FHIR-51700/FHIR-51700.md`)
- Tickets in scope: FHIR-51700
- Primary fix pattern: Wording/typography correction (`H L7` -> `HL7`) in specification source metadata titles

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-51700 | Correct "H L7" spelling | Resolved - change required (Persuasive) | `fhir-fork/source/**/implementationguide-*-core.xml` entries where title contains `H L7` (32 current matches) | Typographical wording correction | Normalize only the spaced `H L7` token; keep all other title wording unchanged |

## Shared Implementation Approach
1. Locate files under `fhir-fork/source/` with exact token `H L7`.
2. Apply minimal text edits replacing `H L7` with `HL7` in affected title values.
3. Keep changes traceable and constrained to ticket intent only (no structural/formatting/tooling edits).

## Execution Steps
1. Baseline discovery
   - Run `rg -n "H L7" fhir-fork/source` to produce the authoritative edit list.
   - Capture affected files (currently 32 `implementationguide-*-core.xml` files, e.g., `source/resource/implementationguide-Resource-core.xml`, `source/patient/implementationguide-Patient-core.xml`, `source/organization/implementationguide-Organization-core.xml`).
2. Apply scoped text edits
   - For each discovered file, update only the title string segment `H L7` to `HL7`.
   - Preserve existing XML structure, spacing outside the corrected token, and resource-specific wording.
3. Cross-file consistency pass
   - Re-run `rg -n "H L7" fhir-fork/source` and confirm zero remaining matches in source.
   - Optionally run `rg -n "HL7  Extensions|HL7 Extensions" fhir-fork/source/*/implementationguide-*-core.xml` to spot-check normalization consistency.
4. Ticket traceability check
   - Ensure commit scope references FHIR-51700 and includes only intended source files plus Jira documentation artifacts.

## Validation Checklist
- [ ] FHIR-51700 is mapped to at least one concrete edit surface under `fhir-fork/source/`
- [ ] Planned edits are restricted to `fhir-fork/source/`
- [ ] No unrelated formatting, tooling, or build changes are introduced
- [ ] All `H L7` occurrences in in-scope files are corrected to `HL7`
- [ ] Plan remains review-ready and aligned with ticket intent

## Risks and Assumptions
- Risk: Additional `H L7` instances may exist outside the current `implementationguide-*-core.xml` set if upstream content changes before implementation.
- Assumption: Ticket intent is global typo correction for spaced `H L7` in specification-facing text, not broader title wording normalization.
- Open questions: Should correction be limited strictly to existing matched files, or should implementation include a broader search across non-source/generated artifacts for future-proofing?
