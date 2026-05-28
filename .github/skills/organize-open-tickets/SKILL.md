---
name: organize-open-tickets
description: 'Organize open Jira tickets into overview markdown files by related page or artifact. Use when you need grouped summaries in jira/overview and an other.md catch-all for unmatched tickets.'
argument-hint: 'Optional: output naming style and fallback grouping rule'
---

# Organize Open Tickets

Create grouped overview markdown files for tickets in `jira/open/`.

## Outcome
- Creates or refreshes `jira/overview/`
- Deletes all existing `jira/overview/*.md` files at the start of each run
- Writes one markdown file per page/artifact group
- Writes `jira/overview/other.md` for tickets without a detectable group
- Excludes `Status: Published` tickets from overview grouping and reports them as sync anomalies
- Does not delete or modify ticket directories under `jira/open/`
- Organizes each overview file by ticket status sections

## When to Use
- You want a planning view of open tickets by specification page/artifact
- You need a stable set of review files for triage and batch planning
- You want to quickly see which artifacts have the most open work

## Inputs
- Source directory: `jira/open/`
- Output directory: `jira/overview/`
- Optional naming style for group files:
  - `slug` (default): lowercase with dashes
  - `label`: human-readable filename with spaces replaced by underscores

## Run Command
From the repository root, run:

```bash
bash ./.github/skills/organize-open-tickets/scripts/generate-overview.sh
```

Optional naming style:

```bash
bash ./.github/skills/organize-open-tickets/scripts/generate-overview.sh --naming-style label
```

## Group Detection Rules
For each `jira/open/FHIR-XXXXX/FHIR-XXXXX.md` file:
1. Use `Related Page(s)` metadata when present and non-empty.
2. Else use `Related URL` path tail (for example `ballot-intro.html` -> `ballot-intro`).
3. Else use `Related Section(s)` when present.
4. Else use `Grouping` tags when present.
5. Else route ticket to `other.md`.

If multiple values exist in `Related Page(s)`, split by comma or semicolon and include the ticket in each corresponding group file.
If `Grouping` is bracketed (for example `[BallotRec-Vote4, Easy]`), strip brackets and split by comma.

## Procedure
1. Validate inputs.
- Confirm `jira/open/` exists.
- Create `jira/overview/` if missing.
- Detect any tickets in `jira/open/` with `Status: Published` and treat them as classification drift.

2. Clear previous output.
- Delete all existing markdown files in `jira/overview/` before writing fresh output.

3. Scan open ticket files.
- Enumerate `jira/open/FHIR-*/FHIR-*.md`.
- Read metadata block under the `## Metadata` heading.
- Skip files whose metadata contains `Status: Published`.

4. Compute groups.
- Apply Group Detection Rules in order.
- Normalize group labels for filenames based on selected naming style.

5. Write output files.
- For each group, write `jira/overview/<group>.md`.
- Write `jira/overview/other.md` for unmatched tickets.
- Each file contains:
  - Title with group name
  - Ticket count
  - Status sections (`## <Status> (count)`)
  - Bullet list of tickets within each status: key, summary, Jira link, source file link

6. Verify completion.
- Confirm every open ticket appears in at least one overview file.
- Confirm `other.md` exists (even if empty, include count 0).
- Print summary counts by group and total tickets processed.
- If published-in-open anomalies were detected, print the ticket list and instruct re-running `jira-sync-from-excel`.

## Decision Points
- Group value missing:
  - Route to `other.md`.
- `Status: Published` found in `jira/open/`:
  - Exclude ticket from open overview output and report as anomaly.
- Multiple group values:
  - Duplicate entry across all matching group files.
- Filename collision after normalization:
  - Append numeric suffix (`-2`, `-3`, ...).

## Completion Checks
- `jira/overview/` exists
- One file per detected group plus `other.md`
- Total listed tickets across groups is greater than or equal to open ticket count
- Every ticket in `jira/open/` appears in at least one generated overview file
- No `Status: Published` tickets remain in `jira/open/` after running `jira-sync-from-excel`
- Each generated overview file is organized into status sections

## Example Prompts
- `/organize-open-tickets Group open tickets into overview files by related page`
- `/organize-open-tickets Build jira/overview with slug file names`
- `/organize-open-tickets Regenerate overview files and place unmatched tickets in other.md`
