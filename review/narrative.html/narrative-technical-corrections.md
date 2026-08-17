# Technical Corrections Review Report

## Metadata
- Review ID: batch-2026-08-17-narrative-technical
- Date: 2026-08-17
- Mode: page
- Target: fhir-repo/publish/narrative.html
- Status: ready

## Build Evidence
- Build check command: `./.github/skills/build-fhir/scripts/build-if-needed.sh --repo ./fhir-repo --mode check`
- Build check result: `BUILD_NEEDED: no`
- Build status used for review: current

## Inputs Used
- Source files:
  - fhir-repo/source/datatypes/narrative.xml
  - fhir-repo/source/narrative.html
- Output files:
  - fhir-repo/publish/narrative.html

## W3C Findings
### Section 7.2
- Section 11: spelling/word-choice findings are listed below; no separate citation or editorial-structure deviation was confirmed.
Section 7.2: None.
Section 7.3: None.
Section 13: None.
### Section 7.3
- None. No citation-format deviation was confirmed.
### Section 11
- Section 11: spelling/word-choice findings are listed below; no separate citation or editorial-structure deviation was confirmed.
Section 7.2: None.
Section 7.3: None.
Section 13: None.
### Section 13
- None beyond spelling findings recorded below.

## Link Target Validation Findings
- - Link ID: LNK-001
  - Source location: fhir-repo/publish/narrative.html
  - Link text: not reliably recoverable from href-only scan
  - Href: `Patient/example`
  - Target type: internal-file
  - Validation status: missing
  - Evidence: neither page-relative nor publish-root target exists.

## Link Description Correspondence Findings
- None. No confirmed mismatch between link text and target descriptor.

## Spelling Findings
- Finding ID: SP-001: `managable (2 occurrences)`; verify generated/source wording.

## Non-W3C Technical Corrections
- None beyond the link and spelling findings above.

## Patch-Ready Change Set
### CHG-001
- Target file: fhir-repo/source/datatypes/narrative.xml
- Anchor: link with href `Patient/example`
- Edit type: replace
- Current text (exact): `Patient/example`
- Proposed text (exact): verify the intended existing local target before editing; no automatic replacement is safe.
- Pre-context: rendered anchor containing the href
- Post-context: surrounding link text
- Occurrence rule: unique
- Rationale: target does not exist in the local publish tree.
- Validation check: rerun local link-target validation.

### CHG-010
- Target file: shared source context that produces the rendered extension-governance prose
- Anchor: extension governance paragraph
- Edit type: replace
- Current text (exact): `managable`
- Proposed text (exact): `manageable`
- Pre-context: `safe and`
- Post-context: `, there is a strict set of governance`
- Occurrence rule: all occurrences in the reviewed page's source context
- Rationale: correct spelling without changing meaning.
- Validation check: rebuild/publish and confirm zero `managable` occurrences.

## Apply Sequence
1. Apply only confirmed source-context changes after review of the exact source anchor.
2. Rebuild/publish and rerun link, spelling, and W3C checks.

## Blocking Issues
- None.
