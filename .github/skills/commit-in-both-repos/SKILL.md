---
name: commit-in-both-repos
description: 'Commit changes in both the outer ticket repository and the nested fhir-fork repository. Use when a workflow spans ticket metadata/artifacts in the outer repo and specification source changes in fhir-fork/source/.'
argument-hint: 'Ticket key or short description of the paired commit task'
---

# Commit in Both Repos

Use this skill when a task produces changes in two related worktrees:

- the outer `fhir-ai-implementer` repository for ticket tracking, plans, logs, and status moves
- the nested `fhir-fork` repository for specification source edits under `fhir-fork/source/`

## When to Use

- A ticket has been planned and implemented across both repositories.
- You need separate commits for source edits and ticket/workflow artifacts.
- You want to preserve unrelated pre-existing worktree changes outside the task scope.
- You need a repeatable commit-and-verify routine for FHIR ticket work.

## Core Principles

1. Keep repository scopes separate.
2. Commit only the files relevant to each repository.
3. Leave unrelated local changes untouched.
4. Verify the final status of both repos after committing.

## Procedure

1. Inspect the status of both repositories before staging anything.
2. Identify which files belong to the outer repo and which belong to `fhir-fork`.
3. Confirm that the source edit is limited to `fhir-fork/source/`.
4. Use the generated `jira/active/<ticket>/<ticket>-commit-message.txt` content when creating each commit message.
5. Stage and commit the `fhir-fork` source change first when the task includes a specification edit.
6. Stage and commit outer-repo ticket artifacts separately.
7. If the ticket was moved from `jira/open/` to `jira/active/`, commit the file move as part of the outer repo history.
8. Keep commit messages short, imperative, and ticket-prefixed.
9. Recheck `git status --short` in both repositories and confirm only unrelated pre-existing changes remain.

## Decision Points

- If the task touches only one repository, do not force a second commit.
- If the outer repo contains unrelated user changes, do not stage or revert them.
- If the nested fork has unrelated edits outside the ticket scope, leave them uncommitted.
- If a ticket file still exists under `jira/open/` after moving it to `jira/active/`, commit the deletion so the history matches the new location.

## Completion Checks

- The source commit is recorded in `fhir-fork`.
- The ticket/workflow commit is recorded in the outer repository.
- Commit messages reference the relevant ticket key.
- Validation artifacts, if any, are already written in the ticket directory.
- Final status checks show no unintended files staged or committed.

## Example Outcomes

- A ticket typo fix in `fhir-fork/source/` gets one commit in the fork and a separate outer-repo commit for the moved ticket and change log.
- A planning-only task creates or updates ticket artifacts in the outer repo without a fork commit.
- A source-only correction in the fork is committed without touching ticket metadata.