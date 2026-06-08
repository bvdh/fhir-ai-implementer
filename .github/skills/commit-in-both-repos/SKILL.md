---
name: commit-in-repos
description: 'Commit changes across the outer ticket repository and any relevant nested forks such as fhir-fork or fhir-extensions-fork. Use when a workflow spans ticket metadata/artifacts in the outer repo and source changes in one or more related repositories.'
argument-hint: 'Ticket key or short description of the multi-repo commit task'
---

# Commit in Repos

Use this skill when a task produces changes in multiple related worktrees:

- the outer `fhir-ai-implementer` repository for ticket tracking, plans, logs, and status moves
- the nested `fhir-fork` repository for specification source edits under `fhir-fork/source/`
- the nested `fhir-extensions-fork` repository when a ticket changes FHIR core extensions

## When to Use

- A ticket has been planned and implemented across the outer repo and one or more nested source repositories.
- You need separate commits for source edits and ticket/workflow artifacts.
- You want to preserve unrelated pre-existing worktree changes outside the task scope.
- You need a repeatable commit-and-verify routine for FHIR ticket work.

## Core Principles

1. Keep repository scopes separate.
2. Commit only the files relevant to each repository.
3. Leave unrelated local changes untouched.
4. Verify ticket-related files reflect the implemented ticket change before committing.
5. Verify the final status of all touched repos after committing.
6. When both `fhir-fork` and `fhir-extensions-fork` participate in the same ticket workflow, keep them on the same task branch name unless the user explicitly overrides this.

## Preconditions

1. Run the boundary validation skill before any commit activity:
	- `bash ./.github/skills/validate-fhir-fork-source-boundary/scripts/check-changed-paths.sh`
2. If the validation fails, stop and resolve out-of-scope changes before continuing.
3. If `fhir-extensions-fork` is part of the task and has its own boundary validation, run that before commit as well.
4. If both nested forks are part of the task, verify they are on the same task branch name before committing unless the user explicitly requested a different branch layout.

## Consistency Check Command Block (Example)

Use this example before commit when a ticket has a concrete value change (for example regex, canonical URL, code token, or terminology string).

1. Define the ticket and expected value:
	- `ticket=FHIR-46202`
	- `expected='^[^\\s]+( [^\\s]+)*$'`

2. Check source-of-truth files for expected value:
	- `rg -n -F "$expected" fhir-fork/source`
	- and/or `rg -n -F "$expected" fhir-extensions-fork/source`

3. Check ticket files for consistency:
	- `rg -n -F "$expected" jira/active/$ticket/`

4. Detect stale/previous value (replace old value as needed):
	- `old='^[^\\s]+(\\s[^\\s]+)*$'`
	- `rg -n -F "$old" jira/active/$ticket/ fhir-fork/source fhir-extensions-fork/source`

5. If mismatch is found, stop and present:
	- Mismatch summary: file paths and lines that disagree.
	- User question: proceed as-is, or align files now?
	- Concrete alignment alternative: exact files to edit and exact replacements.

Example alignment proposal format:
- Update `jira/active/$ticket/$ticket-implementation-plan.md`: replace OLD with EXPECTED.
- Update `jira/active/$ticket/$ticket-implementation-change-log.md`: replace OLD with EXPECTED.
- Keep `jira/active/$ticket/$ticket.md` unchanged if it is raw Jira-export metadata and intended to remain verbatim.

## Procedure

1. Inspect the status of all relevant repositories before staging anything.
2. Identify which files belong to the outer repo, `fhir-fork`, and `fhir-extensions-fork`.
3. If both nested forks are involved, compare branch names and align `fhir-extensions-fork` to the active `fhir-fork` branch name before committing unless the user explicitly requested otherwise.
4. Run the source-boundary precondition check(s) and continue only on PASS.
5. Confirm that each source edit is limited to its allowed source area (for example `fhir-fork/source/` or the planned `fhir-extensions-fork` path).
6. Run a ticket consistency check across ticket-related files (at minimum: `jira/active/<ticket>/<ticket>.md`, `jira/active/<ticket>/<ticket>-implementation-plan.md`, `jira/active/<ticket>/<ticket>-implementation-change-log.md`, and any repo-scoped commit message files) to ensure they reflect the implemented source change.
7. If inconsistencies are found, stop and ask the user whether to proceed as-is or align files now. Use a constrained confirmation prompt when possible.
8. When inconsistencies are found, propose a concrete update alternative before continuing, including exact files and the specific text/value adjustments to make.
9. Invoke `create-commit-message` for the ticket and use the generated repository-scoped files when creating commits:
	- `jira/active/<ticket>/<ticket>-commit-message-fhir-fork.txt`
	- `jira/active/<ticket>/<ticket>-commit-message-fhir-extensions-fork.txt`
	- `jira/active/<ticket>/<ticket>-commit-message-outer.txt`
10. Stage and commit the `fhir-fork` source change first when the task includes a specification edit there.
11. If `fhir-extensions-fork` has ticket-scoped changes, stage and commit those changes as a separate repo commit as well.
12. Stage and commit outer-repo ticket artifacts separately.
13. If the ticket was moved from `jira/open/` to `jira/active/`, commit the file move as part of the outer repo history.
14. Keep commit messages short, imperative, and ticket-prefixed.
15. Recheck `git status --short` in all touched repositories and confirm only unrelated pre-existing changes remain.

## Decision Points

- If the task touches only one repository, do not force additional commits.
- If the outer repo contains unrelated user changes, do not stage or revert them.
- If the nested fork has unrelated edits outside the ticket scope, leave them uncommitted.
- If `fhir-extensions-fork` has unrelated edits outside the ticket scope, leave them uncommitted.
- If `fhir-fork` and `fhir-extensions-fork` are on different branch names for the same ticket workflow, stop and align them before commit unless the user explicitly approved the mismatch.
- If a ticket file still exists under `jira/open/` after moving it to `jira/active/`, commit the deletion so the history matches the new location.
- If ticket-related files do not reflect the implemented change, do not silently continue: ask the user for approval and present an explicit alignment alternative.

## Completion Checks

- Boundary validation precondition was executed and passed before commit.
- If both nested forks were touched, branch names were aligned first unless the user explicitly overrode that rule.
- Ticket consistency check was executed before commit.
- If mismatches were found, user approval was captured and a concrete alignment alternative was proposed.
- The source commit is recorded in each touched source repository (`fhir-fork` and/or `fhir-extensions-fork`).
- The ticket/workflow commit is recorded in the outer repository.
- Repository-scoped commit message files were generated for each touched repository.
- Commit messages reference the relevant ticket key.
- Validation artifacts, if any, are already written in the ticket directory.
- Final status checks show no unintended files staged or committed.

## Example Outcomes

- A ticket typo fix in `fhir-fork/source/` gets one commit in the fork and a separate outer-repo commit for the moved ticket and change log.
- An extension-definition fix in `fhir-extensions-fork/source/` gets its own extension-fork commit plus a separate outer-repo commit for ticket artifacts.
- A planning-only task creates or updates ticket artifacts in the outer repo without a source-repo commit.
- A source-only correction in one touched repo is committed without forcing commits in the others.