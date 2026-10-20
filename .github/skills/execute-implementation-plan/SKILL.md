---
name: execute-implementation-plan
description: 'Execute a ticket implementation plan by applying approved source edits in fhir-repo/source/, validating results, and writing commit-message, change-log, and suggested Jira Applied comment files in jira/active/<ticket>/. Use for FHIR technical correction implementation after planning.'
argument-hint: 'FHIR-XXXXX or path to <ticket>-implementation-plan.md'
user-invocable: true
---

# Execute Implementation Plan

Execute an approved implementation plan for a FHIR Jira ticket, make minimal source edits, validate those edits, and produce ticket-local implementation artifacts.

## Use When

- A per-ticket implementation plan already exists and is ready to execute.
- You need to apply the plan in `fhir-repo/source/` with minimal, traceable changes.
- You want generated commit text and a change log stored in the ticket directory under `jira/active/<ticket>/`.

## Inputs

- Ticket key (`FHIR-XXXXX`) or explicit plan path.
- Plan file (expected default): `jira/active/<ticket>/<ticket>-implementation-plan.md`.
- Ticket metadata file: `jira/active/<ticket>/<ticket>.md`.

## Outputs

- Source edits limited to `fhir-repo/source/`.
- Repository-scoped commit message files in ticket directory (generated via `create-commit-message`):
  - `jira/active/<ticket>/<ticket>-commit-message-outer.txt` (when outer repo is touched)
  - `jira/active/<ticket>/<ticket>-commit-message-fhir-repo.txt` (when `fhir-repo` is touched)
  - `jira/active/<ticket>/<ticket>-commit-message-fhir-extensions-fork.txt` (when `fhir-extensions-fork` is touched)
- Change log file in ticket directory:
  - `jira/active/<ticket>/<ticket>-implementation-change-log.md`
- Suggested Jira comment, generated after validation; for `fhir-repo` source changes, finalized with actual commit links after commit and push:
  - `jira/active/<ticket>/<ticket>-jira-applied-comment.txt`
- Pattern proposal in the change log when a new reusable `fhir-repo` editing pattern is observed:
  - Describe the pattern and where it appeared.
  - Propose concrete instruction text for `.github/instructions/fhir-repo.instructions.md`.
- No automatic `git commit` by default; this skill prepares commit text for user-driven commit flow.

## Constraints

- Do not modify files outside `fhir-repo/source/` for implementation edits.
- Do not change build tooling, scripts, Gradle config, CI pipelines, or implementation code unless explicitly requested.
- Keep edits minimal and tied directly to ticket intent and plan scope.
- If plan scope is ambiguous, stop and clarify before editing.
- Execution gate for ticket metadata:
  - Standard rule: `Resolution` must be non-empty and not `Unresolved`, and `Status` must be `Resolved - change required` (equivalently normalized as `Resolved-change-required`).
  - Technical Correction exception (direct resolution): if `Issue Type` is `Technical Correction`, execution may proceed with `Resolution: Unresolved` only when wording to apply is explicit in the approved plan or ticket description.
- If the implementation plan is owned by `fhir-extensions-fork`, use the same working branch name there as the current `fhir-repo` branch unless the user explicitly overrides this.

## Workflow

1. Resolve ticket and plan paths.
2. Read ticket metadata and verify execution eligibility:
  - `Status` must be `Resolved - change required` (or normalized equivalent `Resolved-change-required`).
  - For non-Technical-Correction tickets: `Resolution` must be present and not `Unresolved`.
  - For `Issue Type: Technical Correction`: allow `Resolution: Unresolved` only when wording to apply is explicit in the approved plan or ticket description.
  - If these checks fail, stop immediately and report that the skill cannot execute for this ticket state.
3. Read the implementation plan and extract:
   - Target files
   - Intended changes
   - Validation steps
4. Determine the owning source repository from the plan:
  - If the plan targets `fhir-repo/source/`, execute there.
  - If the plan targets `fhir-extensions-fork`, execute there.
  - If both repos are involved, map each planned edit to its owning repo before editing.
5. If `fhir-extensions-fork` is involved, compare its current branch name to `fhir-repo`:
  - If `fhir-repo` already has a non-default working branch, create or switch `fhir-extensions-fork` to the same branch name before editing unless the user explicitly requests otherwise.
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
  - `Suggested addition to .github/instructions/fhir-repo.instructions.md:` <ready-to-paste bullets>
12. Invoke `create-commit-message` to generate repository-scoped commit message file(s).
13. Write implementation change log file.
14. Once the required validation and plan-conformance checks pass, generate a suggested Jira comment for the user to add when marking the ticket as Applied, following the Jira Applied Comment Artifact Format below. For `fhir-repo` source changes, finalize it with actual commit links only after those commits have been committed and pushed; until then, label it as a draft in the completion response.
15. Do not commit, post the comment, or change Jira status automatically unless explicitly requested.
16. Confirm completion criteria and link the suggested Jira comment in the completion response.

## Plan Conformance Guardrails (Required)

Before applying edits, build an execution manifest from the implementation plan:
- Ticket key in scope
- Owning repository per changed file
- Allowed file paths
- Allowed edit intents per file
- Required evidence source for wording (resolution text, or explicit wording in approved plan or ticket description)

Hard stop rules:
- If `Status` is not `Resolved - change required`, do not execute this skill.
- If ticket is not `Technical Correction` and `Resolution` is missing/`Unresolved`, do not execute this skill.
- If ticket is `Technical Correction` with `Resolution: Unresolved` and no explicit approved wording is provided by plan or ticket description, do not edit source.
- If `fhir-extensions-fork` is part of the task and is not on the same working branch name as `fhir-repo`, switch/create the matching branch first unless the user explicitly overrides this.
- If a proposed edit introduces content not listed in the plan's edit intent, stop and ask to revise the plan first.
- If changed text semantically matches a different ticket's resolution/comments more than the in-scope ticket, stop and ask whether scope changed.

Post-edit conformance checks (must pass):
- Every diff hunk maps to a specific plan step.
- Every changed file is listed in the plan.
- If any hunk is unmapped, revert that hunk and request plan update/approval.

## Decision Points

- Ticket eligibility gate:
  - If `Status` is not `Resolved - change required`, stop and report non-executable state.
  - If ticket is not `Technical Correction` and `Resolution` is missing/`Unresolved`, stop and report non-executable state.
  - If ticket is `Technical Correction` with `Resolution: Unresolved`, allow execution only when direct-resolution wording is explicit in the approved plan or ticket description.

- Plan path resolution:
  - If ticket key is provided, use `jira/active/<ticket>/<ticket>-implementation-plan.md`.
  - If explicit plan path is provided, infer ticket key from path/content.
- Branch alignment:
  - If the plan is executed in `fhir-extensions-fork` and `fhir-repo` is already on a task branch, use that same branch name in `fhir-extensions-fork` by default.
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

## Commit Message Artifact Format

Generate repository-scoped commit message files via `create-commit-message` using this format per touched repository:

```text
FHIR-XXXXX: <short imperative summary>

- <key change 1>
- <key change 2>
- <key change 3>
```

Guidance:
- First line starts with ticket key.
- Keep subject concise, action-oriented, and repository-scoped.
- Bullet points summarize only implemented items in that repository.

## Jira Applied Comment Artifact Format

Write `jira/active/<ticket>/<ticket>-jira-applied-comment.txt` as concise, ready-to-paste plain text, without an internal heading or instructions to the user.

- Summarize the implemented resolution and affected specification page or artifact.
- State the validation performed and any relevant limitations; do not claim a build ran if it did not.
- For a plan-permitted verification-only outcome, explicitly state that the requested result is already present, identify the evidence checked, and explain why no source edit was necessary. Do not describe this as a newly applied source correction.
- For `fhir-repo` source changes, include links to every actual pushed `fhir-repo` commit implementing this ticket. Verify each commit's ticket scope and remote availability before including its URL. Do not substitute a PR URL, a commit-message file link, or an outer-repository commit link.
- If the relevant `fhir-repo` commits have not yet been committed and pushed, the comment remains a draft, not ready to paste when marking Applied. Refresh it with verified commit URLs after an explicitly requested commit/push workflow; generating this artifact does not authorize committing or pushing.
- For a verification-only outcome with no `fhir-repo` source change, explicitly state that no new `fhir-repo` commit was required; do not manufacture a commit solely to provide a link. This case does not require commit links.
- Do not invent links, include local paths, or claim changes are committed, merged, published, or that Jira status has changed without evidence.
- Generate this artifact only when the plan's required checks pass. If implementation or validation is blocked or incomplete, report the blocker instead of suggesting the ticket is ready for Applied.
- This is a suggested comment for a later user-driven status transition, not authorization to bypass PR/merge requirements in the repository workflow.

## Change Log File Format

Write `jira/active/<ticket>/<ticket>-implementation-change-log.md` with:

```markdown
# Implementation Change Log: FHIR-XXXXX

## Summary
- Plan: jira/active/FHIR-XXXXX/FHIR-XXXXX-implementation-plan.md
- Ticket: jira/active/FHIR-XXXXX/FHIR-XXXXX.md
- Execution date: <YYYY-MM-DD>

## Files Changed
- fhir-repo/source/<path>

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
- Ticket `Status` was `Resolved - change required` before execution started.
- One of the following was true before execution started:
  - `Resolution` was present and not `Unresolved`; or
  - Ticket `Issue Type` was `Technical Correction` and direct-resolution wording was explicit in plan or ticket description.
- All implementation edits are inside the planned owning source area (`fhir-repo/source/` or the planned `fhir-extensions-fork` location).
- If `fhir-extensions-fork` was used, its branch name matched the active `fhir-repo` task branch unless the user explicitly overrode that rule.
- Diff contains only intended plan-aligned changes.
- Every diff hunk is mapped to a plan step and evidence source in `## Plan Conformance`.
- Validation checks are documented with outcomes.
- Repository-scoped commit message file(s) exist in `jira/active/<ticket>/` for each touched repository.
- Implementation change log file exists in `jira/active/<ticket>/`.
- Suggested Jira Applied comment file exists in `jira/active/<ticket>/` and accurately reflects the verified outcome without unsupported readiness, merge, or publication claims. For `fhir-repo` source changes, it contains verified links to the actual pushed implementation commits, or is explicitly reported as a draft awaiting commit and push.

## Quick Invocation Examples

- /execute-implementation-plan FHIR-53788
- /execute-implementation-plan jira/active/FHIR-53788/FHIR-53788-implementation-plan.md

## Notes

If `fhir-repo` already has a task branch and the plan also uses `fhir-extensions-fork`, use the same branch name in `fhir-extensions-fork` unless the user explicitly asks for a different strategy.

If no branch is prepared in either fork, ask the user to confirm branch strategy before execution.

Default log detail level is concise: summary, files changed, and validation outcomes.

When present, keep `## Proposed Instruction Update` concise and actionable so it can be reviewed and applied directly.
