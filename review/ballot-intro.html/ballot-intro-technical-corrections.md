# Ballot Introduction Technical Corrections Review

## Metadata

- Review ID: ballot-intro-technical-2026-08-14
- Date: 2026-08-14
- Mode: page
- Target: `fhir-repo/publish/ballot-intro.html`
- Ticket: none

## Build Evidence

- Build check command: `./.github/skills/build-fhir/scripts/build-if-needed.sh --repo ./fhir-repo --mode check`
- Build check result: `BUILD_NEEDED: no`
- Build status used for review: current
- Additional evidence: No rebuild was required; W3C cache was current as of 2026-08-07.

## Inputs Used

- Source files:
  - `fhir-repo/source/ballot-intro.html`
- Output files:
  - `fhir-repo/publish/ballot-intro.html`

## W3C Findings

### Section 7.2

- None.

### Section 7.3

- None.

### Section 11

- **W3C-001:** Replace `a substantive changes` with `a substantive change` in the ballot scope paragraph.
- **W3C-003:** Replace `'forwards' compatibility` with `'forward' compatibility` in the breaking-changes paragraph.
- **W3C-004:** Replace `Balloter's attention` with `Balloters' attention`.
- **W3C-005:** Replace `there thousands` with `there are thousands`.
- **W3C-007:** Replace `An addition, balloter's attention is drawn to the following requests for balloters attention:` with `In addition, balloters' attention is drawn to the following requests:`.
- **W3C-008:** Close the quotation after `taken.` and revise `impact` to `its impact` in the MedicationStatement bullet.
- **W3C-009:** Correct the href host from `terminology.fhr.org` to `terminology.hl7.org` so it matches the visible link text.

### Section 13

- **W3C-002:** Replace `These weill also not count as substantative changes` with `These will also not count as substantive changes`.
- **W3C-006:** Replace the malformed visible label `DocumentReCapabilityStatementference.$conforms` with `CapabilityStatement.$conforms`.
- **W3C-010:** Replace `useability assertions` with `usability assertions`.

## Link Target Validation Findings

- **LNK-001:** `observation.html#bn` is missing. The file exists, but the relevant `Observation Grouping` anchor is `obsgrouping`.
- **LNK-002:** `codesystem.html#bn` is missing. The relevant `Implicit Code Systems` anchor is `implicit-code-systems`.
- External HTTP/HTTPS checks: four targets returned successful bounded HTTP evidence (`hl7.org/fhir`, `www.hl7.org`, `build.fhir.org/search-build.html`, and `registry.fhir.org`); remaining external targets are indeterminate because the bounded probe did not complete. The two mailto links were syntactically valid.

## Link Description Correspondence Findings

- **LNK-003:** At the `OperationDefinition-CapabilityStatement-conforms.html` link, visible text `DocumentReCapabilityStatementference.$conforms` does not match the target operation. Proposed label: `CapabilityStatement.$conforms`.
- **LNK-004:** At the `OperationDefinition-ChargeItemDefinition-apply.html` link, visible text `ChargeDefinition.$apply` does not match the target. Proposed label: `ChargeItemDefinition.$apply`.
- **LNK-005:** Visible text `terminology.hl7.org` does not correspond to href host `terminology.fhr.org`; correct the href to `http://terminology.hl7.org`.

## Spelling Findings

- **SPELL-001:** `weill` -> `will`.
- **SPELL-002:** `substantative` -> `substantive`.
- **SPELL-003:** `there thousands` -> `there are thousands`.
- **SPELL-004:** `An addition` -> `In addition`.
- **SPELL-005:** `useability` -> `usability`.
- **SPELL-006:** `Balloter's` / `balloters attention` -> consistent plural possessive wording, such as `Balloters' attention` / `balloters' attention`.

## Non-W3C Technical Corrections

- None beyond the missing local anchors and link-label/target mismatches listed above.

## Patch-Ready Change Set

All changes target `fhir-repo/source/ballot-intro.html`; no source changes were applied by this review.

- **CHG-001:** Replace `href="observation.html#bn"` with `href="observation.html#obsgrouping"`. Anchor: organizer-element ballot request. Validate the fragment resolves to `Observation Grouping`.
- **CHG-002:** Replace `href="codesystem.html#bn"` with `href="codesystem.html#implicit-code-systems"`. Anchor: implicit code systems request. Validate the fragment resolves to `Implicit Code Systems`.
- **CHG-003:** Replace `Moving CodeSystems from core to THO is only a substantive changes if` with `Moving CodeSystems from core to THO is only a substantive change if`.
- **CHG-004:** Replace `These weill also not count as substantative changes` with `These will also not count as substantive changes`.
- **CHG-005:** Replace `'forwards' compatibility` with `'forward' compatibility`.
- **CHG-006:** Replace `Balloter's attention is drawn to three useful links` with `Balloters' attention is drawn to three useful links`.
- **CHG-007:** Replace `Note that there thousands of changes` with `Note that there are thousands of changes`.
- **CHG-008:** Replace `DocumentReCapabilityStatementference.$conforms` with `CapabilityStatement.$conforms`.
- **CHG-009:** Replace `An addition, balloter's attention is drawn to the following requests for balloters attention:` with `In addition, balloters' attention is drawn to the following requests:`.
- **CHG-010:** Replace `statements such as 'no medications are known / taken. Balloters are invited to comment on this approach, impact and possible limitations` with `statements such as 'no medications are known / taken.' Balloters are invited to comment on this approach, its impact, and possible limitations`.
- **CHG-011:** Replace `<a href="http://terminology.fhr.org">terminology.hl7.org</a>` with `<a href="http://terminology.hl7.org">terminology.hl7.org</a>`.
- **CHG-012:** Replace `ChargeDefinition.$apply` with `ChargeItemDefinition.$apply`.
- **CHG-013:** Replace `useability assertions` with `usability assertions`.

For each change, occurrence rule is `unique in file` unless the exact phrase is otherwise scoped by the named paragraph. Validate by rebuilding or rerunning the page link, spelling, and W3C checks; do not edit generated publish output directly.

## Apply Sequence

1. CHG-001 and CHG-002 (local fragment targets)
2. CHG-003 through CHG-013 (prose, labels, and external href)
3. Rebuild the FHIR specification and rerun this page review.

## Blocking Issues

- None. External links not completed by the bounded probe are indeterminate rather than blocking.
