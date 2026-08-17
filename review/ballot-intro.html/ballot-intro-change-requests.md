# Ballot Introduction FHIR Review

## Metadata

- Review ID: ballot-intro-2026-08-14
- Date: 2026-08-14
- Mode: page
- Target input: `fhir-repo/publish/ballot-intro.html`
- Resolved output page: `fhir-repo/publish/ballot-intro.html`
- Status: ready

## Build Evidence

- Build check command: `./.github/skills/build-fhir/scripts/build-if-needed.sh --repo ./fhir-repo --mode check`
- Build check result: `BUILD_NEEDED: no`
- Notes: The publish output was current; no rebuild was required.

## Inputs Used

- Source files:
  - `fhir-repo/source/ballot-intro.html`
- Output files:
  - `fhir-repo/publish/ballot-intro.html`

## Rule 1 Findings: Normative Language on Informative Pages

- **Finding ID:** R1-001; **Severity:** error; **Confidence:** high
  - **Location:** R6 Ballot Roadmap, ballot-process introduction
  - **Evidence snippet:** `balloters should note the following`
  - **Rationale:** Normative recommendation language appears on a page marked Informative.
  - **Suggested rewrite:** `the following information may be useful to balloters`
- **Finding ID:** R1-002; **Severity:** error; **Confidence:** high
  - **Location:** R6 Ballot Roadmap, first ballot-process bullet
  - **Evidence snippet:** `must be approved by the ballot`
  - **Rationale:** Imposes a mandatory approval requirement in informative prose.
  - **Suggested rewrite:** `require approval by the ballot`
- **Finding ID:** R1-003; **Severity:** error; **Confidence:** high
  - **Location:** R6 Ballot Roadmap, first-ballot participation bullet
  - **Evidence snippet:** `You must sign up for the first ballot`
  - **Rationale:** Directly imposes a mandatory reader action.
  - **Suggested rewrite:** `Participation in later ballots requires signing up for the first ballot`
- **Finding ID:** R1-004; **Severity:** error; **Confidence:** high
  - **Location:** R6 Ballot Roadmap, Jira voting bullet
  - **Evidence snippet:** `you must actually vote affirmative or negative`
  - **Rationale:** Directly imposes a voting requirement.
  - **Suggested rewrite:** `a comment counts as voted only when an affirmative or negative vote is recorded`
- **Finding ID:** R1-005; **Severity:** warning; **Confidence:** high
  - **Location:** Ballot scope introduction
  - **Evidence snippet:** `Balloters should keep the following in mind`
  - **Rationale:** Uses normative recommendation language.
  - **Suggested rewrite:** `The following information provides context about ballot scope`
- **Finding ID:** R1-006; **Severity:** warning; **Confidence:** high
  - **Location:** Breaking changes, R4 bullet
  - **Evidence snippet:** `balloters should pay particular attention`
  - **Rationale:** Directs reader behavior through normative recommendation language.
  - **Suggested rewrite:** `The parts that were normative in R4 are relevant when reviewing this ballot`
- **Finding ID:** R1-007; **Severity:** warning; **Confidence:** high
  - **Location:** Breaking changes, other parts bullet
  - **Evidence snippet:** `may contain breaking changes`
  - **Rationale:** Uses reserved normative vocabulary in informative prose.
  - **Suggested rewrite:** `can contain breaking changes`

## Rule 2 Findings: Normative Language in note/summary/comment Fields

- None. No FHIR resource-element `note`, `summary`, or `comment` fields occur on this introductory narrative page.

## Rule 3 Findings: Regulatory Expressions vs Description

- **Finding ID:** R3-001; **Severity:** error; **Confidence:** high
  - **Location:** Standards Status table and opening ballot-process paragraphs
  - **Evidence snippet:** `Standards Status: Informative` versus `This ballot is a Normative ballot - ALL of the specification is being balloted as a full Normative ANSI Standard.`
  - **Rationale:** The same page assigns Informative status while describing a full Normative ballot. Align the metadata and prose.
  - **Suggested rewrite:** If the ballot is normative, change the status text to `Normative`; otherwise revise the paragraph to describe an informative ballot.

## Rule 4 Findings: FHIRPath Expressions vs Description

- None. No FHIRPath expressions were found. Operation names such as `Resource.$meta` are not FHIRPath expressions.

## Rule 5 Findings: Contradictions on Page

- None found. Statements about normative status, breaking changes, and reballoting are qualified by scope and timing and were not treated as direct internal contradictions beyond R3-001.

## Rule 6 Findings: subject Field Requires patient and/or subject Search Parameter

- None. No `subject` element was detected; this is not a resource page. The observed patient/subject search-parameter inventory is empty because the page contains no search-parameter section or `subject`/`patient` search parameter.

## Cross-Rule Synthesis

- 8 findings: 7 Rule 1 findings and 1 Rule 3 finding.
- The main issue is that an Informative page uses normative ballot-process language and contains an Informative-versus-Normative status mismatch. Several editorial issues are separately documented in the technical-corrections report.

## Blocking Issues

- None.
