---
name: reset-repo
description: 'Reset FHIR ticket workflow state. Use for resyncing fhir-fork with HL7/fhir master, creating a fresh working branch, clearing currentTickets.md, and moving jira/active tickets back to open or closed.'
argument-hint: 'New branch name and optional ticket-closing list'
---

# Reset Repo

Resets the workspace to a clean starting state for a new FHIR ticket batch.

## When to Use
- Start of a new work cycle after finishing a previous ticket batch
- Local branch drift from upstream HL7 fhir master
- Need to archive current active tickets and begin with an empty `currentTickets.md`

## Inputs
- New branch name (required)
- Optional confirmation to proceed with destructive reset of `fhir-fork/master`

## Procedure
1. Validate workspace state.
- Confirm repository root is the `fhir-ai-implementer` workspace.
- Check for uncommitted changes in both the outer repo and `fhir-fork/`.
- If there are uncommitted changes, stop and ask whether to commit/stash first.

2. Sync `fhir-fork/` to upstream HL7 master.
- `cd fhir-fork`
- Ensure `upstream` remote points to `https://github.com/HL7/fhir` (or `git@github.com:HL7/fhir.git`).
- `git fetch upstream master`
- `git checkout master`
- Ask for explicit confirmation before destructive sync.
- `git reset --hard upstream/master`
- Do not push `origin master` automatically.

3. Create the new working branch.
- Ask user for branch name if not provided.
- Validate branch name is non-empty and does not already exist.
- `git checkout -b <new-branch-name>`

4. Reset ticket tracking file.
- Truncate `currentTickets.md` so it contains no ticket entries.
- Keep file present in repo root.

5. Move active ticket folders.
- For each folder under `jira/active/`:
- Read each ticket markdown and inspect its status field.
- If status indicates closed/applied/done, move to `jira/closed/`.
- Otherwise move to `jira/open/`.
- Preserve the per-ticket folder contents.

6. Verify result.
- Confirm `fhir-fork` is on the new branch and branch tip includes upstream master.
- Confirm `currentTickets.md` has zero `FHIR-` entries.
- Confirm `jira/active/` is empty.
- Summarize moved ticket counts: `open`, `closed`.

## Decision Points
- Uncommitted changes detected:
  - Stop and request explicit action before continuing.
- `upstream` remote missing:
  - Add it, then fetch.
- Branch already exists:
  - Ask for overwrite strategy (new name preferred) rather than force-reset.
- Ticket status missing or ambiguous:
  - Default to `jira/open/` and include in summary.

## Completion Checks
- `fhir-fork` branch is `<new-branch-name>`
- `fhir-fork/master` equals `upstream/master` commit
- `currentTickets.md` contains no `FHIR-` lines
- `jira/active/` has no ticket folders
- Every previously active ticket exists in either `jira/open/` or `jira/closed/`

## Example Prompts
- `/reset-repo Create branch techcorr-2026-05-28 and classify active tickets by markdown status`
- `/reset-repo Hard reset fhir-fork master to upstream/master, then prepare new working branch`
- `/reset-repo Sync from HL7 master and prepare a fresh branch for new ticket work`
