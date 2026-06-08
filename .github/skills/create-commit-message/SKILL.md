---
name: create-commit-message
description: 'Generate repository-scoped commit message files for a ticket so each touched repository gets a ticket-prefixed message describing only its own changes.'
argument-hint: 'FHIR-XXXXX (optionally include touched repos: outer, fhir-fork, fhir-extensions-fork)'
user-invocable: true
---

# Create Commit Message

Generate commit message artifacts for each repository touched by a ticket implementation.

## Use When

- A ticket has changes across one or more repositories.
- You need consistent, repo-specific commit messages before running commit skills.
- You want commit text that explicitly states the ticket key and what changed in that repository.

## Inputs

- Ticket key: `FHIR-XXXXX`.
- Ticket directory: `jira/active/<ticket>/` (fallback to `jira/open/<ticket>/` or `jira/closed/<ticket>/` when needed).
- Touched repositories set (detected or provided):
  - `outer` (`fhir-ai-implementer`)
  - `fhir-fork`
  - `fhir-extensions-fork`
- Evidence sources (in priority order):
  1. `git diff --name-only` and `git diff` per repository
  2. `jira/active/<ticket>/<ticket>-implementation-change-log.md`
  3. `jira/active/<ticket>/<ticket>-implementation-plan.md`
  4. `jira/active/<ticket>/<ticket>.md`

## Outputs

Write one commit message file per touched repository under `jira/active/<ticket>/`:

- Outer repo: `jira/active/<ticket>/<ticket>-commit-message-outer.txt`
- FHIR core fork: `jira/active/<ticket>/<ticket>-commit-message-fhir-fork.txt`
- Extensions fork: `jira/active/<ticket>/<ticket>-commit-message-fhir-extensions-fork.txt`

Optional backward-compatibility file (only if another workflow explicitly requires it):

- `jira/active/<ticket>/<ticket>-commit-message.txt`

## Message Format

Each output file must use:

```text
FHIR-XXXXX: <short imperative summary of repo-scoped change>

- <repo-scoped change 1>
- <repo-scoped change 2>
- <repo-scoped change 3>
```

Rules:

- First line must start with ticket key.
- Subject must be repository-scoped and action-oriented.
- Bullets must mention only files/changes from that repository.
- Do not mention unrelated repositories in the same message file.

## Procedure

1. Resolve ticket directory and key.
2. Detect touched repositories from current diffs.
3. For each touched repository, summarize only that repo's changes.
4. Generate one message file per touched repository using the format above.
5. If no changes are detected for a repository, do not create a message file for it.
6. Return the list of generated files.

## Decision Points

- If only one repository is touched, generate only one file.
- If no repository changes are detected, stop and report no commit-message artifacts generated.
- If change evidence is incomplete, use explicit placeholders in bullets and mark for user review.

## Completion Checks

- Each touched repository has exactly one corresponding commit message file.
- Each subject is ticket-prefixed and repo-scoped.
- Bullets reference only changes from that repository.
- Generated files are saved in `jira/active/<ticket>/`.
