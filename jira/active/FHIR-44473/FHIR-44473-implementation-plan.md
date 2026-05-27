# Implementation Plan: FHIR-44473

## Scope Summary
- Workgroup/source: currentTickets.md batch planning run (unimplemented tickets only).
- Tickets in scope: FHIR-44473.
- Primary fix pattern: wording/typo correction.

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-44473 | Correct ExampleScenario spelling | Resolved - change required | `fhir-fork/source/exchanging.html` (primary), `fhir-fork/source/examplescenario/examplescenario-introduction.xml` and `fhir-fork/source/workflow-module.html` (secondary verification targets) | wording/typo correction | Resolution: Persuasive. Ticket specifics: focus on canonical resource-name spelling/casing (`ExampleScenario`) in narrative text/comments. |

## Shared Implementation Approach
1. Start with the primary target file and only expand to secondary targets if the same spelling issue appears there.
2. Apply minimal edits aligned with ticket intent and canonical resource naming (`ExampleScenario`).
3. Keep changes traceable and avoid unrelated formatting or tooling changes.

## Target File Mapping
- Primary target: `fhir-fork/source/exchanging.html`
- Secondary targets: `fhir-fork/source/examplescenario/examplescenario-introduction.xml`, `fhir-fork/source/workflow-module.html`
- Mapping rationale: ticket scope references spelling of the ExampleScenario resource name; these files are the direct narrative touchpoints where that term appears in workflow/spec prose and comments.

## Execution Steps
1. Verify mapped targets exist before editing:
	- `test -f fhir-fork/source/exchanging.html`
	- `test -f fhir-fork/source/examplescenario/examplescenario-introduction.xml`
	- `test -f fhir-fork/source/workflow-module.html`
2. In the primary file, locate and correct non-canonical spellings/casing of the resource name while preserving sentence intent.
3. Review secondary targets for the same spelling pattern and apply changes only if matching issues are present.
4. Perform localized readback around each changed line to ensure grammar and resource-name usage remain correct.
5. Run targeted validation commands:
	- `rg -n "ExampleScenarios|Examplescenario|Example Scenerio|ExampleScenerio" fhir-fork/source/exchanging.html fhir-fork/source/examplescenario/examplescenario-introduction.xml fhir-fork/source/workflow-module.html`
	- `rg -n "ExampleScenario" fhir-fork/source/exchanging.html fhir-fork/source/examplescenario/examplescenario-introduction.xml fhir-fork/source/workflow-module.html`
	- `git -C fhir-fork diff -- source/exchanging.html source/examplescenario/examplescenario-introduction.xml source/workflow-module.html`

## Validation Checklist
- [ ] Primary target file (`fhir-fork/source/exchanging.html`) is explicitly mapped and exists
- [ ] Secondary verification targets are explicitly mapped and exist
- [ ] Planned edits stay within `fhir-fork/source/`
- [ ] No unrelated formatting/tooling/build changes
- [ ] Canonical resource spelling/casing (`ExampleScenario`) is used consistently after changes
- [ ] Validation searches show no remaining targeted misspelling variants in mapped files
- [ ] Plan is review-ready and implementation-specific

## Risks and Assumptions
- Risk: Secondary files may contain intentional non-resource phrasing (e.g., generic "example scenario") that should not be normalized to the resource name.
- Assumption: Ticket intent is to correct misspelled references to the FHIR resource name, not to rewrite generic prose.
- Open questions: If additional misspellings are found outside mapped files during targeted search, should they be included in this ticket or tracked separately?
