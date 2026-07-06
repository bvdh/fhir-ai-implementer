---
name: jira-sync-from-excel
description: 'Synchronize Jira ticket markdown subdirectories from the newest Excel file in jira/. Updates existing ticket docs and creates new ones in jira/open, jira/active, and jira/closed. Use after updating Jira Excel exports to refresh ticket files and status-based organization.'
argument-hint: '[--force] optional flag to skip modification-time check'
---

# Jira Sync From Excel

Synchronize Jira ticket markdown files from the newest Excel export in the `jira/` directory.

The skill uses the newest `*.xlsx` file in `jira/`, then generates or updates ticket markdown files under status-based directories:
- `jira/open/`
- `jira/active/`
- `jira/closed/`

If no new local Excel export is available, the sync script fetches a fresh export from Jira using:
- [Jira](https://jira.hl7.org/sr/jira.issueviews:searchrequest-fullcontent/temp/SearchRequest.html?jqlQuery=project+%3D+FHIR+AND+Specification+%3D+%22FHIR+Core+%28FHIR%29+%5BFHIR-core%5D%22+AND+%28%28type+%3D+%22Technical+Correction%22+and+status+not+in+%28Published%29%29+OR+status+not+in+%28Published%2C+%22Change+Not+Needed%22%2C+%22Resolved+-+No+Change%22%2C+Deferred+%29%29+AND+%22Work+Group%22+%3D+%22FHIR+Infrastructure+%5Bfhir-i%5D%22+ORDER+BY+status+DESC&tempMax=1000)

`jira/active/` is controlled strictly by `currentTickets.md` at repository root.

Each ticket is written to a subdirectory named after its key:
- `jira/<state>/FHIR-XXXXX/FHIR-XXXXX.md`

## When To Use
- After downloading a new Jira Excel export into `jira/`.
- To refresh ticket metadata and comments in local markdown files.
- To keep local ticket files organized by status (open, active, closed).

## Procedure
1. From the repository root, run:

```bash
bash ./.github/skills/jira-sync-from-excel/scripts/sync-if-newer.sh
```

2. The script will:
   - Locate all `*.xlsx` files in `jira/`
   - Warn if multiple files are present
   - Select the most recent Excel file
   - If no Excel exists, download a fresh Jira export from the URL above into `jira/`
   - Compare both Excel mtime and `currentTickets.md` mtime vs existing ticket directory mtimes
   - If no newer local Excel is found, attempt a Jira export download before deciding to skip
   - Show a download progress bar in interactive terminals (or concise status in non-interactive runs)
   - Skip sync only when neither local files nor Jira download yields a newer export
   - Generate updated markdown for each Jira ticket when sync is needed

3. Optional: force sync even if timestamps indicate no changes:

```bash
bash ./.github/skills/jira-sync-from-excel/scripts/sync-if-newer.sh --force
```

## Classification Rules

### Closed
Closed includes statuses or resolutions such as:
- Applied
- Duplicate
- Deferred
- Resolved
- Closed
- Published
- Resolved - No Change
- Done

### Active
Active includes only tickets listed in `currentTickets.md`.

If a ticket is listed in `currentTickets.md`, it is moved to `jira/active/` even when Jira status is open or closed.

If a ticket is not listed in `currentTickets.md`, it is moved out of `jira/active/` into `jira/open/` or `jira/closed/` based on status/resolution.

### Open
Any ticket not in `currentTickets.md` and not classified as closed defaults to open.

Published tickets must never remain in `jira/open/`; they are classified as `closed` during sync.
Tickets with status/resolution indicating change required (for example `Resolved - change required` or `resolved-changed-required`) are classified as `open`.

## Output Format
Each `FHIR-XXXXX.md` file includes:
- Ticket heading with key and summary
- Metadata section with non-empty fields
- Direct Jira link
- Comments section with author/date/security/comment text

## Notes
- Requires Node.js.
- Requires `curl` and network access to Jira for the fallback download path.
- Jira fallback may require authentication. Supported options:
   - `JIRA_COOKIE_FILE=/path/to/jira-cookies.txt`
   - `JIRA_USER=<username>` and `JIRA_API_TOKEN=<token>` (or `JIRA_TOKEN`)
   - `JIRA_BEARER_TOKEN=<token>`
- Fallback download timeout is extended for large Jira exports and may take several minutes.
- Requires the `xlsx` npm package available to Node.js execution context.
- Existing ticket directories in the wrong state folder are moved by regeneration (old location removed, new location written).
- Root-level `jira/FHIR-XXXXX` directories are also migrated to status folders when encountered.
- Ticket directories that contain files other than `FHIR-XXXXX.md` are never deleted by sync.
- When a ticket changes state, extra files in its old directory are moved to the new state directory with the ticket.
