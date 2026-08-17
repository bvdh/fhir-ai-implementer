# Technical Corrections Review Report

## Metadata
- Review ID: exchanging-polling-technical-2026-08-14
- Date: 2026-08-14
- Mode: page
- Target: fhir-repo/publish/exchanging-polling.html
- Status: ready

## Build Evidence
- Build check command: `./.github/skills/build-fhir/scripts/build-if-needed.sh --repo ./fhir-repo --mode check`
- Build check result: `BUILD_NEEDED: no`
- Build status used for review: current
- Additional evidence: No rebuild was performed.

## Inputs Used
- Source files:
  - fhir-repo/source/exchanging-polling.html
  - The requested `fhir-repo/source/exchanging-polling.xml` does not exist; the matching source context is the HTML source file above.
- Output files:
  - fhir-repo/publish/exchanging-polling.html

## W3C Findings
### Section 7.2
- None.
### Section 7.3
- None.
### Section 11
- Finding ID: W3C-11-001; Severity: warning; Confidence: high; Location: fhir-repo/source/exchanging-polling.html, opening paragraph
- Current text: `The queries occur at period intervals of an agreed frequency.`
- Proposed text: `The queries occur at intervals of an agreed frequency.`
- Rationale: `period intervals` is awkward and redundant.

- Finding ID: W3C-11-002; Severity: warning; Confidence: high; Location: fhir-repo/source/exchanging-polling.html, introductory paragraph
- Current text: `There are two principle ways to poll for data -`
- Proposed text: `There are two principal ways to poll for data -`
- Rationale: `principal` is the adjective meaning main or primary.

- Finding ID: W3C-11-003; Severity: warning; Confidence: high; Location: fhir-repo/source/exchanging-polling.html, second introductory paragraph
- Current text: `Guidance on whether to use polling or subscription can be found <a href="exchanging.html#subscription">here</a>`
- Proposed text: `Guidance on whether to use polling or subscription can be found <a href="exchanging.html#subscription">in the subscription guidance</a>.`
- Rationale: Add terminal punctuation and descriptive link text.

- Finding ID: W3C-11-004; Severity: error; Confidence: high; Location: fhir-repo/source/exchanging-polling.html, polling across records paragraph
- Current text: `However, any search mechanism that returns existing could potentially be used.`
- Proposed text: `However, any search mechanism that returns existing records could potentially be used.`
- Rationale: The sentence omits the object being returned.
### Section 13
- None. No spelling issues were found under the reviewed W3C section 13 terms.

## Link Target Validation Findings
- Link ID: LNK-001; Severity: warning; Location: fhir-repo/publish/exchanging-polling.html:222; Link text: `Compare to R4`; Target type: external-http; Validation status: unreachable; Evidence: external diff endpoint returned HTTP 500.
- Link ID: LNK-002; Severity: warning; Location: fhir-repo/publish/exchanging-polling.html:223; Link text: `Compare to R5`; Target type: external-http; Validation status: unreachable; Evidence: external diff endpoint returned HTTP 500.
- Link ID: LNK-003; Severity: warning; Location: fhir-repo/publish/exchanging-polling.html:224; Link text: `Compare to Last Ballot`; Target type: external-http; Validation status: unreachable; Evidence: external diff endpoint returned HTTP 500.
- Link ID: LNK-004; Severity: info; Location: fhir-repo/publish/exchanging-polling.html:226; Link text: `Propose a change`; Target type: external-http; Validation status: indeterminate; Evidence: Jira endpoint returned HTTP 403 Forbidden.
- All internal relative links and fragments were verified successfully.

## Link Description Correspondence Findings
- Finding ID: LNK-DESC-001; Severity: info; Confidence: medium; Location: fhir-repo/publish/exchanging-polling.html:168; Link text: `here`; Target descriptor: `Subscription capability?`; Result: ambiguous; Rationale: Contextually appropriate, but non-descriptive link text.
- Finding ID: LNK-DESC-002; Severity: info; Confidence: medium; Location: fhir-repo/publish/exchanging-polling.html:189; Link text: `here`; Target descriptor: `REST searchable?`; Result: ambiguous; Rationale: Relevant target, but non-descriptive link text.
- Other reviewed link text corresponded to target headings or concepts.

## Spelling Findings
- Finding ID: SP-001; Severity: warning; Confidence: high; Location: fhir-repo/source/exchanging-polling.html, polling-frequency paragraph; Evidence: `period intervals`; Proposed correction: `periodic intervals`; Rationale: `periodic` is the required adjective.
- Finding ID: SP-002; Severity: warning; Confidence: high; Location: fhir-repo/source/exchanging-polling.html, introductory paragraph; Evidence: `principle ways`; Proposed correction: `principal ways`; Rationale: `principal` means main or primary.

## Other Technical Corrections
- None found beyond the W3C, link validation, link description, and spelling findings above.

## Patch-Ready Changes
### CHG-001
- Target file: fhir-repo/source/exchanging-polling.html
- Anchor: Opening polling-frequency paragraph
- Edit type: replace
- Current text: `The queries occur at period intervals of an agreed frequency.`
- Proposed text: `The queries occur at intervals of an agreed frequency.`
- Occurrence rule: unique
- Rationale: Remove redundant wording.
- Validation check: Rebuild and inspect the rendered paragraph.
### CHG-002
- Target file: fhir-repo/source/exchanging-polling.html
- Anchor: Introductory paragraph
- Edit type: replace
- Current text: `There are two principle ways to poll for data -`
- Proposed text: `There are two principal ways to poll for data -`
- Occurrence rule: unique
- Rationale: Correct the confused word form.
- Validation check: Rebuild and confirm both polling approaches remain listed.
### CHG-003
- Target file: fhir-repo/source/exchanging-polling.html
- Anchor: Second introductory paragraph
- Edit type: replace
- Current text: `Guidance on whether to use polling or subscription can be found <a href="exchanging.html#subscription">here</a>`
- Proposed text: `Guidance on whether to use polling or subscription can be found <a href="exchanging.html#subscription">in the subscription guidance</a>.`
- Occurrence rule: unique
- Rationale: Add punctuation and descriptive link text.
- Validation check: Validate the internal fragment and rendered link text.
### CHG-004
- Target file: fhir-repo/source/exchanging-polling.html
- Anchor: Polling across records paragraph
- Edit type: replace
- Current text: `However, any search mechanism that returns existing could potentially be used.`
- Proposed text: `However, any search mechanism that returns existing records could potentially be used.`
- Occurrence rule: unique
- Rationale: Restore grammatical completeness.
- Validation check: Rebuild and inspect the rendered sentence.

## Apply Sequence
1. CHG-001
2. CHG-002
3. CHG-003
4. CHG-004

## Blocking Issues
- None. External link responses are recorded as findings, not blockers.
