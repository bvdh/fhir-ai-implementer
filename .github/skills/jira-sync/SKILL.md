---
name: jira-sync
description: 'Synchronize Jira tickets by downloading a fresh full-content HTML export directly from Jira and parsing it, then aligning jira/open, jira/active, and jira/closed. Defaults to an incremental sync of issues updated since the last download. Does not use pre-existing local Excel files.'
argument-hint: '[--full|--all] [--week] [--month] [--since YYYY-MM-DD] [--all-batched]'
---

# Jira Sync

Synchronize Jira ticket markdown files by downloading a fresh **full-content HTML** export directly from Jira and parsing it.

Unlike `jira-sync-from-excel`, this skill never uses pre-existing local `jira/*.xlsx` files. It fetches the Jira `searchrequest-fullcontent` HTML view for the configured FHIR Infrastructure query, parses it with cheerio, and writes ticket markdown.

By default the skill performs an **incremental** sync: it only requests issues with `updated >=` one day before the last successful download, and preserves existing ticket files that are not part of the partial export.

## Run

From repository root:

```bash
# Incremental (default): issues updated since one day before the last sync
bash ./.github/skills/jira-sync/scripts/sync-if-newer.sh

# Full refresh (all matching issues) and prune removed tickets
bash ./.github/skills/jira-sync/scripts/sync-if-newer.sh --full

# Only issues updated in the last 7 days
bash ./.github/skills/jira-sync/scripts/sync-if-newer.sh --week

# Only issues updated in the last month
bash ./.github/skills/jira-sync/scripts/sync-if-newer.sh --month

# Only issues updated on/after a specific date
bash ./.github/skills/jira-sync/scripts/sync-if-newer.sh --since 2026-06-01

# Download all matching issues in monthly batches (most recent first)
bash ./.github/skills/jira-sync/scripts/sync-if-newer.sh --all-batched
```

## Monthly Batched Download

The `--all-batched` option downloads all matching issues in monthly periods, starting with the most recent month and working backward. This is useful when:

- You need to download a large number of tickets (>1000) that would exceed Jira's single-request limits
- You want to control the download pace to avoid server load or timeout issues
- You need to ensure all historical tickets are synced

Each batch period covers exactly one month (or less for the final batch). The batching process:
- Starts from the current date and works backward monthly
- Downloads all issues updated in each month's period
- Continues until reaching 6 years in the past (configurable)
- Prunes tickets no longer in the result set only after the final batch completes

## Incremental Behavior

- The last successful download date is stored in `.github/skills/jira-sync/.last-sync` (gitignored).
- Default run adds `AND updated >= "<last-sync minus 1 day>"` to the JQL query.
- If no previous sync is recorded, the skill performs a one-time **full seed** download.
- Incremental runs never prune ticket directories that are absent from the partial export; only `--full` and `--all-batched` prune tickets no longer in the result set.
- A ticket whose state changed (e.g. open → closed) is still moved to the correct folder even in incremental mode.

## Behavior

- Downloads a fresh Jira full-content HTML export to a temp file.
- Parses the HTML directly with `scripts/sync-jira-from-html.mjs` (cheerio).
- Extracts key, summary, dates, fields, description, and comments per issue.
- Updates ticket markdown under `jira/open/`, `jira/active/`, and `jira/closed/`.
- `jira/active/` is controlled strictly by `currentTickets.md` at repository root.
- The temp HTML file is removed after parsing (nothing is written to `jira/*.html`).

## Auth For Jira Download

If Jira blocks anonymous export access, set one of:

- `JIRA_COOKIE_FILE=/path/to/jira-cookies.txt`
- `JIRA_USER=<username>` and `JIRA_API_TOKEN=<token>` (or `JIRA_TOKEN`)
- `JIRA_BEARER_TOKEN=<token>`

These environment variables apply to all sync operations.

## Notes

- Requires Node.js and curl.
- Requires the `cheerio` npm package (installed automatically under the skill on first run).
- Large full exports may take several minutes; incremental exports are much smaller and faster.
- Batched downloads (with `--all-batched`) may take 15+ minutes depending on ticket volume; use it for large sync operations (>1000 tickets).
- Use `jira-sync-from-excel` instead when you want to sync from an existing local Excel export.
