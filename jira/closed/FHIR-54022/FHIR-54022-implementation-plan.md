# Implementation Plan: FHIR-54022

## Scope Summary
- Workgroup/source: currentTickets.md batch planning run (unimplemented tickets only).
- Tickets in scope: FHIR-54022.
- Primary fix pattern: terminology normalization in prose/glossary content (preferred term: "payer").

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-54022 | Standardize spelling of "payer" - FHIRI | Resolved - change required | Primary: `fhir-fork/source/financial-module.html`; Secondary: `fhir-fork/source/help.html`; Secondary: `fhir-fork/source/overview-patient.html` | wording/terminology correction | Replace prose/glossary "payor" with "payer". Keep formal identifiers named `payor` unchanged (see term policy). |

## Shared Implementation Approach
1. Apply targeted replacements only in the mapped files under `fhir-fork/source/`.
2. Normalize human-readable terminology to "payer" in narrative, glossary terms, aliases, and descriptions.
3. Preserve formal artifact names that are intentionally `payor` (resource element names, ids, references, and machine-facing tokens).
4. Keep diffs minimal and avoid unrelated formatting/tooling/build changes.

## Preferred Term Policy (Payer vs Payor)
1. Preferred term for this ticket: use "payer" (or "Payer" at sentence/title case) in human-readable specification prose.
2. In scope for replacement:
	- Narrative text in HTML pages.
	- Glossary term labels and definitions intended for readers.
	- Alias columns where synonym lists currently include "Payor".
3. Explicitly out of scope (must remain unchanged unless a different ticket mandates a rename):
	- Resource/data element names such as `<payor>`.
	- Internal ids/references such as `#payor` and `id value="payor"`.
	- Canonical machine-facing keys such as `Coverage.payor`.
	- Example system tokens like `payorid`.

## Execution Steps
1. Edit `fhir-fork/source/financial-module.html`:
	- Replace remaining prose/glossary uses of "Payor/payor" with "Payer/payer".
	- Update glossary rows that currently create payer/payor duplication so only payer-preferred terminology remains.
2. Edit `fhir-fork/source/help.html`:
	- Replace glossary/display occurrences such as "Payor", "Secondary Payor", and prose references to "a Payor" with payer forms.
3. Edit `fhir-fork/source/overview-patient.html`:
	- Replace "Payor data" with "Payer data" in patient-facing narrative.
4. Do not edit files whose `payor` usage is formal/machine-facing (examples, element names, ids, `fhir.ini` keys, generated artifacts).
5. Run validation commands and confirm expected outcomes.

## Validation Commands (Executable)
1. Confirm mapped files still contain payer terminology:
	- `rg -n "\\b[Pp]ayer\\b" fhir-fork/source/financial-module.html fhir-fork/source/help.html fhir-fork/source/overview-patient.html`
	- Expected: one or more matches in each mapped file.
2. Confirm mapped files no longer contain payor prose:
	- `rg -n "\\b[Pp]ayor\\b" fhir-fork/source/financial-module.html fhir-fork/source/help.html fhir-fork/source/overview-patient.html`
	- Expected: no matches.
3. Confirm formal `payor` identifiers still exist elsewhere and were intentionally not renamed:
	- `rg -n "<payor>|</payor>|#payor|Coverage\\.payor|id value=\"payor\"|payorid" fhir-fork/source`
	- Expected: matches remain in non-target formal/example contexts.
4. Confirm edit scope is constrained to planned files:
	- `git diff --name-only -- fhir-fork/source/financial-module.html fhir-fork/source/help.html fhir-fork/source/overview-patient.html`
	- Expected: only mapped files listed for this ticket during implementation.

## Validation Checklist
- [ ] Ticket mapped to concrete source files: `financial-module.html`, `help.html`, `overview-patient.html`
- [ ] Planned edits stay within `fhir-fork/source/`
- [ ] No unrelated formatting/tooling/build changes
- [ ] Preferred term policy applied: prose uses payer; formal identifiers named `payor` are preserved
- [ ] Validation commands are executable and have clear expected outcomes
- [ ] Plan is review-ready and implementation-specific

## Risks and Assumptions
- Risk: Some `payor` occurrences in generated SVG/derived artifacts may mirror source text and create apparent inconsistencies unless separately regenerated.
- Assumption: FHIR-54022 scope is prose/glossary normalization, not schema or element-name renaming.
- Open questions: If reviewers want generated diagram text updated in the same PR, should that be handled in this ticket or split as a follow-up generation/update task?
