# Technical Corrections Review Report

## Metadata
- Date: 2026-08-13
- Mode: page
- Target input: security-labels.html
- Resolved output page: /home/nly98977/SwArchives/bvdh/fhir-ai-implementer/fhir-repo/publish/security-labels.html
- Status: READY

## Build Evidence
- Build check command: ./.github/skills/build-fhir/scripts/build-if-needed.sh --repo ./fhir-repo --mode check
- Build check result: BUILD_NEEDED: no

## Inputs Used
- Source files:
  - fhir-repo/source/security-labels.html
- Output files:
  - /home/nly98977/SwArchives/bvdh/fhir-ai-implementer/fhir-repo/publish/security-labels.html

## W3C Findings
### Section 7.2
- None.

### Section 7.3
- None.

### Section 11
- 13 findings: CHG-001 through CHG-013 in the patch-ready change set. They correct grammar, punctuation, capitalization, and sentence structure in `fhir-repo/source/security-labels.html`.

### Section 13
- None. No spelling issues were identified.

## Link Target Validation Findings
- No missing local targets were identified. Local relative files and same-page anchors resolved.
- Seven targets were indeterminate: three Jira links returned HTTP 403; three terminology fragments returned HTTP 200 but could not be verified from the retrieved representation; the ISO link returned HTTP 403. These are access/verification limitations, not confirmed broken links.

## Link Description Correspondence Findings
- Link ID: LNK-001
  - Source location: fhir-repo/source/security-labels.html, HCS table / Test Data row
  - Link text: `Purpose Of Use`
  - Target descriptor: `HTEST` / ActReason code
  - Correspondence result: mismatch
  - Confidence: high
  - Rationale: The surrounding row describes Test Data and the target is the ActReason HTEST code; `Purpose Of Use` does not describe that target.
  - Patch-ready edit: Change the first link text from `Purpose Of Use` to `ActReason` while retaining its existing href, or otherwise link it to the intended Purpose of Use target.

## Spelling Findings
- No spelling issues found.

## Non-W3C Technical Corrections
- Finding ID: R5-001
  - The HCS guidance says confidentiality is optional (`0..1`) but also says additional labels would always be associated with confidentiality. See the non-technical report for the proposed rewrite.

## Patch-Ready Change Set
### CHG-001
- Target file: fhir-repo/source/security-labels.html
- Anchor: Local agreements and implementation profiles
- Edit type: replace
- Current text (exact): `for the use security labels`
- Proposed text (exact): `for the use of security labels`
- Pre-context (exact): `Local agreements and implementation profiles`
- Post-context (exact): `would describe how the security labels connect`
- Occurrence rule: unique
- Rationale: Correct incomplete prepositional phrase.
- Validation check: Re-run the page review and inspect the rendered paragraph.

### CHG-002
- Target file: fhir-repo/source/security-labels.html
- Anchor: Local agreements and implementation profiles
- Edit type: replace
- Current text (exact): `use cases trading partners, and a wider array of security labels` and `much finer grained management`
- Proposed text (exact): `use cases for trading partners, and a wider array of security labels` and `much finer-grained management`
- Pre-context (exact): `This specification defines a basic set of labels`
- Post-context (exact): `that allow much finer grained management of the information.`
- Occurrence rule: unique
- Rationale: Correct grammar and hyphenation.
- Validation check: Re-run W3C section 11 review.

### CHG-003
- Target file: fhir-repo/source/security-labels.html
- Anchor: Guidance on Security Vocabulary Use
- Edit type: replace
- Current text (exact): `security vocabulary for appropriate for use with FHIR systems`
- Proposed text (exact): `security vocabulary appropriate for use with FHIR systems`
- Pre-context (exact): `This specification defines a set of`
- Post-context (exact): `-- the Healthcare Privacy and Security Classification System`
- Occurrence rule: unique
- Rationale: Remove duplicated preposition.
- Validation check: Re-run W3C section 11 review.

### CHG-004
- Target file: fhir-repo/source/security-labels.html
- Anchor: Guidance on Security Vocabulary Use
- Edit type: replace
- Current text (exact): `how they are operationalized - their use and interpretation - is subject`
- Proposed text (exact): `how they are operationalized, including their use and interpretation, is subject`
- Pre-context (exact): `For all these vocabulary terms,`
- Post-context (exact): `to the applicable Mutual Trust Framework agreement`
- Occurrence rule: unique
- Rationale: Improve punctuation and readability.
- Validation check: Re-run W3C section 11 review.

### CHG-005
- Target file: fhir-repo/source/security-labels.html
- Anchor: Guidance on Security Vocabulary Use
- Edit type: replace
- Current text (exact): `Meta Data: ... security/privacy meta`
- Proposed text (exact): `Metadata: ... security/privacy metadata`
- Pre-context (exact): `and (3) <code>Resource.meta.security</code>`
- Post-context (exact): `about that data.`
- Occurrence rule: unique
- Rationale: Use consistent terminology.
- Validation check: Re-run W3C section 11 review.

### CHG-006
- Target file: fhir-repo/source/security-labels.html
- Anchor: Guidance on Security Vocabulary Use / Bundle paragraph
- Edit type: replace
- Current text (exact): `Bundle: A bundle is a container for a collection of data. Some uses of bundle are for communicating search results, sending data, or persisting data (See Bundle).`
- Proposed text (exact): `Bundle: A bundle is a container for a collection of data. Some uses of Bundle are communicating search results, sending data, or persisting data (see Bundle).`
- Pre-context (exact): `</p><p>`
- Post-context (exact): `The <code>Bundle.meta.security</code> would carry meta`
- Occurrence rule: unique
- Rationale: Correct capitalization and sentence construction.
- Validation check: Re-run W3C section 11 review.

### CHG-007
- Target file: fhir-repo/source/security-labels.html
- Anchor: Guidance on Security Vocabulary Use / Bundle paragraph
- Edit type: replace
- Current text (exact): `confidentiality 'high water" mark`
- Proposed text (exact): `confidentiality 'high-water' mark`
- Pre-context (exact): `Specifically the`
- Post-context (exact): `the authorized purposeOfUse`
- Occurrence rule: unique
- Rationale: Balance quotation marks and hyphenate the compound modifier.
- Validation check: Re-run W3C section 11 review.

### CHG-008
- Target file: fhir-repo/source/security-labels.html
- Anchor: Guidance on Security Vocabulary Use / Bundle paragraph
- Edit type: replace
- Current text (exact): `the most high confidentiality`
- Proposed text (exact): `the highest confidentiality level`
- Pre-context (exact): `mark is an indication of`
- Post-context (exact): `Depending on Policy`
- Occurrence rule: unique
- Rationale: Use idiomatic comparative wording.
- Validation check: Re-run W3C section 11 review.

### CHG-009
- Target file: fhir-repo/source/security-labels.html
- Anchor: Guidance on Security Vocabulary Use / Bundle paragraph
- Edit type: replace
- Current text (exact): `valueSet contains of some security-label codes`
- Proposed text (exact): `value set contains security-label codes`
- Pre-context (exact): `Security Label Event Examples</a>`
- Post-context (exact): `that would be used on Bundle.meta.security.`
- Occurrence rule: unique
- Rationale: Correct grammar and terminology styling.
- Validation check: Re-run W3C section 11 review.

### CHG-010
- Target file: fhir-repo/source/security-labels.html
- Anchor: Guidance on Security Vocabulary Use / Metadata paragraph
- Edit type: replace
- Current text (exact): `valueSet contains of some security-label codes`
- Proposed text (exact): `value set contains security-label codes`
- Pre-context (exact): `Security Label Data Examples</a>`
- Post-context (exact): `that would be used on data.`
- Occurrence rule: unique
- Rationale: Correct the repeated grammar error.
- Validation check: Re-run W3C section 11 review.

### CHG-011
- Target file: fhir-repo/source/security-labels.html
- Anchor: HCS table / Purpose of Use row
- Edit type: replace
- Current text (exact): `These <a href="https://terminology.hl7.org/ValueSet-v3-PurposeOfUse.html">Purpose of Use</a>`
- Proposed text (exact): `The <a href="https://terminology.hl7.org/ValueSet-v3-PurposeOfUse.html">Purpose of Use</a>`
- Pre-context (exact): `<td>Purpose of Use</td>`
- Post-context (exact): `(system = http://terminology.hl7.org/CodeSystem/v3-PurposeOfUse)`
- Occurrence rule: unique
- Rationale: Correct subject-verb agreement.
- Validation check: Re-run W3C section 11 review.

### CHG-012
- Target file: fhir-repo/source/security-labels.html
- Anchor: HCS table / Confidentiality codes row
- Edit type: replace
- Current text (exact): `These <a href="https://terminology.hl7.org/ValueSet-v3-Confidentiality.html">confidentiality class</a>`
- Proposed text (exact): `This <a href="https://terminology.hl7.org/ValueSet-v3-Confidentiality.html">confidentiality class</a>`
- Pre-context (exact): `<td>Confidentiality codes</td>`
- Post-context (exact): `(system = http://terminology.hl7.org/CodeSystem/v3-Confidentiality)`
- Occurrence rule: unique
- Rationale: Correct subject-verb agreement.
- Validation check: Re-run W3C section 11 review.

### CHG-013
- Target file: fhir-repo/source/security-labels.html
- Anchor: HCS table / Delete After Use row
- Edit type: replace
- Current text (exact): `a prohibition not storing the resource`
- Proposed text (exact): `a prohibition on storing the resource`
- Pre-context (exact): `This might imply`
- Post-context (exact): `in any audit trail as well`
- Occurrence rule: unique
- Rationale: Correct the preposition.
- Validation check: Re-run W3C section 11 review.

### CHG-014
- Target file: fhir-repo/source/security-labels.html
- Anchor: HCS table / Test Data row
- Edit type: replace
- Current text (exact): `>Purpose Of Use</a>.<a href="https://terminology.hl7.org/CodeSystem-v3-ActReason.html#v3-ActReason-HTEST">HTEST`
- Proposed text (exact): `>ActReason</a>.<a href="https://terminology.hl7.org/CodeSystem-v3-ActReason.html#v3-ActReason-HTEST">HTEST`
- Pre-context (exact): `<td>Test Data:`
- Post-context (exact): `</a></td>`
- Occurrence rule: unique
- Rationale: Align the first link label with the ActReason target; the row describes the HTEST ActReason code, not a Purpose of Use value set.
- Validation check: Re-run link description alignment review.

## Blocking Issues
- None.
