# Non-Technical FHIR Review Report

## Metadata
- Review ID: exchanging-request-2026-08-14
- Date: 2026-08-14
- Mode: page
- Target input: fhir-repo/publish/exchanging-request.html
- Resolved output page: fhir-repo/publish/exchanging-request.html
- Status: ready

## Build Evidence
- Build check command: `./.github/skills/build-fhir/scripts/build-if-needed.sh --repo ./fhir-repo --mode check`
- Build check result: `BUILD_NEEDED: no`
- Notes: Freshness was already verified before review; no rebuild was run.

## Inputs Used
- Source files:
  - Requested: `fhir-repo/source/exchanging-request.xml` (not present in checkout)
  - Available page source used for source-context comparison: `fhir-repo/source/exchanging-request.html`
- Output files:
  - `fhir-repo/publish/exchanging-request.html`
- Agent payload: `target_input=fhir-repo/publish/exchanging-request.html`; `resolved_output_page=fhir-repo/publish/exchanging-request.html`; `source_context_hint=fhir-repo/source/exchanging-request.xml`

## Rule 1 Findings: Normative Language on Informative Pages

- **Finding ID:** R1-001; **Rule ID:** rule1; **Severity:** warning; **Confidence:** high
  - **Location:** Informative page, workflow introduction
  - **Evidence snippet:** “Some sort of process must occur that triggers a solicitation”
  - **Rationale:** Requirement language appears on an informative page.
  - **Suggested rewrite:** “Some sort of process is needed to trigger a solicitation.”
- **Finding ID:** R1-002; **Rule ID:** rule1; **Severity:** error; **Confidence:** high
  - **Location:** Direct POST, both ways
  - **Evidence snippet:** “it must either be stored ... or it must be thrown away”
  - **Rationale:** States mandatory outcomes on an informative page.
  - **Suggested rewrite:** “it is either stored as a record ... or discarded.”
- **Finding ID:** R1-003; **Rule ID:** rule1; **Severity:** error; **Confidence:** high
  - **Location:** Direct POST, both ways
  - **Evidence snippet:** “the data consumer must have an endpoint”
  - **Rationale:** States a mandatory implementation requirement.
  - **Suggested rewrite:** “the data consumer needs an endpoint where the desired data can be stored.”
- **Finding ID:** R1-004; **Rule ID:** rule1; **Severity:** error; **Confidence:** high
  - **Location:** CommunicationRequest plus Task
  - **Evidence snippet:** “the authoritative copy ... should be kept”
  - **Rationale:** Uses normative recommendation language.
  - **Suggested rewrite:** “the authoritative copy ... is generally kept.”
- **Finding ID:** R1-005; **Rule ID:** rule1; **Severity:** error; **Confidence:** high
  - **Location:** CommunicationRequest plus Task
  - **Evidence snippet:** “The CommunicationRequest ... should be a copy”
  - **Rationale:** Uses normative recommendation language.
  - **Suggested rewrite:** “The CommunicationRequest ... is generally a copy.”
- **Finding ID:** R1-006; **Rule ID:** rule1; **Severity:** warning; **Confidence:** high
  - **Location:** CommunicationRequest plus Task, Step 4
  - **Evidence snippet:** “The data source may optionally update the Task”
  - **Rationale:** Uses permission language to prescribe behavior.
  - **Suggested rewrite:** “The data source can update the Task.”
- **Finding ID:** R1-007; **Rule ID:** rule1; **Severity:** error; **Confidence:** high
  - **Location:** CommunicationRequest plus Task, Step 5
  - **Evidence snippet:** “polling must be used in Step 7”
  - **Rationale:** Uses strong requirement language.
  - **Suggested rewrite:** “Step 7 uses polling to determine that the Task is complete.”
- **Finding ID:** R1-008; **Rule ID:** rule1; **Severity:** warning; **Confidence:** medium
  - **Location:** CommunicationRequest plus Task, Task reference paragraph
  - **Evidence snippet:** “the Task may refer to a Request”
  - **Rationale:** Uses permission language for a relationship.
  - **Suggested rewrite:** “the Task can refer to a Request.”
- **Finding ID:** R1-009; **Rule ID:** rule1; **Severity:** warning; **Confidence:** high
  - **Location:** Requesting exchange using Task, status paragraph
  - **Evidence snippet:** “The data source may optionally update the Task”
  - **Rationale:** Uses permission language to prescribe behavior.
  - **Suggested rewrite:** “The data source can update the Task.”
- **Finding ID:** R1-010; **Rule ID:** rule1; **Severity:** error; **Confidence:** high
  - **Location:** Requesting exchange using Task, status paragraph
  - **Evidence snippet:** “polling must be used in Step 7 to see that the Task is complete”
  - **Rationale:** Uses strong requirement language on an informative page.
  - **Suggested rewrite:** “Step 7 uses polling to determine that the Task is complete.”

## Rule 2 Findings: Normative Language in note/summary/comment Fields
- None. No resource element note, summary, or comment fields were found with normative language.

## Rule 3 Findings: Regulatory Expressions vs Description
- **Finding ID:** R3-001; **Rule ID:** rule3; **Severity:** warning; **Confidence:** high
  - **Location:** CommunicationRequest plus Task, Step 5 / Step 8
  - **Evidence snippet:** “polling must be used in Step 7” versus “either polling or a previously created Subscription”
  - **Rationale:** The expression makes polling mandatory while the same-page workflow permits Subscription.
  - **Suggested rewrite:** “one of these approaches is needed to determine that the Task is complete.”
- **Finding ID:** R3-002; **Rule ID:** rule3; **Severity:** warning; **Confidence:** high
  - **Location:** Requesting exchange using Task, Step 3 / Step 6
  - **Evidence snippet:** “polling must be used in Step 7” versus “either polling or a previously created Subscription”
  - **Rationale:** The expression narrows the alternative mechanisms described later and points to the wrong step.
  - **Suggested rewrite:** “one of these approaches is needed in Step 6 to determine that the Task is complete.”

## Rule 4 Findings: FHIRPath Expressions vs Description
- None. No FHIRPath expressions or expression-bearing constraints requiring same-page comparison were identified.

## Rule 5 Findings: Contradictions on Page
- **Finding ID:** R5-001; **Rule ID:** rule5; **Severity:** error; **Confidence:** high
  - **Location:** CommunicationRequest plus Task, anchors `#cr-task5` and `#cr-task8`
  - **Evidence snippet:** “polling must be used” and “using either polling or a previously created Subscription”
  - **Rationale:** The page presents polling and Subscription as alternatives, then makes polling mandatory.
  - **Suggested rewrite:** “The data consumer must use either polling or a previously created Subscription to detect Task status changes and retrieve the completed Task.” Correct the step reference to Step 8.
- **Finding ID:** R5-002; **Rule ID:** rule5; **Severity:** error; **Confidence:** high
  - **Location:** Requesting exchange using Task, anchors `#task3` and `#task6`
  - **Evidence snippet:** “polling must be used in Step 7” and “using either polling or a previously created Subscription”
  - **Rationale:** The same contradiction occurs in the Task-only flow; the Step 7 reference belongs to the preceding flow.
  - **Suggested rewrite:** Use the same alternative-mechanism wording and reference the Task-only retrieval step, Step 6.

## Rule 6 Findings: subject Field Requires patient and/or subject Search Parameter
- None. **Subject context:** No FHIR resource `subject` element is defined; this is a narrative exchange-guidance page. **Observed search parameters:** None. Rule 6 is not applicable.

## Cross-Rule Synthesis
- The main issue is duplicated workflow language that both uses prohibited normative terms and contradicts the later polling-or-Subscription description. Resolve the mechanism wording and step references together. Rule 1 findings are otherwise localized prose corrections; Rule 2, Rule 4, and Rule 6 have no findings.

## Blocking Issues
- None for execution. The requested XML source context was unavailable; the available HTML source context was used and this limitation is recorded above. No source files were modified.
