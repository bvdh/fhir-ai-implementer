---
name: create-implementation-plan
description: 'Build implementation plans for FHIR Jira tickets from workgroup rollups and ticket markdown in jira/. Use when preparing single-ticket or batch technical correction plans, especially repetitive edits like spelling, abbreviation, or wording cleanup.'
argument-hint: 'jira/wg/<workgroup>.md, FHIR-XXXXX, or a ticket list'
user-invocable: true
---

# Create Implementation Plan

Create review-ready implementation plans for FHIR specification tickets in this repository by analyzing workgroup rollups and ticket markdown, then producing a consolidated plan focused on executable edits and validation.

## Use When

- Preparing a plan before editing spec content in fhir-fork/source/.
- Converting Jira ticket scope into detailed actionable implementation steps.
- Handling repetitive ticket batches where one shared approach applies.
- Needing a clear validation checklist and risk/assumption log for workgroup review.

## Inputs

- A workgroup rollup path, usually under jira/wg/.
- One ticket key (FHIR-XXXXX), or a list of ticket keys.
- Ticket markdown files under jira/open/, jira/active/, or jira/closed/.

## Output

- Markdown implementation plans stored in the ticket directory under jira/active/ by default.
- Default output naming:
  - jira/active/<ticket>/<ticket>-implementation-plan.md for ticket-key input
  - jira/active/<ticket>/<ticket>-implementation-plan.md for each ticket discovered from rollup/currentTickets scope
  - jira/wg/<batch-name>-implementation-plan.md only when explicitly requested as consolidated

## Constraints

- Do not modify specification source while planning.
- Do not create resolution/disposition artifacts in this step.
- Keep plan scope tied to ticket intent and local repository workflow.
- Default to per-ticket plans; only consolidate when explicitly requested.
- Do not execute this skill for a ticket unless ticket metadata has a non-empty `Resolution` and `Status` is `Resolved - change required` (equivalently normalized as `Resolved-change-required`).

## Workflow

1. Collect scope inputs.
2. Resolve ticket files in jira/open/, jira/active/, jira/closed/.
3. Apply ticket eligibility gate before planning:
  - Ticket `Resolution` must be present and not `Unresolved`.
  - Ticket `Status` must be `Resolved - change required` (or normalized equivalent `Resolved-change-required`).
  - If a ticket fails eligibility, do not create/update a plan for it; report it as skipped with reason `not in resolved-change-required state`.
4. If scope source is currentTickets.md, filter to unimplemented tickets only (tickets that do not already have `<ticket>-implementation-plan.md` in their ticket directory).
5. Extract per-ticket essentials:
   - Key, summary, status, resolution
   - Affected page/module hints
   - Requested change pattern (wording, abbreviation, typo, structural)
6. Classify the batch:
   - Repetitive pattern across tickets: prepare a shared implementation approach.
   - Mixed patterns: split into grouped approaches in one plan.
7. Map each ticket to likely edit surface under fhir-fork/source/.
8. Write implementation steps with clear execution order.
9. Add validation checklist, risks, and assumptions.
10. Save each per-ticket plan to jira/active/<ticket>/.
11. Report created plans and skipped tickets (with skip reason, such as already implemented or not in resolved-change-required state).

## Decision Points

- Ticket eligibility gate:
  - If `Resolution` is missing/`Unresolved` or `Status` is not `Resolved - change required`, do not execute planning for that ticket.
- Scope source:
  - If a workgroup file is provided, use it as authoritative ticket list.
  - If only ticket keys are provided, build scope directly from ticket markdown files.
  - If neither is provided, default to currentTickets.md and process only unimplemented tickets.
- Plan structure:
  - If tickets share a fix pattern, produce a consolidated table with ticket-specific page identifiers.
  - If tickets differ materially, create grouped sections per pattern.
- Output granularity:
  - Default to per-ticket plan files.
  - Create a single consolidated batch plan only on explicit request.
- Output location:
  - Default to jira/active/<ticket>/ for per-ticket plans.
  - Use jira/wg/ only for explicitly requested consolidated batch plans.

## Plan Template

Use this structure in generated plans:

```markdown
# Implementation Plan: <scope name>

## Scope Summary
- Workgroup/source:
- Tickets in scope:
- Primary fix pattern:

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|

## Shared Implementation Approach
1. Locate files under fhir-fork/source/.
2. Apply edits using consistent wording/style rules.
3. Keep changes minimal and traceable to ticket intent.

## Execution Steps
1. Step-by-step edit order
2. Cross-file consistency checks
3. Final pass for terminology alignment

## Validation Checklist
- [ ] Each ticket mapped to at least one file/page
- [ ] Planned edits stay within fhir-fork/source/
- [ ] No unrelated formatting/tooling changes
- [ ] Terminology and abbreviations are consistent
- [ ] Plan is review-ready and references ticket intent

## Risks and Assumptions
- Risk:
- Assumption:
- Open questions:
```

## Quality Criteria (Completion Checks)

A plan is complete only if all are true:

- Every in-scope ticket appears in the ticket matrix.
- Every planned ticket satisfied eligibility (`Resolution` present and `Status` = `Resolved - change required`) at planning time.
- The likely edit surface is identified for each ticket.
- The files and line-numbers likely impacted by the change have been identified.
- Implementation steps are logically ordered and actionable.
- Execution steps are specific enough to implement without reinterpretation.
- Validation checklist is actionable and repository-aware.
- Risks/assumptions capture uncertainty and escalation points.
- When scope is currentTickets.md, tickets with existing implementation plans are skipped and reported.

## Quick Invocation Examples

- /create-implementation-plan jira/wg/fmg.md
- /create-implementation-plan FHIR-51010
- /create-implementation-plan FHIR-51010,FHIR-51011,FHIR-51012
- /create-implementation-plan "tickets from currentTickets.md"

## Notes

If input scope is ambiguous, ask first:

- Which tickets are in scope?
- Do you want per-ticket files (default) or one consolidated batch plan?

If no scope source is provided, use currentTickets.md by default and generate plans only for tickets that do not already have implementation plans.

Always constrain implementation targets to fhir-fork/source/ only.

When a ticket is not present under jira/active/, ask whether to create the plan in its existing status directory or move the ticket into active first.
