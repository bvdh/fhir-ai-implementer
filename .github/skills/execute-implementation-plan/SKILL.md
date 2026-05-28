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

## Workflow

1. Resolve ticket and plan paths.
2. Read the implementation plan and extract:
   - Target files
   - Intended changes
   - Validation steps
3. Validate target files are under `fhir-fork/source/`.
4. Apply edits exactly as planned with minimal diff.
5. Run plan-specified validation (or targeted checks when not specified), such as:
   - String/term searches for expected replacement
   - Spot checks around edited sections
   - Diff review for scope control
6. Gather implementation evidence:
   - Files changed
   - Before/after snippets (concise)
   - Validation outcomes
7. Detect reusable pattern candidates during execution:
  - Look for recurring edit forms (e.g., extension-link format checks, repeated ownership-token updates, recurring terminology normalization).
  - Treat a pattern as relevant when it is likely to recur across tickets and can be turned into a clear rule.
8. If a new relevant pattern is detected, add a proposal section to the change log:
  - `## Proposed Instruction Update`
  - `Pattern observed:` <short description>
  - `Suggested addition to .github/instructions/fhir-fork.instructions.md:` <ready-to-paste bullets>
9. Write commit message file.
10. Write implementation change log file.
11. Do not commit automatically unless explicitly requested.
12. Confirm completion criteria.

## Decision Points

- Plan path resolution:
  - If ticket key is provided, use `jira/active/<ticket>/<ticket>-implementation-plan.md`.
  - If explicit plan path is provided, infer ticket key from path/content.
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

## Notes
- <assumptions/limits/open follow-ups>
```

## Quality Criteria (Completion Checks)

Execution is complete only if all are true:

- Plan and ticket were resolved to the same ticket key.
- All implementation edits are inside `fhir-fork/source/`.
- Diff contains only intended plan-aligned changes.
- Validation checks are documented with outcomes.
- Commit message file exists in `jira/active/<ticket>/`.
- Implementation change log file exists in `jira/active/<ticket>/`.

## Quick Invocation Examples

- /execute-implementation-plan FHIR-53788
- /execute-implementation-plan jira/active/FHIR-53788/FHIR-53788-implementation-plan.md

## Notes

If no branch is prepared, ask the user to confirm branch strategy before execution.

Default log detail level is concise: summary, files changed, and validation outcomes.

When present, keep `## Proposed Instruction Update` concise and actionable so it can be reviewed and applied directly.
