# Technical Corrections Review Report

## Metadata
- Review ID: best-practices-technical-2026-08-14
- Date: 2026-08-14
- Mode: page
- Target: `fhir-repo/publish/best-practices.html`
- Ticket: None

## Build Evidence
- Build check command: ./.github/skills/build-fhir/scripts/build-if-needed.sh --repo ./fhir-repo --mode check
- Build check result: `BUILD_NEEDED: no`
- Build status used for review: current
- Additional evidence: The freshness check passed and the rendered page resolved uniquely.

## Inputs Used
- Source files:
  - `fhir-repo/source/best-practices.html`
- Output files:
  - `fhir-repo/publish/best-practices.html`

## W3C Findings
### Section 7.2
- None identified.

### Section 7.3
- None identified.

### Section 11
- **Finding W3C-001: Repeated wording**
  - Severity: warning; confidence: high
  - Location: rendered page line 156, local-build banner
  - Current text: `Directory of published versions for published versions`
  - Suggested correction: `Directory of published versions`
  - Rationale: The phrase is repeated without adding meaning.
- **Finding W3C-002: Awkward construction**
  - Severity: warning; confidence: medium
  - Location: source `best-practices.html`, introductory paragraph
  - Current text: `Committees can document best practice by one of two different ways`
  - Suggested correction: `Committees can document best practice in one of two ways`
  - Rationale: The revised construction is grammatical and removes redundant wording.

### Section 13
- None identified.

## Link Target Validation Findings
- No missing local targets were found. All 21 relative file links resolve under `fhir-repo/publish/`; fragment targets were checked where applicable.
- External HTTP(S) links are present in the page header/footer and linked best-practice context. They are recorded as `indeterminate` for offline validation rather than treated as local failures.

## Link Description Correspondence Findings
- None. Local link text aligns with target page names or section intent, including `FHIR validator`, resource names, `Documentation Index`, and `Search Parameters`.

## Spelling Findings
- **Finding SPELL-001**
  - Severity: warning; confidence: high
  - Location: rendered page line 209, Appointment `app-6` description
  - Evidence: `occurence`
  - Suggested correction: `occurrence`
- **Finding SPELL-002**
  - Severity: info; confidence: medium
  - Location: rendered page lines 204 and 245
  - Evidence: `eco-system`; `eco-systems`
  - Suggested correction: `ecosystem`; `ecosystems`

## Non-W3C Technical Corrections
- None identified. The page is validly rendered, and no malformed FHIRPath, resource binding, or subject/search-parameter technical issue applies to this narrative index.

## Patch-Ready Change Set
### CHG-001
- Target file: source/template or generated navigation source for the local-build banner
- Anchor: local-build banner
- Edit type: replace
- Current text (exact): `Directory of published versions for published versions`
- Proposed text (exact): `Directory of published versions`
- Pre-context (exact): `See the <a href="http://hl7.org/fhir/directory.html">`
- Post-context (exact): `<img src="external.png" alt="icon"`
- Occurrence rule: first occurrence in the banner
- Rationale: Remove repeated wording.
- Validation check: Rebuild or inspect the rendered banner and confirm the directory link remains present.

### CHG-002
- Target file: `fhir-repo/source/best-practices.html`
- Anchor: introductory list paragraph
- Edit type: replace
- Current text (exact): `Committees can document best practice by one of two different ways:`
- Proposed text (exact): `Committees can document best practice in one of two ways:`
- Pre-context (exact): `However, it is useful for the FHIR standard to be able to document what are known best practices.`
- Post-context (exact): `<ul>`
- Occurrence rule: unique
- Rationale: Improve grammar and remove redundant wording.
- Validation check: Confirm the source sentence renders correctly in the generated page.

### CHG-003
- Target file: source definition that generates the Appointment `app-6` best-practice description
- Anchor: Appointment `app-6` description
- Edit type: replace
- Current text (exact): `occurence`
- Proposed text (exact): `occurrence`
- Pre-context (exact): `Each`
- Post-context (exact): `should refer back to the originatingAppointment`
- Occurrence rule: unique within the `app-6` description
- Rationale: Correct spelling.
- Validation check: Confirm the rendered table contains `occurrence`.

### CHG-004
- Target file: source definition that generates the DomainResource `dom-6` description
- Anchor: DomainResource `dom-6` description
- Edit type: replace
- Current text (exact): `eco-system`
- Proposed text (exact): `ecosystem`
- Pre-context (exact): `a much more robust`
- Post-context (exact): `and cheaper handling`
- Occurrence rule: unique within the `dom-6` description
- Rationale: Use the standard closed compound spelling.
- Validation check: Confirm the rendered table contains `ecosystem`.

### CHG-005
- Target file: source definition that generates the DomainResource `dom-6` description
- Anchor: DomainResource `dom-6` description
- Edit type: replace
- Current text (exact): `eco-systems`
- Proposed text (exact): `ecosystems`
- Pre-context (exact): `However experience shows that such`
- Post-context (exact): `often open up to new participants`
- Occurrence rule: unique within the `dom-6` description
- Rationale: Use the standard closed compound spelling.
- Validation check: Confirm the rendered table contains `ecosystems`.

## Apply Sequence
1. CHG-001
2. CHG-002
3. CHG-003
4. CHG-004
5. CHG-005

## Blocking Issues
- None.
