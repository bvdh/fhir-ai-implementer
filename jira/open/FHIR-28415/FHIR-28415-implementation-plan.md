# Implementation Plan: FHIR-28415

## Scope Summary
- Workgroup/source: Direct ticket-key input (FHIR-28415)
- Tickets in scope: FHIR-28415
- Primary fix pattern: Duration invariant consistency (`drt-1`) between narrative and formal expressions

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-28415 | Align Duration `drt-1` semantics so formal constraints match intended rule | Metadata not available locally (ticket markdown missing) | `datatypes.html#QuantityVariations` (generated), source in `fhir-fork/source/datatypes/duration.xml` | Technical correction (invariant semantics) | Use historical evidence carefully; prior commits may bundle other tickets |

## Shared Implementation Approach
1. Constrain all edits to `fhir-fork/source/`.
2. Update only Duration `drt-1` fields needed to restore semantic consistency.
3. Validate generated output and examples without broad refactoring.

## Likely Edit Surface
- Primary source-of-truth: `fhir-fork/source/datatypes/duration.xml`
- Validation targets after change:
  - Generated page section: `publish/datatypes.html` (`#QuantityVariations`)
  - Example resources containing `Duration` values to ensure they satisfy the invariant

## Execution Steps
1. Baseline and history verification
   - Capture current `drt-1` narrative, FHIRPath, and XPath from `fhir-fork/source/datatypes/duration.xml`.
   - Retrieve historical reference(s) for FHIR-28415-related behavior using git history and confirm the intended semantic direction.
2. Apply targeted source update
   - Edit only the Duration `drt-1` row in `fhir-fork/source/datatypes/duration.xml`.
   - Ensure FHIRPath and XPath both encode the same condition as the narrative.
3. Consistency checks in source
   - Search for stale inverse logic (for example, `code.exists() implies ... value.exists()`) and ensure it is not left behind for Duration.
   - Confirm no unintended edits outside the specific Duration invariant row.
4. Build-time validation
   - Run publish/build validation and inspect errors tied to Duration invariants.
   - If example validation failures occur due to stricter Duration semantics, patch only affected example files under `fhir-fork/source/` with minimal UCUM-compliant fields.
5. Traceability artifact updates (implementation phase)
   - Update `jira/active/FHIR-28415/` change-log and commit-message artifacts to reflect exact files and rationale.

## Validation Checklist
- [ ] Ticket mapped to concrete source target(s)
- [ ] Planned edits stay within `fhir-fork/source/`
- [ ] Duration `drt-1` narrative, FHIRPath, and XPath are semantically aligned
- [ ] No unrelated tooling/formatting/build-script changes
- [ ] Any example-file follow-up edits are minimal and justified by validation output
- [ ] Generated/published output reflects corrected Duration constraint behavior
- [ ] Plan is review-ready and traceable to ticket intent

## Risks and Assumptions
- Risk: Local Jira markdown for FHIR-28415 is absent, so status/resolution metadata cannot be confirmed from repository ticket exports.
- Risk: Historical commits can include multiple ticket scopes; accidental over-application is possible if boundaries are not enforced.
- Assumption: FHIR-28415 intent is centered on Duration `drt-1` consistency.
- Open question: Should Jira metadata for FHIR-28415 be synced into `jira/` before implementation for stronger traceability?
