# Implementation Plan: FHIR-44049

## Scope Summary
- Workgroup/source: Direct ticket scope from FHIR-44049 in jira/active/FHIR-44049/FHIR-44049.md
- Tickets in scope: FHIR-44049
- Primary fix pattern: Datatypes page rendering/link integrity triage with minimal source correction only if a reproducible source defect is confirmed

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-44049 | Format on data types page is faulty | Resolved - change required | Datatypes | Structural formatting/link robustness | Jira comments indicate truncation/no footer in hosted page, while local render may differ |

## Shared Implementation Approach
1. Reproduce the reported behavior on generated output before changing source.
2. Pinpoint divergence between hosted page behavior and locally generated page behavior.
3. Apply the smallest source-only correction under fhir-fork/source if and only if a source-level defect is identified.
4. If no source defect is reproducible, document publication/environment drift and implement a no-op source path.

## Likely Edit Surface (Files and Lines)
- fhir-fork/source/datatypes.html:1640
  - Nonstandard inline tag usage (count marker uses cod tag) in Timing narrative; verify whether this contributes to malformed rendering in some contexts.
- fhir-fork/source/datatypes.html:1738
  - Transition from Timing section usage block to RelativeTime section; verify markup continuity where truncation was observed.
- fhir-fork/source/datatypes.html:1741
  - RelativeTime section anchor and heading start; verify section boundary and linkability.
- fhir-fork/source/datatypes.html:1842
  - Anchor for open type section; ensure anchor/link navigation remains stable.
- fhir-fork/source/datatypes.html:1864
  - Reused anchor name for later section; assess whether duplicate anchor names affect link behavior.
- fhir-fork/source/datatypes.html:1888
  - Footer include marker ([%file newfooter%]); confirm generated page includes footer when published.
- fhir-fork/source/datatypes.html:1890
  - Script bootstrap for tabs/navigation; verify script placement does not interfere with footer or end-of-page rendering.

## Execution Steps
1. Baseline the ticket intent from jira/active/FHIR-44049/FHIR-44049.md and establish expected outcomes:
   - page should not appear truncated
   - footer should render
   - in-page and cross-page links should work
2. Generate and inspect local output:
   - run ./gradlew publish from fhir-fork
   - inspect publish/datatypes.html for end-of-document integrity and footer presence
3. Perform targeted source review at the listed line hotspots in fhir-fork/source/datatypes.html.
4. Compare local generated behavior with reported hosted behavior:
   - if local and hosted differ but source is internally consistent, classify as publication/environment drift
   - if source defect is reproducible locally, proceed with minimal source edit
5. Conditional implementation path:
   - Path A (source defect confirmed):
     - fix only the confirmed root-cause markup/link issue in fhir-fork/source/datatypes.html
     - keep edits narrowly scoped and traceable to FHIR-44049
   - Path B (no source defect confirmed):
     - do not modify fhir-fork/source
     - document no-op source outcome and evidence in ticket execution artifacts
6. Re-run publish and verify:
   - footer present and page end renders normally
   - link targets around affected anchors resolve as expected
7. Prepare execution artifacts in jira/active/FHIR-44049:
   - FHIR-44049-implementation-change-log.md
   - FHIR-44049-commit-message.txt

## Validation Checklist
- [ ] Ticket mapped to concrete datatypes source line targets
- [ ] Reproduction attempt completed on local generated output
- [ ] Root cause classified as source defect or publication/environment drift
- [ ] Any planned edits remain strictly within fhir-fork/source/
- [ ] Footer rendering and end-of-page integrity verified after publish
- [ ] Relevant links/anchors validated in affected sections
- [ ] Plan remains review-ready and tied directly to ticket intent

## Risks and Assumptions
- Risk: Hosted ballot artifact may be stale or assembled differently, masking the true source of the issue.
- Risk: Applying speculative source edits without local reproduction can introduce unrelated regressions.
- Risk: Anchor/link behavior can vary across rendering contexts and browsers.
- Assumption: fhir-fork/source/datatypes.html is the primary source surface for this ticket.
- Assumption: publish output from current branch is representative for source-level validation.
- Open questions:
  - Is there a reproducible hosted-only environment factor causing truncation that source edits cannot address?
  - Should duplicate anchor names in datatypes.html be normalized proactively if they are not the root cause?
