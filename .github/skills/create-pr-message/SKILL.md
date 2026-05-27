---
name: create-pr-message
description: 'Generate a pull request message for FHIR ticket batches. Use when you need a PR body from currentTickets.md that lists each ticket and a one-line summary of what changed, and verifies fhir-fork branch commit coverage per ticket.'
argument-hint: 'Optional: ticket source file (default currentTickets.md). Outputs are written under jira/pullrequest/<fhir-fork-branch>/ by default.'
user-invocable: true
disable-model-invocation: false
---

# Create PR Message

Build a PR message for the current FHIR batch that:
- lists all tickets in scope
- gives a single-line summary per ticket
- calls out duplicate/overlapping ticket implementations clearly
- verifies ticket-to-commit coverage on the current `fhir-fork` branch
- requires ticket implementation commits only in `fhir-fork` (outer repo commits are optional and not part of commit-coverage pass/fail)

## When To Use
- You are preparing a PR from the current batch in `currentTickets.md`.
- You need a consistent, review-ready PR description covering many technical corrections.
- You want summaries grounded in ticket execution artifacts, not ad hoc prose.

## Inputs
- Ticket list source: `currentTickets.md` (default).
- Ticket directories: `jira/active/<ticket>/`, with fallback to `jira/closed/<ticket>/` then `jira/open/<ticket>/`.
- Source branch for implementation commits: current checked out branch in `fhir-fork`.
- Output directory: `jira/pullrequest/<branch-name>/` where `<branch-name>` is the current `fhir-fork` branch name.
- Full output file path: `jira/pullrequest/<branch-name>/pull-request-message-full.md` (default).
- Trimmed output file path: `jira/pullrequest/<branch-name>/pull-request-message.md` (default, no commit coverage or validation sections).
- Ticket snapshot path: `jira/pullrequest/<branch-name>/currentTickets.md` (copy of ticket scope used to generate the PR message).
- Preferred summary artifacts (in order):
1. `<ticket>-commit-message.txt` first bullet line under title
2. `<ticket>-implementation-change-log.md` first item under `## Changes Applied`
3. `<ticket>.md` `Summary` field (ticket summary, used as fallback)

## Procedure
1. Read ticket keys from `currentTickets.md`.
2. For each ticket key, locate the first existing ticket directory in this order:
1. `jira/active/<ticket>/`
2. `jira/closed/<ticket>/`
3. `jira/open/<ticket>/`
3. Derive one-line summary using precedence:
1. Commit message bullet from `<ticket>-commit-message.txt`
2. First numbered change from `<ticket>-implementation-change-log.md`
3. `Summary` metadata line from `<ticket>.md`
4. If no summary source exists, emit: `No execution summary artifact found (needs follow-up).`
4. Detect likely duplicate implementation across tickets:
1. If two tickets have identical normalized summary text, mark as potential overlap.
2. If change-log indicates verification-only/no-op, mark as already applied/verification-only.
5. Run commit coverage checks for the current `fhir-fork` branch:
1. Collect ticket keys from any commit subject in the PR commit range on `fhir-fork` (prefer `merge-base(default-branch, HEAD)..HEAD`), using pattern `FHIR-12345`.
2. Compare commit ticket keys against `currentTickets.md`.
3. If a commit ticket key is not in `currentTickets.md`, ask whether to add it to `currentTickets.md` and include it in PR scope.
4. For any ticket in `currentTickets.md` with no matching branch commit, check whether ticket execution is explicitly verification-only/no-op/already applied.
5. If commit is missing and no no-op evidence exists, flag as missing implementation commit and include in validation notes.
6. Build PR markdown with these sections:
1. `## Scope`
2. `## Tickets Addressed` (bullet list of ticket keys)
3. `## Per-Ticket Change Summary` (one line per ticket)
4. `## Notes on Overlaps` (only when duplicates/overlaps detected)
5. `## Commit Coverage Check`
6. `## Validation Notes` (artifact completeness and any missing summaries)
7. Persist output:
1. Resolve the current `fhir-fork` branch name and map it to a safe directory segment (replace `/` with `-`).
2. Ensure directory `jira/pullrequest/<branch-name>/` exists.
3. Copy `currentTickets.md` to `jira/pullrequest/<branch-name>/currentTickets.md`.
4. Write the complete PR markdown (including `## Commit Coverage Check` and `## Validation Notes`) to `jira/pullrequest/<branch-name>/pull-request-message-full.md` unless caller supplied a different full-output path.
5. Create a trimmed PR markdown that keeps `## Scope`, `## Tickets Addressed`, and `## Notes on Overlaps`, and excludes `## Commit Coverage Check` and `## Validation Notes`.
6. Write the trimmed markdown to `jira/pullrequest/<branch-name>/pull-request-message.md`.
7. Return the trimmed markdown in chat, and mention where the full report and copied `currentTickets.md` snapshot are stored.
8. Validate final output:
1. Every ticket from `currentTickets.md` appears exactly once.
2. Every ticket has exactly one summary line.
3. Overlap notes are explicit and reference both ticket keys.
4. Every ticket requiring source change has a corresponding `fhir-fork` ticket commit.
5. Tickets without commits are explicitly marked verification-only/no-op, or flagged for follow-up.
6. Missing-artifact tickets are listed in validation notes.

## Output Template
Use this structure in the generated PR message:

```markdown
## Scope
One or more commits addressing the tickets listed below.

## Tickets Addressed
- FHIR-XXXXX: <single-line change summary>
- FHIR-YYYYY: <single-line change summary>

## Notes on Overlaps
- FHIR-AAAAA and FHIR-BBBBB map to the same source-location fix; implemented once and tracked for both tickets in this PR.

## Commit Coverage Check
- Branch commit tickets detected: FHIR-XXXXX, FHIR-YYYYY.
- Tickets without branch commit: FHIR-QQQQQ (verification-only/no-op confirmed).

## Validation Notes
- Summary artifacts present for N/M tickets.
- Missing summary artifacts: FHIR-ZZZZZ.
```

Default write targets for this output:
- Full report: `jira/pullrequest/<branch-name>/pull-request-message-full.md`
- Trimmed PR text: `jira/pullrequest/<branch-name>/pull-request-message.md`
- Ticket snapshot: `jira/pullrequest/<branch-name>/currentTickets.md`

## Decision Points
- If a ticket has no execution artifacts but has a ticket markdown summary:
  Use ticket summary and flag it as fallback-derived.
- If a ticket has both commit-message and change-log summaries that differ:
  Prefer commit-message bullet and note discrepancy in validation notes.
- If a ticket is in `currentTickets.md` but missing from all Jira status folders:
  Keep ticket in output with missing-artifact warning.
- If a `fhir-fork` commit references a ticket not in `currentTickets.md`:
  Ask whether to add the ticket to `currentTickets.md` and PR scope before finalizing output.
- If a ticket in `currentTickets.md` has no `fhir-fork` commit:
  Check ticket artifacts for explicit verification-only/no-op/already-applied execution. If absent, flag the ticket as unresolved for PR readiness.
- If an outer-repo commit exists without a `fhir-fork` commit for a change-required ticket:
  Do not count the outer commit toward commit coverage. Require either a matching `fhir-fork` ticket commit or explicit no-op/verification evidence.

## Completion Checks
- PR message includes all tickets from `currentTickets.md`.
- One-line summary exists for each ticket.
- Duplicate/overlap cases are explicitly disclosed.
- Commit coverage check section is included and complete.
- Any commit-ticket mismatch has an explicit action decision (add to scope or defer).
- Any missing commit is classified as verification-only/no-op or unresolved.
- Commit coverage is evaluated only against `fhir-fork` branch commits.
- Full PR report is written to `jira/pullrequest/<branch-name>/pull-request-message-full.md`.
- Trimmed PR text is written to `jira/pullrequest/<branch-name>/pull-request-message.md` and excludes commit coverage and validation sections.
- `currentTickets.md` snapshot is copied to `jira/pullrequest/<branch-name>/currentTickets.md`.
- Output is concise and ready to paste into PR description.
