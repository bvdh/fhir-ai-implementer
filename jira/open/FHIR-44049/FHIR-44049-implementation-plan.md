# Implementation Plan: FHIR-44049

## Scope Summary
- Workgroup/source: FHIR Infrastructure; jira/active/FHIR-44049/FHIR-44049.md
- Tickets in scope: FHIR-44049
- Primary fix pattern: Correct publication/rendering drift for Datatypes page metadata/navigation and link blocks

## Determined Cause
- The reported issue is most likely caused by an out-of-sync published artifact for `https://hl7.org/fhir/6.0.0-ballot1/datatypes.html`, not by current local source syntax.
- Evidence from direct comparison:
  - Remote ballot page currently shows an older top metadata row using Modeling and Methodology + Partially Normative and includes R4 conversion tab links.
  - Local regenerated `publish/datatypes.html` from current `source/datatypes.html` shows FHIR Infrastructure + Normative and updated extension-link structure without the old R4 conversion tab in the same location.
  - Link targets in both contexts are reachable (HTTP 200), so the practical defect aligns more with stale/incorrectly assembled rendered content than dead links.
- Working conclusion for implementation: resolve by reconciling generated Datatypes page output with source-intended structure; apply source edits only if the source is proven incorrect during execution.

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-44049 | Format on data types page is faulty | Resolved - change required (Persuasive) | datatypes (primary), generated publish artifact | Publication/rendering reconciliation | Remote ballot rendering differs from local source-generated rendering in metadata/nav/link sections |

## Shared Implementation Approach
1. Validate whether current source already produces correct Datatypes rendering locally.
2. Isolate exact divergence points between remote ballot artifact and local publish output.
3. Apply the minimal correction at source/include level only when divergence is traceable to source content.
4. If source is already correct, record no-op source path and document publication artifact drift for release/publish reconciliation.

## Execution Steps
1. Baseline source and generated output:
   - Inspect `fhir-fork/source/datatypes.html` sections controlling:
     - top owner/status row
     - Datatypes tab list (Examples / Detailed Descriptions / Mappings / Profiles / Extensions)
     - datatype "See also" link blocks
   - Regenerate output (`./gradlew publish`) and review `fhir-fork/publish/datatypes.html`.
2. Remote-vs-local comparison (cause confirmation):
   - Compare key markers in remote ballot page vs local publish page:
     - owner/status row content
     - nav tabs and presence/absence of R4 conversion entries
     - extension link URL pattern and attributes
   - Capture exact evidence lines in change log.
3. Conditional remediation path:
   - Path A (source mismatch found):
     - Edit only the responsible file(s) under `fhir-fork/source/`.
     - Keep change tightly scoped to malformed/outdated Datatypes metadata/nav/link markup.
   - Path B (source already correct; publication drift):
     - No source edit.
     - Document that ticket is satisfied by publication reconciliation evidence and mark as no-op source implementation.
4. Rebuild and verify:
   - Re-run publish and verify `publish/datatypes.html` layout is structurally correct in the affected regions.
   - Confirm all Datatypes page links involved in the reported issue resolve correctly.
5. Produce ticket artifacts:
   - `jira/active/FHIR-44049/FHIR-44049-implementation-change-log.md`
   - `jira/active/FHIR-44049/FHIR-44049-commit-message.txt`
   - Include explicit statement of which path (A or B) was executed.

## Validation Checklist
- [ ] Root cause classification recorded: source defect vs publication artifact drift
- [ ] Remote and local Datatypes marker comparison captured (owner/status, tabs, extension links)
- [ ] If edits are required, changes are confined to `fhir-fork/source/`
- [ ] Rebuilt `publish/datatypes.html` reflects intended metadata/nav/link structure
- [ ] Affected links return successful responses and open expected targets
- [ ] No unrelated formatting/tooling/script changes were introduced
- [ ] Execution path (A source fix or B no-op source) is explicitly documented

## Risks and Assumptions
- Risk: Root cause may be in publication pipeline/template composition outside direct Datatypes source file ownership.
- Risk: Ballot-hosted content can lag behind source fixes, creating false positives during local verification.
- Assumption: `source/datatypes.html` plus standard build pipeline are sufficient to reproduce intended Datatypes output.
- Assumption: Ticket scope remains limited to Datatypes formatting/link behavior and does not require broad style-system changes.
- Open question: Which exact browser/view context originally showed truncation (desktop/mobile, zoom, or stylesheet load failure) is not preserved in Jira comments.
