# Implementation Plan: FHIR-44645

## Scope Summary

- Workgroup/source: FHIR Infrastructure; jira/active/FHIR-44645/FHIR-44645.md
- Tickets in scope: FHIR-44645
- Primary fix pattern: HumanName anchor/link validation and minimal correction only if missing

## Ticket Summary

- Ticket: FHIR-44645
- Summary: HumanName anchor isn't working
- Status: Resolved - change required (Persuasive)
- Target pages: datatypes, datatypes-definitions, generated publish output
- Re-execution focus: verify current branch state, then apply a minimal source fix only if a reproducible anchor gap is found

## Determined Cause (Planning Analysis)

- Prior implementation artifacts were not aligned to the ticket intent and described primitive-table edits instead of HumanName anchor behavior.
- Current source already defines HumanName anchors in both relevant pages:
  - source/datatypes.html
  - source/datatypes-definitions.html
- Current generated output also contains HumanName anchor aliases, including name="HumanName" and name="humanname", indicating no missing-anchor defect in the checked build.
- Re-execution should validate behavior and only change source if a reproducible missing-anchor path is found.

## Shared Implementation Approach

1. Validate source and generated output for HumanName anchors and inbound links.
2. Apply source edits only if validation identifies a concrete missing or incorrect anchor target.
3. Keep edits minimal and limited to fhir-fork/source/.

## Execution Steps

1. Baseline source anchor declarations.
   - Confirm source/datatypes-definitions.html contains:
       - `<a name="HumanName"></a>`
       - `<a name="humanname"></a>`
   - Confirm source/datatypes.html contains corresponding HumanName anchors in the base definition section.
2. Baseline generated output.
   - Confirm publish/datatypes-definitions.html contains name="HumanName" and name="humanname".
   - Confirm publish/datatypes.html links to datatypes-definitions.html#HumanName for the HumanName detailed descriptions path.
3. Apply fix only if needed.
   - If any anchor checks fail, add or repair missing anchor declaration(s) in fhir-fork/source/datatypes-definitions.html only.
4. Rebuild only when needed.
   - If source is edited or publish output is stale or missing, run ./gradlew publish once and re-check the same anchors.
5. Record ticket artifacts after re-execution.
   - jira/active/FHIR-44645/FHIR-44645-implementation-change-log.md
   - jira/active/FHIR-44645/FHIR-44645-commit-message.txt

## Validation Checklist

- [x] HumanName anchor exists in source/datatypes-definitions.html
- [x] Lowercase HumanName alias exists in source/datatypes-definitions.html
- [x] HumanName anchor exists in generated publish/datatypes-definitions.html
- [x] Generated publish/datatypes.html contains inbound link to datatypes-definitions.html#HumanName
- [x] No source correction was required after re-validation
- [x] Plan remains directly traceable to jira/active/FHIR-44645/FHIR-44645.md

## Risks and Assumptions

- Risk: The original Jira report may have referred to an older published snapshot and may not be reproducible in the current branch state.
- Risk: Browser caching or client-side anchor handling can still create user-specific jump behavior not visible in static file inspection.
- Assumption: Current publish/ artifacts are sufficiently current for re-validation in this workspace.
- Assumption: Ticket intent is anchor-jump correctness for HumanName, not unrelated Datatypes content changes.
