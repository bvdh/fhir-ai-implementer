# Implementation Plan: FHIR-47129

## Scope Summary
- Workgroup/source: Ticket-key input (FHIR-47129)
- Tickets in scope: FHIR-47129
- Primary fix pattern: Wording and formal-constraint alignment for Duration invariant `drt-1`
- Secondary fix pattern: Align affected example Duration instances so they satisfy the corrected `drt-1` value-implies-code-and-UCUM semantics

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-47129 | Duration description and expression conflict | Resolved - change required | `datatypes.html#QuantityVariations` (generated), source in `fhir-fork/source/datatypes/duration.xml` | Technical correction (constraint wording/expression consistency) | Jira notes mismatch between English description and formal expression; references prior R4B resolution (FHIR-28415) |

## Shared Implementation Approach
1. Locate the Duration invariant definition in `fhir-fork/source/datatypes/duration.xml`.
2. Retrieve the last accepted historical form of `drt-1` from the R4B-era source/history so the correction is based on precedent rather than local guesswork.
3. Align the English invariant text and formal expression so they describe the same condition.
4. Keep edits minimal and constrained to the Duration invariant rows tied to `drt-1` intent.

## Historical Value Retrieval Detail
1. Capture the current R5/R6 state before editing:
   - Record the current `drt-1` English, FHIRPath, and XPath values from `fhir-fork/source/datatypes/duration.xml`.
   - Cross-check the rendered page in `fhir-fork/source/datatypes.html` or current publish output so the plan tracks both source and rendered wording.
2. Retrieve the historical precedent referenced by the ticket:
   - Search git history in `fhir-fork/` for `FHIR-28415`, `drt-1`, and `duration.xml` to find the commit(s) that applied the R4B resolution.
   - Inspect the historical version of `fhir-fork/source/datatypes/duration.xml` from that commit and extract the invariant fields exactly as they appeared after the accepted fix.
   - If the ticket key is absent from commit messages, fall back to `git log -S"drt-1" -- source/datatypes/duration.xml` or `git blame` on the relevant rows to locate the semantic change.
3. Compare the historical and current values field-by-field:
   - Narrative text
   - FHIRPath expression
   - XPath expression
   - Any neighboring metadata columns that influence rendering of the invariant row
4. Decide the correction target using retrieved evidence:
   - If R4B shows a coherent narrative/expression pair, treat that as the preferred source of truth for R4/R5/R6 alignment.
   - If history shows multiple transitions, prefer the latest accepted change tied to FHIR-28415 rather than intermediate edits.
   - If the history is incomplete or ambiguous, stop before editing and note the exact missing evidence in the ticket artifacts.
5. Preserve traceability in the implementation notes:
   - Record the commit hash or tag used for the historical lookup.
   - Note whether the chosen fix restores prior wording verbatim or ports only the semantic rule.

## Execution Steps
1. Open `fhir-fork/source/datatypes/duration.xml` and navigate to the Invariants worksheet rows for the Duration constraint currently stating:
   - English: `There SHALL be a code if there is a value and it SHALL be an expression of time. If system is present, it SHALL be UCUM.`
   - Expression: `code.exists() implies ((system = %ucum) and value.exists())`
2. Retrieve the historical `drt-1` values using the steps in "Historical Value Retrieval Detail" and write down the selected precedent before changing source.
3. Decide alignment direction based on the retrieved historical intent (R4B/FHIR-28415):
   - Preferred: restore or port the historically accepted semantic rule when it yields a coherent English/FHIRPath/XPath trio.
   - Alternative: if the historical record is insufficient, revise the minimum set of fields needed so the current narrative and formal expressions say the same thing.
4. Apply the chosen correction in the invariant fields for Duration only, preserving formatting and neighboring rows.
5. Verify no unrelated datatype invariants were changed.
6. Regenerate/preview the affected output (e.g., `datatypes.html#QuantityVariations`) via normal project build flow to confirm rendered invariant text/expression coherence.
7. Perform a final consistency pass to ensure English, FHIRPath expression, and XPath all communicate the same rule intent.
8. Update any example instances that now fail `drt-1` due to missing UCUM `system`/`code` when `value` is present.

## Validation Checklist
- [ ] Ticket FHIR-47129 maps to at least one concrete source file (`fhir-fork/source/datatypes/duration.xml`)
- [ ] Planned edits stay within `fhir-fork/source/`
- [ ] No unrelated formatting/tooling/build-script changes
- [ ] Historical precedent for `drt-1` is identified from a concrete commit/tag or the ambiguity is explicitly documented before editing
- [ ] Duration invariant narrative and formal expression are semantically aligned
- [ ] Affected example Duration elements include UCUM `system` and `code` when `value` is present
- [ ] Rendered/published datatypes view reflects the corrected invariant intent
- [ ] Plan remains traceable to Jira ticket intent and resolution

## Risks and Assumptions
- Risk: Ambiguity in whether the normative intent is to require `code` when `value` exists or vice versa if only expression is updated without confirming prior disposition details.
- Assumption: FHIR-28415 provides authoritative precedent for how Duration invariant semantics should read in R4/R5/R6.
- Open questions:
  - Should the correction be expression-only, narrative-only, or both to preserve backward compatibility with existing validators?
  - Is any synchronized update needed in related derived/generated artifacts beyond normal publish output?
- Open question: Which exact R4B commit, branch state, or release tag should be cited as the historical source of truth for the ported invariant values?
