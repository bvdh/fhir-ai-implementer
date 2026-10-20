# PR #4126: Datatypes

- Repository: [HL7/fhir](https://github.com/HL7/fhir)
- Pull request: [#4126](https://github.com/HL7/fhir/pull/4126)
- Status: `MERGED`
- Draft: false
- Branches: `datatypes` → `master`
- Review decision: not reported
- Created: 2026-06-04T08:13:07Z
- Updated: 2026-07-15T18:48:58Z
- Closed: 2026-07-15T18:48:58Z
- Merged: 2026-07-15T18:48:58Z
- Synced: 2026-10-20T12:17:58Z

## Checks

| Check | Status | Conclusion |
|---|---|---|
| triage / eligibility | COMPLETED | SUCCESS |
| triage / build_timeout_alert | COMPLETED | SKIPPED |
| triage / triage | COMPLETED | SUCCESS |
| Master Branch Pipeline | COMPLETED | NEUTRAL |
| Pull Request Pipeline | COMPLETED | SUCCESS |


## Description

## Scope
One or more commits addressing the tickets listed below.

## Per-Ticket Change Summary
- [FHIR-40696](https://jira.hl7.org/browse/FHIR-40696): Replaced broken literal timezone extension text in datatypes instant value-domain note.
- [FHIR-41631](https://jira.hl7.org/browse/FHIR-41631): Verified all in-scope datatypes and metadatatypes pages already use [%wg fhir%]/[%wgt fhir%].
- [FHIR-44639](https://jira.hl7.org/browse/FHIR-44639): Fixed CodeableReference datatype categorization (moved from Special Purpose to General-Purpose Datatypes diagram) and corrected diagram canvas heights so bottom-row boxes no longer clip.
- [FHIR-44645](https://jira.hl7.org/browse/FHIR-44645): Re-execute ticket validation against source and published output for HumanName anchors.
- [FHIR-46202](https://jira.hl7.org/browse/FHIR-46202): Update code primitive regex in datatypes source to the approved expression.
- [FHIR-46453](https://jira.hl7.org/browse/FHIR-46453): Fixed dateTime regex so a timezone offset is required whenever an hours/minutes time component is present.
- [FHIR-47129](https://jira.hl7.org/browse/FHIR-47129): update the Duration drt-1 FHIRPath expression in duration.xml.
- [FHIR-48493](https://jira.hl7.org/browse/FHIR-48493): Added additional binding uc-bind-age (purpose preferred) on UsageContext.code=age, pointing to http://terminology.hl7.org/ValueSet/v3-AgeGroupObservationValue; fixed purpose value typo "exetensible" -> "extensible" on the existing uc-bind-jurisdiction additional binding.
- [FHIR-50260](https://jira.hl7.org/browse/FHIR-50260): Clarified SampledData datatype and lower/upper limit definitions to use scaled semantics (factor + origin).
- [FHIR-50586](https://jira.hl7.org/browse/FHIR-50586): Add RelativeTime constraints box to datatypes page.
- [FHIR-51735](https://jira.hl7.org/browse/FHIR-51735): Verified decimal regex in source/datatypes/primitives.xml has no trailing extra brace.
- [FHIR-53636](https://jira.hl7.org/browse/FHIR-53636): Clarified id primitive description to explicitly prohibit all whitespace characters.
- [FHIR-53984](https://jira.hl7.org/browse/FHIR-53984): Allow more types for DataRequirement.valueFilter.value[x].
- [FHIR-54058](https://jira.hl7.org/browse/FHIR-54058): Add endOffset column to the Timing criteria examples table.
- [FHIR-54062](https://jira.hl7.org/browse/FHIR-54062): Add Timing notes section for periods with start or end offsets.
- [FHIR-54490](https://jira.hl7.org/browse/FHIR-54490): Clarify that Attachment.url relative references resolve against the FHIR service base URL.
- [FHIR-56000](https://jira.hl7.org/browse/FHIR-56000): Add comparator code ~ to the QuantityComparator code list in datatypes/quantity.xml.
- [FHIR-57408](https://jira.hl7.org/browse/FHIR-57408): Allow SampledData to have interval and/or offsets instead of requiring XOR.

## Notes on Overlaps
- No duplicate or overlapping implementations detected based on normalized per-ticket summaries.


## Comments

### Inline review comment by Copilot

- Date: 2026-07-15T12:19:36Z
- Link: https://github.com/HL7/fhir/pull/4126#discussion_r3587150397
- File: `source/datatypes/duration.xml`
- Line: 3306

The updated invariant now requires Duration.system to be present whenever value is present, but the invariant narrative says only "If system is present, it SHALL be UCUM." This makes the constraint stricter than its stated intent and could invalidate instances that omit system.

---

### Inline review comment by Copilot

- Date: 2026-07-15T12:19:37Z
- Link: https://github.com/HL7/fhir/pull/4126#discussion_r3587150448
- File: `source/datatypes/primitives.xml`
- Line: 304

This description says "Ids are case-insensitive", but the normative narrative on datatypes.html says ids are case sensitive. These statements contradict each other, and the inconsistency is in the newly edited text.

---

### Inline review comment by Copilot

- Date: 2026-07-15T12:19:37Z
- Link: https://github.com/HL7/fhir/pull/4126#discussion_r3587150481
- File: `source/datatypes/quantity.xml`
- Line: 6431

Comparator IDs are sequential (1..4 for <, <=, >=, >). The newly added "~" row uses Id=6, but the following "ad" row remains Id=5, which breaks ordering/uniqueness expectations for this code list.

---

### Inline review comment by Copilot

- Date: 2026-07-15T12:19:37Z
- Link: https://github.com/HL7/fhir/pull/4126#discussion_r3587150499
- File: `source/datatypes/quantity.xml`
- Line: 6442

To keep comparator IDs sequential after adding "~", the existing "ad" comparator should move from Id=5 to Id=6 (since "~" becomes 5).

---

### Inline review comment by Copilot

- Date: 2026-07-15T12:19:38Z
- Link: https://github.com/HL7/fhir/pull/4126#discussion_r3587150531
- File: `source/datatypes-definitions.html`
- Line: 78

Grammar issue: "The definition of the primitive types are defined..." should use plural "definitions" (or rephrase) to avoid the double-"defined" phrasing.

---

### Inline review comment by Copilot

- Date: 2026-07-15T12:19:38Z
- Link: https://github.com/HL7/fhir/pull/4126#discussion_r3587150563
- File: `source/datatypes.html`
- Line: 1910

This section anchor was renamed from "other" to "type-characteristics", but at least one in-repo link still targets datatypes.html#other (e.g., source/datatypes/elementdefinition.xml:2088). Keeping a backward-compatible anchor avoids broken internal links/bookmarks.

---

### Review by copilot-pull-request-reviewer[bot]

- Date: 2026-07-15T12:19:38Z
- Link: https://github.com/HL7/fhir/pull/4126#pullrequestreview-4703976629
- Review state: COMMENTED

## Pull request overview

This PR updates FHIR datatype source and rendered documentation to address a set of tracker items, including regex/invariant adjustments, clarified narrative guidance, updated diagrams, and example corrections (notably around UCUM `system`/`code` usage and Timing offsets).

**Changes:**
- Updates datatype definitions and constraints (e.g., `dateTime`, `id`, `Duration`, `SampledData`, `DataRequirement.valueFilter`, `Quantity` comparator list).
- Clarifies/extends narrative documentation and tables on `datatypes.html` (Timing offset guidance, RelativeTime constraints, primitive notes, anchor fixes).
- Adjusts supporting artifacts (diagrams, mapping exception metadata, spelling allowlist, and several XML examples).

### Reviewed changes

Copilot reviewed 20 out of 20 changed files in this pull request and generated 6 comments.

<details>
<summary>Show a summary per file</summary>

| File | Description |
| ---- | ----------- |
| source/spelling/add.txt | Adds additional allowed tokens for the spelling/wording pipeline. |
| source/requestorchestration/requestorchestration-example.xml | Adds UCUM `system`/`code` to `offsetDuration` in the example. |
| source/questionnaire/questionnaire-fivews-mapping-exceptions.xml | Updates FiveWs mapping exception declarations (unmapped elements). |
| source/plandefinition/plandefinition-protocol-example.xml | Adds UCUM `system`/`code` to `due` quantity in the example. |
| source/plandefinition/plandefinition-options-example.xml | Adds UCUM `system`/`code` to `offsetDuration` in the example. |
| source/evidencevariable/evidencevariable-example-outcome-death-or-major-injury.xml | Adds UCUM unit/system/code to `offsetDuration` example data. |
| source/datatypes/UsageContext-additional-bindings.xml | Adds `uc-bind-age` binding and fixes purpose typo for jurisdiction binding. |
| source/datatypes/timing.xml | Updates Timing offset documentation/constraints text in the sheet. |
| source/datatypes/specialtypes.diagram | Removes CodeableReference from special-purpose diagram and adjusts canvas sizing. |
| source/datatypes/sampleddata.xml | Clarifies scaled semantics for limits/offsets and relaxes interval/offset invariant to allow both. |
| source/datatypes/quantity.xml | Adds `~` comparator and updates comparator narrative; extends code list. |
| source/datatypes/primitives.xml | Updates primitive regexes/text (anchoring for `code`; updated `dateTime` regex; clarifies `id` whitespace). |
| source/datatypes/metadatatypes.diagram | Adjusts diagram canvas height. |
| source/datatypes/duration.xml | Updates Duration invariant logic for UCUM/system/code/value relationships. |
| source/datatypes/datarequirement.xml | Expands allowed `valueFilter.value[x]` types and adds valueFilter invariant row. |
| source/datatypes/attachment.xml | Clarifies how relative Attachment URLs resolve (against service base URL). |
| source/datatypes/alltypes.diagram | Moves/places CodeableReference and adjusts diagram sizing/positions. |
| source/datatypes/allprimitivetypes.diagram | Adjusts diagram canvas height. |
| source/datatypes.html | Updates multiple narrative sections (id whitespace rule, instant timezone extension link, Timing offset notes/table, RelativeTime constraints box, anchor rename). |
| source/datatypes-definitions.html | Replaces placeholder primitive section with quick-reference table and adds anchors. |
</details>







---

💡 <a href="/HL7/fhir/new/master?filename=.github/instructions/*.instructions.md" class="Link--inTextBlock" target="_blank" rel="noopener noreferrer">Add Copilot custom instructions</a> for smarter, more guided reviews. <a href="https://docs.github.com/en/copilot/customizing-copilot/adding-repository-custom-instructions-for-github-copilot" class="Link--inTextBlock" target="_blank" rel="noopener noreferrer">Learn how to get started</a>.

