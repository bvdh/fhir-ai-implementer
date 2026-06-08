---
name: execute-implementation-plan
description: 'Execute a ticket implementation plan by applying approved source edits in fhir-fork/source/, validating results, and writing commit-message and change-log files in jira/active/<ticket>/. Use for FHIR technical correction implementation after planning.'
argument-hint: 'FHIR-XXXXX or path to <ticket>-implementation-plan.md'
user-invocable: true
---

# Execute Implementation Plan

Execute an approved implementation plan for a FHIR Jira ticket, make minimal source edits, validate those edits, and produce ticket-local implementation artifacts.

## Use When

- A per-ticket implementation plan already exists and is ready to execute.
- You need to apply the plan in `fhir-fork/source/` with minimal, traceable changes.
- You want generated commit text and a change log stored in the ticket directory under `jira/active/<ticket>/`.

## Inputs

- Ticket key (`FHIR-XXXXX`) or explicit plan path.
- Plan file (expected default): `jira/active/<ticket>/<ticket>-implementation-plan.md`.
- Ticket metadata file: `jira/active/<ticket>/<ticket>.md`.

## Outputs

- Source edits limited to `fhir-fork/source/`.
- Commit message file in ticket directory:
  - `jira/active/<ticket>/<ticket>-commit-message.txt`
- Change log file in ticket directory:
  - `jira/active/<ticket>/<ticket>-implementation-change-log.md`
- Pattern proposal in the change log when a new reusable `fhir-fork` editing pattern is observed:
  - Describe the pattern and where it appeared.
  - Propose concrete instruction text for `.github/instructions/fhir-fork.instructions.md`.
- No automatic `git commit` by default; this skill prepares commit text for user-driven commit flow.

## Constraints

- Do not modify files outside `fhir-fork/source/` for implementation edits.
- Do not change build tooling, scripts, Gradle config, CI pipelines, or implementation code unless explicitly requested.
- Keep edits minimal and tied directly to ticket intent and plan scope.
- If plan scope is ambiguous, stop and clarify before editing.
- Do not execute this skill unless the ticket metadata has a non-empty `Resolution` and `Status` is `Resolved - change required` (equivalently normalized as `Resolved-change-required`).
- If the implementation plan is owned by `fhir-extensions-fork`, use the same working branch name there as the current `fhir-fork` branch unless the user explicitly overrides this.

## Workflow

1. Resolve ticket and plan paths.
2. Read ticket metadata and verify execution eligibility:
  - `Resolution` must be present and not `Unresolved`.
  - `Status` must be `Resolved - change required` (or normalized equivalent `Resolved-change-required`).
  - If either check fails, stop immediately and report that the skill cannot execute for this ticket state.
3. Read the implementation plan and extract:
   - Target files
   - Intended changes
   - Validation steps
4. Determine the owning source repository from the plan:
  - If the plan targets `fhir-fork/source/`, execute there.
  - If the plan targets `fhir-extensions-fork`, execute there.
  - If both repos are involved, map each planned edit to its owning repo before editing.
5. If `fhir-extensions-fork` is involved, compare its current branch name to `fhir-fork`:
  - If `fhir-fork` already has a non-default working branch, create or switch `fhir-extensions-fork` to the same branch name before editing unless the user explicitly requests otherwise.
  - If no working branch exists yet, ask the user to confirm branch strategy before execution.
6. Validate target files are under the allowed source area for the owning repo.
7. Apply edits exactly as planned with minimal diff.
8. Run plan-specified validation (or targeted checks when not specified), such as:
   - String/term searches for expected replacement
   - Spot checks around edited sections
   - Diff review for scope control
9. Gather implementation evidence:
   - Files changed
   - Before/after snippets (concise)
   - Validation outcomes
10. Detect reusable pattern candidates during execution:
  - Look for recurring edit forms (e.g., extension-link format checks, repeated ownership-token updates, recurring terminology normalization).
  - Treat a pattern as relevant when it is likely to recur across tickets and can be turned into a clear rule.
11. If a new relevant pattern is detected, add a proposal section to the change log:
  - `## Proposed Instruction Update`
  - `Pattern observed:` <short description>
  - `Suggested addition to .github/instructions/fhir-fork.instructions.md:` <ready-to-paste bullets>
12. Write commit message file.
13. Write implementation change log file.
14. Do not commit automatically unless explicitly requested.
15. Confirm completion criteria.

## Plan Conformance Guardrails (Required)

Before applying edits, build an execution manifest from the implementation plan:
- Ticket key in scope
- Owning repository per changed file
- Allowed file paths
- Allowed edit intents per file
- Required evidence source for wording (resolution text or explicit user-approved sentence)

Hard stop rules:
- If ticket `Resolution` is missing/`Unresolved` or `Status` is not `Resolved - change required`, do not execute this skill.
- If ticket metadata shows `Resolution: Unresolved` and no explicit approved wording is provided, do not edit source.
- If `fhir-extensions-fork` is part of the task and is not on the same working branch name as `fhir-fork`, switch/create the matching branch first unless the user explicitly overrides this.
- If a proposed edit introduces content not listed in the plan's edit intent, stop and ask to revise the plan first.
- If changed text semantically matches a different ticket's resolution/comments more than the in-scope ticket, stop and ask whether scope changed.

Post-edit conformance checks (must pass):
- Every diff hunk maps to a specific plan step.
- Every changed file is listed in the plan.
- If any hunk is unmapped, revert that hunk and request plan update/approval.

## Decision Points

- Ticket eligibility gate:
  - If `Resolution` is missing/`Unresolved` or `Status` is not `Resolved - change required`, stop and report non-executable state.

- Plan path resolution:
  - If ticket key is provided, use `jira/active/<ticket>/<ticket>-implementation-plan.md`.
  - If explicit plan path is provided, infer ticket key from path/content.
- Branch alignment:
  - If the plan is executed in `fhir-extensions-fork` and `fhir-fork` is already on a task branch, use that same branch name in `fhir-extensions-fork` by default.
  - If the user explicitly asks for a different branch strategy, follow the user override and document it in the change log notes.
- Missing plan:
  - If plan file is missing, stop and ask whether to generate the plan first.
- Non-active ticket directory:
  - If ticket exists outside `jira/active/`, ask whether to proceed there or move/duplicate into active.
- Validation depth:
  - If plan includes explicit checks, follow them.
  - If not, run targeted search + localized content verification + diff review.
- Pattern proposal threshold:
  - If the pattern is one-off or purely ticket-specific, do not propose instruction changes.
  - If the pattern is repeatable and policy-like, include the proposed instruction update in the change log.

## Commit Message File Format

Write `jira/active/<ticket>/<ticket>-commit-message.txt` as:

```text
FHIR-XXXXX: <short imperative summary>

- <key change 1>
- <key change 2>
- <key change 3>
```

Guidance:
- First line starts with ticket key.
- Keep subject concise and action-oriented.
- Bullet points summarize only implemented plan items.

## Change Log File Format

Write `jira/active/<ticket>/<ticket>-implementation-change-log.md` with:

```markdown
# Implementation Change Log: FHIR-XXXXX

## Summary
- Plan: jira/active/FHIR-XXXXX/FHIR-XXXXX-implementation-plan.md
- Ticket: jira/active/FHIR-XXXXX/FHIR-XXXXX.md
- Execution date: <YYYY-MM-DD>

## Files Changed
- fhir-fork/source/<path>

## Changes Applied
1. <what changed>
2. <what changed>

## Validation Performed
- <check 1>: PASS/FAIL
- <check 2>: PASS/FAIL

## Plan Conformance
- Mapped hunks: <X>/<Y>
- <file>:<line> -> <plan step> -> <evidence source>

## Notes
- <assumptions/limits/open follow-ups>
```

## Quality Criteria (Completion Checks)

Execution is complete only if all are true:

- Plan and ticket were resolved to the same ticket key.
- Ticket `Resolution` was present and `Status` was `Resolved - change required` before execution started.
- All implementation edits are inside the planned owning source area (`fhir-fork/source/` or the planned `fhir-extensions-fork` location).
- If `fhir-extensions-fork` was used, its branch name matched the active `fhir-fork` task branch unless the user explicitly overrode that rule.
- Diff contains only intended plan-aligned changes.
- Every diff hunk is mapped to a plan step and evidence source in `## Plan Conformance`.
- Validation checks are documented with outcomes.
- Commit message file exists in `jira/active/<ticket>/`.
- Implementation change log file exists in `jira/active/<ticket>/`.

## Quick Invocation Examples

- /execute-implementation-plan FHIR-53788
- /execute-implementation-plan jira/active/FHIR-53788/FHIR-53788-implementation-plan.md

## Notes

If `fhir-fork` already has a task branch and the plan also uses `fhir-extensions-fork`, use the same branch name in `fhir-extensions-fork` unless the user explicitly asks for a different strategy.

If no branch is prepared in either fork, ask the user to confirm branch strategy before execution.

Default log detail level is concise: summary, files changed, and validation outcomes.

When present, keep `## Proposed Instruction Update` concise and actionable so it can be reviewed and applied directly.
