# Technical Corrections Review Report

## Metadata
- Review ID: exchanging-technical-2026-08-14
- Date: 2026-08-14
- Mode: page
- Target: fhir-repo/publish/exchanging.html
- Status: ready

## Build Evidence
- Build check command: `./.github/skills/build-fhir/scripts/build-if-needed.sh --repo ./fhir-repo --mode check`
- Build check result: BUILD_NEEDED: no
- Build status used for review: current

## Inputs Used
- Source files:
  - fhir-repo/source/exchanging.xml (requested, not present)
- Output files:
  - fhir-repo/publish/exchanging.html

## W3C Findings
### Section 7.2
- None.

### Section 7.3
- Finding W3C-7.3-001, severity warning, confidence high: repeated body-prose links use bare `here`, which does not identify the destination independently. Replace each with descriptive text naming its destination.

### Section 11
- Finding W3C-11-001, severity warning, confidence high: duplicated sentence-final punctuation and unnecessary `etc.` in the opening guidance paragraph. Replace `..., etc..` with a complete sentence ending in one period.
- Finding W3C-11-002, severity warning, confidence high: missing comma and weak parallel structure in the `As these approaches become...` sentence. Rewrite with parallel `as` clauses and commas.
- Finding W3C-11-003, severity warning, confidence high: repeated wording and awkward construction in the first `Implementation guides SHOULD...` sentence. Simplify while preserving meaning.
- Finding W3C-11-004, severity warning, confidence high: sentence-initial `i.e.,` and passive wording in the pushed-data statement. Rewrite as `That is, receiving pushed data is acceptable, but pulling data is not.`
- Finding W3C-11-005, severity warning, confidence high: redundant sentence and sentence-initial `i.e.,` in the messaging/operations comparison. Combine the sentences.
- Finding W3C-11-006, severity warning, confidence high: sentence-initial `e.g.,` in running prose. Rewrite as `for example, a MedicationAdministration resource...`.

### Section 13
- None beyond the spelling findings listed below.

## Link Target Validation Findings
- Finding LNK-001, severity warning, confidence high: `http.html#cupdate` has a missing fragment. `fhir-repo/publish/http.html` contains the target section at `#cond-update`. Replace `http.html#cupdate` with `http.html#cond-update`.

## Link Description Alignment Findings
- None. `conditional update` aligns with the target heading `Conditional Update`; only the fragment identifier is defective.

## Spelling Findings
- Finding SPELL-001, severity warning, confidence high: `decsion` should be `decision`.
- Finding SPELL-002, severity warning, confidence high: `granualarity` should be `granularity`.
- Finding SPELL-003, severity warning, confidence high: `mininmum` should be `minimum`.

## Other Technical Corrections
- None.

## Patch-Ready Change Set
### CHG-001
- Target file: fhir-repo/source/exchanging.html (source XML requested but unavailable)
- Anchor: persistence paragraph
- Edit type: replace
- Current text: `http.html#cupdate`
- Proposed text: `http.html#cond-update`
- Rationale: align the fragment with the existing Conditional Update anchor.
- Validation check: rerun local link validation.

### CHG-002
- Target file: fhir-repo/source/exchanging.html (source XML requested but unavailable)
- Anchor: direct-connection decision discussion
- Edit type: replace
- Current text: `decsion`
- Proposed text: `decision`
- Rationale: correct spelling.

### CHG-003
- Target file: fhir-repo/source/exchanging.html (source XML requested but unavailable)
- Anchor: invalid-code and missing-element scenarios
- Edit type: replace
- Current text: `granualarity`; `mininmum`
- Proposed text: `granularity`; `minimum`
- Rationale: correct spelling.

### CHG-004
- Target file: fhir-repo/source/exchanging.html (source XML requested but unavailable)
- Anchor: body prose links and opening guidance paragraphs
- Edit type: replace
- Current text: bare `here` labels and the W3C 11 wording issues above
- Proposed text: descriptive link labels and the grammar/style rewrites listed above
- Rationale: improve accessibility, grammar, and editorial consistency.

## Apply Sequence
1. CHG-001
2. CHG-002
3. CHG-003
4. CHG-004

## Blocking Issues
- None for the page review. The requested source context `fhir-repo/source/exchanging.xml` is absent, so patch application must first identify the authoritative source file.

## Finding Counts
- error: 0
- warning: 11
- info: 0
