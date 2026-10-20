# Implementation Plan: FHIR-21492

## Scope Summary

- Canonical ticket: [FHIR-21492](FHIR-21492.md); this ticket only, in its own planning session.
- Work group: Clinical Interoperability Council.
- Requested correction: fix malformed table rows and surplus cells in the CDMH `profiles` page, sections 1.3.2, 1.3.3 and 1.3.4; specifically the DEMOGRAPHICS heading row.
- Eligibility: **passes local metadata gate**. Specification is FHIR Core (FHIR); assignee is Bas van den Heuvel (the requested bvdh assignment); status is `Resolved - change required`; resolution is `Persuasive`; resolution description is `Auto-approved`; impact is `Non-substantive`. The export gives the assignee display name, not independent account-ID evidence.
- Planning baseline: local `fhir-repo` HEAD `5a1b865a60060794c71b2ace30105c97a69e0c56`, inspected 2026-10-20. Its author and committer timestamp is 2026-10-19T20:06:43-06:00; checkout is not shallow. No fetch or branch operations were performed.
- **Disposition of this plan: blocked for source execution.** The matching tables belong to the separate HL7/cdmh implementation guide, not an identified `fhir-repo/source/` file. The named defect is already absent from the inspected current CDMH sources. The approval/vote date is not established.
- Only this plan is written. No ticket move, metadata update, resolution artifact, source edit, build, commit, currentTickets change or other ticket change is authorized.

## Ticket Matrix

| Ticket | Summary | Status / resolution | Target page(s) | Change type | Readiness |
|---|---|---|---|---|---|
| FHIR-21492 | Fix table formatting issues - CDMH #18 | Resolved - change required / Persuasive | CDMH `profiles.html`, PCORnet / OMOP / Sentinel mapping tables | Non-substantive HTML row/cell repair | Metadata eligible; Core target missing; original example already corrected in later CDMH source; vote cutoff unverified |

## Resolution, Comments and Vote-Date Evidence

The operative resolution is only **"Auto-approved"**. Read together with `Persuasive`, this supports correcting the reported formatting, not rewriting mapping semantics, changing resources, redesigning all tables or removing populated mapping columns. There are no comments in the canonical export, so no additional implementation wording is available.

| Evidence | What it establishes | What it does not establish |
|---|---|---|
| Ticket metadata lines 6-8: Created 2019-05-06, Updated 2026-05-27, Resolved 2019-11-09 | Exported lifecycle dates | A vote date or actual application date |
| Ticket lines 16-24: `Vote / is voted on by / BALLOT-7907`, affirmative ballot entry attributed to Marc Hadley, truncated `2019-May-...`, Closed | A linked ballot submission exists | Date of work-group disposition, approval or automatic approval |
| Ticket line 30: `Resolution Description: Auto-approved` | Approval mechanism recorded in this export | Date when automatic approval took effect |
| Ticket lines 38-40: no comments in export | No explicit voting evidence in exported comments | Absence of Jira history or minutes elsewhere |
| Read-only Jira browse and REST issue-with-changelog requests returned HTTP 403 | Live issue history was inaccessible in this session | Any hidden vote, Applied transition or actual implementation date |

**Vote date: unknown. No verified post-vote cutoff can be applied.** The 2019 ballot context and 2019-11-09 resolved date are context only; neither is silently used as the vote date. History below is chronological evidence, not a certified exhaustive post-vote audit.

Before execution, obtain an authorized Jira history/export containing the Vote Date or dated auto-approval transition, or dated CIC minutes recording approval of this issue. Confirm whether auto-approval has no separate vote date and, if so, which approval-effective date should define the cutoff. Re-run affected-path history against that confirmed cutoff.

## Exact Source Mapping and Current Lines

### FHIR Core checkout: no verified edit target

The repository-specific [FHIR checkout instructions](../../../.github/instructions/fhir-repo.instructions.md) were read before inspection. All possible Core edits remain constrained to `fhir-repo/source/`.

- Searches for `DEMOGRAPHICS`, `CDMH`, and adjacent `</tr></tr>` did not identify the reported table in the Core source. Case-insensitive demographic matches were ordinary resource/prose usages, not the CDMH mapping grid.
- `source/profiles/` is a directory of profile/extension artifacts, not the requested page. No tracked `source/profiles.html` exists at HEAD; an all-ref literal-path history query also returned no commits.
- [Core profiling.html](../../../fhir-repo/source/profiling.html), lines 14-15, is **Profiling FHIR**, owned by FHIR Infrastructure. Its table at lines 44-63 is a two-column implementation-guide hierarchy; its glossary table at lines 79-105 has three columns. Neither contains DEMOGRAPHICS or the CDM mappings. These are **excluded candidates, not proposed edit surfaces**.
- Therefore there are no defensible Core file/line edits to prescribe. Do not invent a new Core `profiles.html`, copy the CDMH tables into Core, or change the hierarchy table as a proxy.

### Matching external source: evidence only, not authorized scope

The [2019-May ballot page](https://hl7.org/fhir/us/cdmh/2019May/profiles.html) identifies itself as Common Data Models Harmonization FHIR IG v0.1.0, based on FHIR R4. This contradicts the canonical ticket's Core/STU3 classification and requires owner confirmation, not an automatic metadata correction.

Its downloaded HTML has:

- Lines 272-294: PCORnet heading/header and DEMOGRAPHICS row. The header has three cells; the heading uses `colspan="3"` followed by two empty cells, yielding **five logical columns**. This precisely reproduces the ticket's overflow example.
- Lines 1245 and 2124: OMOP and Sentinel mapping section headings.

Current external source was inspected at HL7/cdmh master HEAD **`90eca39badf52fb97a1417a942da40e792e7fd89`**, without cloning or changing any checkout. Line numbers below refer to raw files at that pinned revision, not files in this workspace:

| External file | Current lines | Finding / conditional edit scope |
|---|---|---|
| [`input/pagecontent/profiles.md`](https://github.com/HL7/cdmh/blob/90eca39badf52fb97a1417a942da40e792e7fd89/input/pagecontent/profiles.md) | 24-29, 33-38, 49-54 | Includes PCORnet, OMOP and Sentinel HTML fragments. Preserve includes; fix a proven defect in its fragment rather than generated output. |
| [`input/includes/PCORnet_CDM_v4_FHIR.html`](https://github.com/HL7/cdmh/blob/90eca39badf52fb97a1417a942da40e792e7fd89/input/includes/PCORnet_CDM_v4_FHIR.html) | 3-16; full table 3-1133 | Four-cell header; DEMOGRAPHICS uses `colspan="2"` plus populated Patient and Person cells. Logical width is four, not the original five. **No edit presently identified.** |
| [`input/includes/OMOP_FHIR.html`](https://github.com/HL7/cdmh/blob/90eca39badf52fb97a1417a942da40e792e7fd89/input/includes/OMOP_FHIR.html) | 3-16; 683-752; 754-758; full table 3-989 | Four-column active table. NOTE legacy markup with surplus cells is inside an HTML comment; OBSERVATION_PERIOD correctly spans four columns. Do not enable commented content or blindly replace all colspans. |
| [`input/includes/Sentinel_FHIR.html`](https://github.com/HL7/cdmh/blob/90eca39badf52fb97a1417a942da40e792e7fd89/input/includes/Sentinel_FHIR.html) | 3-16; full table 3-781 | Four-column header and DEMOGRAPHIC heading with matching effective width. **No edit presently identified.** |

The [current published page](https://hl7.org/fhir/us/cdmh/profiles.html) identifies itself as v1.0.0 STU1 and shows four mapping columns, including BRIDG. Publication supports existence of the later layout, not a verified FHIR-21492 application date.

## History and Blocker Analysis

### Local git log, blame and diffs: Core candidate exclusion

Local `git log`, ordinary and whitespace-ignoring `git blame`, and substantive diffs were inspected for `source/profiling.html`. This is a false-positive page candidate; the following changes are not changes to the missing CDMH tables.

| Commit / timestamps | Evidence and ticket correlation | Effect on FHIR-21492 |
|---|---|---|
| `1e1665b9352f33a691326fdf3079bc19865a8681`; author/committer 2022-12-05T17:31:12+11:00 | Pickaxe history for `International Base Agreements` and `blame -w` attribute the hierarchy table, current lines 44-63, to this documentation update. No ticket ID in inspected subject. | Later Core content, not a renamed CDMH mapping table. Preserve it; not a semantic blocker to formatting corrections in CDMH. |
| `887bc2383fb7b429cfafd64a46bdfc0c40c5b627`; author/committer 2025-11-03T16:39:58+01:00; subject **FHIR-44047** | Diff adds commas after `e.g.` in hierarchy examples, current lines 47, 50-51, 54-55. [Local FHIR-44047](../../open/FHIR-44047/FHIR-44047.md) describes exactly that punctuation correction but still says Resolved - change required. | Preserve punctuation. No table-geometry obstruction; commit presence does not prove an Applied transition. Actual application date unverified. |
| `1a615d046b82e116357c4b077701fd4fba73f9bb`; author/committer 2026-05-27T11:27:44+02:00; **FHIR-55123** | Ordinary blame attributes much of the file to this commit; whitespace-ignoring blame and diff show line-ending churn plus wording corrections, including `publically` to `publicly`, current line 65. [Local ticket](../../closed/FHIR-55123/FHIR-55123.md) says Applied and links HL7/fhir#4116. [Change log](../../closed/FHIR-55123/FHIR-55123-implementation-change-log.md) explicitly records execution on 2026-05-27. GitHub reports merge at 2026-05-27T16:39:43Z, merge SHA `c9bb569918df7c418ead7f414c4cfc9806aa4570`. | Preserve later wording; no obstruction to CDMH table repair. Execution date is documented separately from commit and merge timestamps; exact Jira Applied-transition timestamp remains unverified. |

No FHIR-21492-named commit was found in the local all-ref commit-message search. This is not proof of non-implementation, particularly because matching source is in another repository.

### Actual CDMH mapping lineage: remote commit-diff evidence

External history was read through GitHub commit/path APIs, not local git blame. Its 2021 layout migration reports renames from `source/pages/_includes/PCORnet_CDM_v4_FHIR.html` to `input/includes/PCORnet_CDM_v4_FHIR.html` and from `source/pages/profiles.md` to `input/pagecontent/profiles.md`; both old and new PCORnet paths were checked. These dates are later than the ticket's creation/resolution context, but cannot be certified as post-vote until approval dating is confirmed.

| Commit / author and committer date | Observed change | Ticket/application evidence and impact |
|---|---|---|
| [`735bc264322511c3b7d2b1d612289eaf29ac3b77`](https://github.com/HL7/cdmh/commit/735bc264322511c3b7d2b1d612289eaf29ac3b77), 2021-07-28T04:41:47Z | Renames files and deletes the two empty trailing cells from the DEMOGRAPHICS heading and analogous PCORnet headings. The diff directly matches the reported overflow fix. | Subject is `Update to latest Build.`, not FHIR-21492. Evidence that this defect was corrected in that commit, **not** proof of its approval, Jira application date, or coverage of every malformed row mentioned by the ticket. |
| [`4a79348590415f0782d6b0bab714e99e8b721237`](https://github.com/HL7/cdmh/commit/4a79348590415f0782d6b0bab714e99e8b721237), 2021-07-28T04:52:22Z | Explicitly ticket-based batch, including FHIR-21482 and FHIR-21501 through several FHIR-215xx issues listed in its message; changes background/guidance/index and other pages, not the three mapping includes. | Does not name FHIR-21492. No local FHIR-21482 record found; no Applied/Published evidence for that batch established here. It cannot be treated as attribution for the table fix. No direct obstruction. |
| [`dc8da3a5f558f8ea994fb50f008378ec386e71ff`](https://github.com/HL7/cdmh/commit/dc8da3a5f558f8ea994fb50f008378ec386e71ff), 2021-08-03T15:50:02Z | Adds BRIDG Mapping as a fourth column; changes the DEMOGRAPHICS heading from one three-column cell to a two-column cell plus Patient and Person; adds populated BRIDG values to data rows. Also changes OMOP/Sentinel includes. | No ticket ID in inspected subject (`Updates to mappings.`), so do not invent a Jira correlation. **Blocks replaying a three-column historical patch**, not the formatting intent. Preserve four columns and all populated cells; repair only demonstrated structural defects against the current header. |
| [`86b2d714c346f52870a5ba02f86f33b3a29713ab`](https://github.com/HL7/cdmh/commit/86b2d714c346f52870a5ba02f86f33b3a29713ab), 2021-11-03T07:50:24Z | Updates PCORnet mappings, e.g. `patid` to `Patient.id`, birth time to `Patient.extension: patient-birthTime`, and profile/extension references. | No explicit ticket attribution established. Do not replace the current fragment with the ballot-era file: that would undo later mapping intent. |
| [`986271927c7f2c97eff320eecf7f8f6c750f8841`](https://github.com/HL7/cdmh/commit/986271927c7f2c97eff320eecf7f8f6c750f8841), 2021-12-01T22:19:52Z | `Add missed ticket resolutions.` Changes page guidance, including identifier-processing conventions, and OMOP birth-time mapping to `Patient.extension : patient-birthTime`. | Message gives no individual ticket IDs. It is not sufficient to claim application of FHIR-21492. Preserve current guidance and mapping text. |

Current CDMH `package-list.json` has a 1.0.0 trial-use entry with date **`TBD`**, and a current-build date of 2021-07-29. Neither proves the STU1 publication date or this issue's application date. The live published page establishes version availability only.

### Blocking conditions and concrete solution directions

1. **Repository/specification mismatch.** No exact affected Core source exists. Confirm with the ticket owner whether the intended target is HL7/cdmh and whether the Core/STU3 metadata is misclassified. This plan does not authorize edits there: obtain explicit repository/scope approval and prepare a narrowly scoped revision of the plan. If Core is truly intended, require the exact Core URL/source table before proceeding.
2. **Unknown approval cutoff.** Obtain dated approval evidence as specified above, then rerun affected-path log/blame/diffs and correlate newly identified ticket commits with local records/status histories. Do not substitute the resolved date.
3. **Historical patch is obsolete.** The concrete overflow example was fixed and the grid subsequently acquired meaningful BRIDG cells. Reconcile against current four-column geometry; never remove Patient/Person/BRIDG cells just because the original report said "two extra cells."
4. **No current active-row defect reproduced.** Prefer owner-reviewed reconciliation of existing implementation over manufacturing a new source diff. This session does not create a resolution, mark the ticket Applied, or assert the whole ticket is already applied. If a residual malformed row is supplied, document its current file/line and exact expected structure before implementing.

## Shared Implementation Approach

For this single ticket, retain the current semantic data and make only a verified structural correction. There is no unconditional edit step under `fhir-repo/source/` because no matching target was found.

## Execution Steps (Conditional; Not Executed)

1. Resolve the repository and approval-date gates. Record the confirmed URL, source revision, approval date and supporting history/minutes in this plan; do not edit the canonical ticket as part of planning.
2. In the authorized repository, re-read the current source and instructions and refresh line references. Follow includes/renames to maintained source; do not edit published HTML. Recheck log, blame and diffs after the confirmed cutoff, including non-ticket-named commits.
3. Capture a baseline of each in-scope active table: header width, effective row widths including colspan/rowspan, opening/closing row tags, ordered non-empty cell text and hyperlinks. Exclude HTML comments and distinguish each table independently.
4. If the owner confirms current CDMH is the target, first reproduce a remaining failure. The current DEMOGRAPHICS lines 11-16 already have width four: **leave unchanged**. OMOP's commented NOTE region at lines 683-752 is not a rendered overflow and is not a reason to delete cells.
5. For a proven residual duplicate row closure, remove only the unmatched closing tag(s), preserving valid row boundaries. For a proven overflow, remove only genuinely empty surplus cells or correct that heading's colspan to the current header width. Preserve rowspans and every populated mapping cell; do not use blanket tag replacement or impose the ballot-era three-column schema.
6. Retain BRIDG mappings, Cdmh profile names, current patient-birthTime and identifier mappings, and later guidance. Any semantic or normative-language change requires separate approval and is outside this formatting ticket.
7. Validate the targeted fragments and rendered mapping tables using existing tooling in the approved repository. If all acceptance checks already pass and no residual defect is demonstrated, stop without a source change and ask the owner to reconcile the implementation/status evidence.

## Validation Checklist

### Checks completed during planning

- [x] Metadata eligibility and exact ticket scope checked; no existing plan was overwritten.
- [x] Core source searched; false-positive profiling page inspected, with local log/blame/diff evidence and later ticket correlation.
- [x] Original ballot markup reproduces the named overflow: five effective columns beneath a three-column header.
- [x] Current external source pinned and include paths/history followed.
- [x] Read-only Node text checks, after removing HTML comments, found PCORnet **188 rows / 188 opening and 188 closing tags**, OMOP **152 / 152 / 152**, Sentinel **106 / 106 / 106**. Every matched active row had effective colspan width **4**; no non-four-column rows were reported.
- [x] No build or source mutation performed. The text checks are not a full HTML parser, render test, rowspan-aware validator or proof that every historical malformed tag was resolved.

### Required before implementation can be accepted

- [ ] Obtain explicit vote/approval-effective date and verified target repository; rerun history using that cutoff.
- [ ] Map any remaining failure to an exact current source line and a rendered symptom; do not count commented-out markup as an active defect.
- [ ] Use the existing HTML/IG validation toolchain to report unmatched/nested row tags; account for browser auto-repair rather than relying only on a repaired DOM.
- [ ] Compute logical widths with colspan and rowspan occupancy; compare each active row against its own table header. Current inspected mapping tables expect four columns.
- [ ] Compare ordered non-empty cell contents, mapping relationships and links before/after: zero semantic changes, zero removed populated mapping cells.
- [ ] Render PCORnet, OMOP and Sentinel sections at normal and narrow viewport widths; confirm no phantom blank columns and no heading protruding beyond the data grid. Distinguish legitimate long mapping text from structural overflow.
- [ ] Confirm current Patient/Person/BRIDG headings, identifiers, birth-time mappings and later terminology remain intact.
- [ ] Review the scoped diff for line-ending churn and unrelated changes; run existing whitespace checks. No tooling/configuration/generated-output changes.
- [ ] Run the approved repository's existing build/QA only in a separately authorized implementation phase; no Core build is justified for this external table issue.

## Risks, Assumptions and Uncertainty

- **Not execution-ready:** metadata eligibility does not resolve source ownership or establish a vote cutoff. The precise Core edit surface requested by the workflow cannot be supplied honestly from the available evidence.
- **Partial existing implementation:** the specific overflow repair is directly visible in a 2021 commit, and current row geometry passes targeted checks. This is stronger than a guess but insufficient to claim the entire ticket applied or to supply an actual application date.
- **Later-intent preservation:** the two now-populated cells are not the two historical empty cells. Restoring old colspans or the ballot source would lose later content.
- **History limitations:** local git blame covers the excluded Core candidate; remote commit diffs cover matching CDMH source. External local-git blame and an exhaustive certified post-vote review remain outstanding. No ticket attribution is inferred from generic commit messages.
- **Published vs Applied:** publication availability, commit date, documented execution date, merge timestamp and Jira status-transition date are distinct evidence categories. Only FHIR-55123 has an explicit local execution-day record among the compared Core examples; no verified FHIR-21492 application date was found.
- **Shared workspace:** unrelated outer and nested working-tree changes were observed and left untouched. Other sessions may change source/status between planning and implementation; refresh the baseline without resetting or overwriting their work.
- **Next confirmation needed:** dated approval evidence and owner confirmation of HL7/cdmh as the intended target (or an exact alternative Core table), followed by identification of any residual defect. No status change is proposed automatically.
