---
name: propose-ticket-resolution
description: 'Generate resolution proposals for FHIR Jira tickets in the current project workflow. Uses ticket markdown files in jira/open, jira/active, jira/closed and follows currentTickets.md for work-in-progress scope. Produces FHIR-XXXXX-resolution.md files for workgroup review and implementation planning.'
argument-hint: 'FHIR-XXXXX (single ticket) or --all (batch from currentTickets.md)'
---

# Ticket Resolution Skill

Generates structured resolution proposals for FHIR Jira tickets by analyzing ticket metadata, status, and comments from local Jira markdown files. Produces a comprehensive `<ticket>-resolution.md` file for each ticket that documents disposition options and a recommended path.

## Pre-requisites

* Run `jira-sync-from-excel` so ticket markdown files are up to date.
* Ensure `currentTickets.md` contains the tickets currently being worked on.

## When To Use

- **Single Ticket**: Preparing a specific ticket for resolution review (e.g., `FHIR-51010`)
- **Batch Processing**: Generating resolution proposals for all tickets listed in `currentTickets.md` (use `--all` flag)
- **Disposition Documentation**: Documenting approved changes and their implementation status
- **Work Group Review**: Preparing tickets for presentation to governance/work groups

## Project Workflow Alignment

This skill is aligned to the repository workflow:

1. Ticket export is synced into `jira/`.
2. Active ticket scope is declared in `currentTickets.md`.
3. Resolution proposals are generated for those active tickets.
4. Proposal files are saved beside ticket files under `jira/open`, `jira/active`, or `jira/closed`.
5. Proposal is used to create implementation plans and then implemented in `fhir-fork/source/`.

## How To Invoke

**From VS Code**: Pass a ticket key (e.g., `FHIR-51010`) or `--all` to generate resolution files.

**From Terminal**: Run the underlying CLI tool:
```bash
node ./.github/skills/propose-ticket-resolution/orchestrate-batch.js --all
node ./.github/skills/propose-ticket-resolution/generate-resolutions-batch.js
```

## Workflow

### Single Ticket Resolution

When you provide a ticket key (e.g., `FHIR-51010`):

1. **Load Ticket Data**
   - Read `jira/open/FHIR-51010/FHIR-51010.md`, `jira/active/FHIR-51010/FHIR-51010.md`, or `jira/closed/FHIR-51010/FHIR-51010.md`
   - Extract metadata: Issue Type, Status, Resolution, Reporter, Assignee, Created date, Parent key, Grouping
   - Parse comments and extract GitHub links (PRs, commits)

2. **Analyze Implementation Status**
   - Map ticket Status to disposition state (Applied, Declined, Alternative, etc.)
   - Identify related tickets via Parent key or Grouping
   - Determine if implementation is complete or pending

3. **Classify Disposition**
   - **Applied**: Change was approved and implemented (Status: Applied, Resolution: Persuasive or Accepted)
   - **Declined**: Change was rejected (Status: Declined or Duplicate)
   - **Alternative**: Different approach was taken (Status: Applied but different from request)
   - **Pending**: Awaiting decision (Status: New, In Progress, or other open statuses)
   - **Duplicate**: Superseded by another ticket (look for Parent key or links)

4. **Extract Evidence**
   - Parse comment links for GitHub PR URLs
   - Extract commit hashes from comment text
   - Identify commit authors and dates from comment metadata
   - Note related tickets via Grouping field
   - Reference relevant FHIR core specification pages under `fhir-fork/source/`

5. **Generate Resolution File**
   - Create `jira/FHIR-51010/FHIR-51010-resolution.md`
   - Structure with sections: Summary, Implementation Status, Disposition Analysis, Resolution Proposals, Proposed Dispositions
   - Include all extracted evidence and GitHub links

6. **Update Ticket Sections Report (Required Final Step)**
   - Update ticket-local notes and rationale in the same ticket directory as needed.
   - If a project-wide index file exists and the user requests it, update it explicitly.

### Batch Processing (Tickets In currentTickets.md)

When you use the `--all` flag, tickets listed in `currentTickets.md` are selected for processing:

1. **Orchestration Phase**
   - Read `currentTickets.md` in repository root
   - Extract all `FHIR-XXXXX` keys
   - Resolve each key to a directory under `jira/open`, `jira/active`, or `jira/closed`
   - Return list of tickets to process

2. **Per-Ticket Processing**
   - For each ticket key, process ticket data and generate proposal markdown
   - Generate `<ticket>-resolution.md`

3. **Summary & Reporting**
   - Collect results from all subagent sessions
   - Output batch summary report showing:
     - Total tickets processed
     - Tickets generated/updated
     - Tickets skipped (already resolved)
     - Errors encountered
     - Links to all generated resolution files
   - Batch report written to `jira/batch-resolution-report.md`

4. **Update Ticket Sections Report (Required Final Step)**
   - Update any requested summary artifact only when such a file exists and the user asks for it.

## Resolution Proposal Format

Each generated `<ticket>-resolution.md` file includes:

```markdown
# Proposed Resolution for FHIR-XXXXX

## Ticket Summary
[Metadata table with Key, Type, Status, Resolution, Reporter, Created, Grouping]

## Description
[Extracted from ticket .md file]

## Implementation Status
[Applied/Pending/Declined analysis with evidence]

### Implementation Details (if Applied):
- PR links with numbers
- Commit hashes and links
- Merge dates and authors

## Related Tickets
[List of parent/grouped tickets if any]

## Disposition Analysis

### Disposition Taken
[Classification: Accept & Implement / Decline / Alternative / Pending]

### Rationale
[Based on: Work Group consensus, Implementation evidence, Related discussions]

### Evidence
- Status markers from ticket
- GitHub implementation links
- Comment dates and authors

## Proposed Dispositions

### Disposition A: Accept As Requested

#### Proposal

{The specific action to take that fulfills exactly what the ticket asks for.
Write this as a concrete change proposal: what would change in the spec, what
resource/element/constraint would be added/modified/removed. This should be
detailed enough to act on.}

#### Justification

{Why this is a reasonable approach. Reference specific FHIR design principles,
consistency with existing patterns, community feedback from Zulip, or
standards requirements.}

---

### Disposition B: Alternative Approach

#### Proposal

{An alternative way to address the underlying need of the ticket that differs
from what was literally requested. This might use a different mechanism (e.g.,
extension vs. core element, different resource, different cardinality, profile
instead of base spec change). Be specific about what the alternative is.}

#### Justification

{Why this alternative might be preferable. Address trade-offs vs. Disposition
A. Reference design principles, backward compatibility, implementation
burden, or scope.}

---

### Disposition C: Decline

#### Proposal

{A clear statement that the request should not be adopted, with a specific
rationale category (e.g., out of scope, insufficient use cases, already
addressed by existing mechanism, breaking change not justified).}

#### Justification

{Why declining is defensible. Reference the specific reason the request
should not be adopted. If there is an existing mechanism that already
addresses the need, cite it. If the change would cause harm (breaking
changes, complexity), explain how.}

---

### Recommendation

**Recommended disposition:** {A, B, or C}

{A paragraph explaining why this disposition is recommended over the others.
Weigh the trade-offs, reference the community discussion if relevant, and
consider the impact on implementers. Be direct and opinionated — the
workgroup wants a clear recommendation to start the discussion.}

## Next Steps
[Completed / Ready for Review / Awaiting Decision / On Hold]

### Verification Checklist
- [x/] Work group review completed
- [x/] Implementation code committed
- [x/] Verification in main branch
- [x/] Documentation updated
```

## Data Sources

- **Primary**: `jira/open/FHIR-*/FHIR-*.md`, `jira/active/FHIR-*/FHIR-*.md`, `jira/closed/FHIR-*/FHIR-*.md`
- **Ticket Metadata**: Issue Type, Status, Resolution, Reporter, Assignee, Created, Parent key, Grouping
- **Implementation Evidence**: Comments section (parsing for GitHub links and text)
- **Related Tickets**: Parent key and Grouping fields
- **Active Scope**: `currentTickets.md` (for `--all`)

## Procedure

### Generate Resolution for One Ticket

Provide a ticket key:
```
FHIR-51010
```

Output: `jira/FHIR-51010/FHIR-51010-resolution.md` created with:
- Complete ticket metadata
- Full description and comments
- Three proposed disposition options
- Verification checklist
- `jira/jira-ticket-sections.md` updated for the ticket row (Proposal + Result)

### Generate Resolutions for All Unresolved Tickets

Provide the `--all` flag:
```
--all
```

Output summary:
```
Processing tickets from currentTickets.md...
Generated FHIR-51273-resolution.md
Generated FHIR-51274-resolution.md
... (more files)
Summary: 3 tickets listed, 3 processed
```

Final step after generation:
- Review proposals and proceed to implementation planning per repository workflow.

### Update Existing Resolution File

Simply re-run with the same ticket key to overwrite:
```
FHIR-51010
```

The existing `jira/FHIR-51010/FHIR-51010-resolution.md` will be updated.

## Output Locations

- **Single ticket**: `jira/open|active|closed/FHIR-XXXXX/FHIR-XXXXX-resolution.md`
- **Batch mode**: Individual files in each resolved ticket directory
- **Batch summary report**: `jira/batch-resolution-report.md`
- **Orchestration artifacts**: `jira/orchestration-plan.json`, `jira/batch-resolution-results.json`

## Selection Rules

For `--all`, ticket selection is based on `currentTickets.md`, not global unresolved status scanning.

## GitHub Evidence Parsing

The skill automatically extracts and links:

- **Pull Requests**: `https://github.com/bvdh/fhir-bvdh/pull/NNN` and `https://github.com/HL7/fhir/pull/NNN`
- **Commits**: `https://github.com/bvdh/fhir-bvdh/commit/HASH` and `https://github.com/HL7/fhir/commit/HASH`
- **Issues**: Any linked issue URLs in comment text

These are extracted from comment text and linked in the resolution file with clickable URLs.

## Related Unresolved Tickets

If a ticket has a Parent key, the resolution file notes the relationship:

```
## Related Tickets
- Parent: FHIR-XXXXX (status: Applied/Pending/Declined)
- Grouped with: [block-vote-1] (N other tickets in same grouping)
```

## Notes and Limitations

- **Static Data**: Reads from markdown files only; does not connect to live Jira API.
- **Data Currency**: Ensure tickets are synced before running. Use `jira-sync-from-excel` if export.xlsx was updated.
- **GitHub Linking**: Links extracted via regex; malformed URLs may not be captured.
- **Repository Assumption**: Assumes imaging repo is `hl7-eu/imaging` on GitHub.
- **Batch Filtering**: The `--all` flag only processes tickets with statuses other than Applied, Not Persuasive with Modification, Retracted, Not Persuasive, or Declined.
- **File Permissions**: Skill must have write access to `jira/FHIR-*/` directories.

## Integration with Other Skills

- **Before running**: Use `jira-sync-from-excel` to ensure ticket metadata is current.
- **After running**: Review generated `*-resolution.md` files to verify accuracy before committing to Git.
- **In combination**: Chain with `ig-preprocess-build-check` or build validation skills to verify implementation completeness.

## Example Workflows

### Prepare Ticket for Governance Review
```bash
# 1. Ensure tickets are synced
jira-sync-from-excel

# 2. Generate resolution for the specific ticket
ticket-resolution FHIR-51010

# 3. Review the generated file
cat jira/FHIR-51010/FHIR-51010-resolution.md

# 4. Update ticket index report row
# (Proposal + Result columns)

# 5. Edit manually as needed before presenting to work group
```

### Batch Resolution Documentation
```bash
# 1. Update all ticket metadata from latest export
jira-sync-from-excel

# 2. Generate resolution proposals for all open tickets
ticket-resolution --all

# 3. Review summary output in console
# Review individual files in your editor

# 4. Update jira-ticket-sections.md for processed tickets

# 5. Commit resolution proposals and section index updates to git
git add jira/FHIR-*/FHIR-*-resolution.md jira/open/FHIR-*/*-resolution.md jira/closed/FHIR-*/*-resolution.md jira/jira-ticket-sections.md jira/batch-resolution-report.md
git commit -m "Generate resolution proposals for unresolved tickets"
```

### Find and Document Recently Applied Changes
```bash
# 1. Sync latest ticket data
jira-sync-from-excel

# 2. Generate resolutions for tickets that were recently marked "Applied"
ticket-resolution --all

# 3. Filter results for newly generated Applied tickets
grep -r "Applied" jira/FHIR-*/FHIR-*-resolution.md | head -10

# 4. Update jira-ticket-sections.md rows for processed tickets

# 5. Review implementation evidence in generated files
```

## Implementation Details

### Batch Processing Architecture (Multi-Session with Subagent)

When batch mode (`--all`) is used, the skill employs a **multi-session strategy** using `runSubagent` for processing multiple tickets:

#### Phase 1: Orchestration
```
propose-ticket-resolution --all
  ↓
  Scan jira/ directory for all FHIR-* tickets
  ↓
  Filter to unresolved tickets (based on Status classification)
  ↓
  Build ordered list of ticket keys to process
```

#### Phase 2: Per-Ticket Processing (Separate Subagent Sessions)
```
For each unresolved ticket (e.g., FHIR-51010):
  ↓
  runSubagent("default", 
    "Run propose-ticket-resolution FHIR-51010")
  ↓
  [Isolated chat session - new context]
  [No history from previous tickets]
  ↓
  Process ticket following Single Ticket Workflow:
    1. Load ticket data
    2. Extract metadata
    3. Analyze status & disposition
    4. Parse evidence
    5. Generate resolution
  ↓
  Write jira/FHIR-51010/FHIR-51010-resolution.md
  ↓
  Return completion status to orchestrator
```

#### Phase 3: Summary & Reporting
```
After all subagent sessions complete:
  ↓
  Collect results from all tickets
  ↓
  Generate batch summary report:
    • Total tickets processed
    • Tickets newly generated
    • Tickets skipped (already resolved)
    • Errors encountered
    • Links to all resolution files
  ↓
  Write report to jira/batch-resolution-report.md
  ↓
   Update jira/jira-ticket-sections.md for processed tickets
   ↓
  Print summary to console
```

### Single Ticket Processing

When a specific ticket key is provided (e.g., `FHIR-51010`), the skill processes directly:

1. **Parse Arguments**: Extract ticket key from input
2. **Load Ticket Data**: Read `jira/FHIR-51010/FHIR-51010.md` from workspace
3. **Extract Metadata**: Parse all fields from Metadata and Resolution sections
4. **Analyze Status**: Map ticket Status to disposition classification
5. **Parse Evidence**: Extract GitHub links from comments and ticket text
6. **Generate Resolution File**: Create structured `*-resolution.md` with:
   - Complete metadata table
   - Full description preserved
   - Disposition analysis and recommendations
   - Verification checklist
7. **Write Output**: Save file atomically and report completion
8. **Update Ticket Sections Report**: Update `jira/jira-ticket-sections.md` row for this ticket
9. **Return Result**: Print file path to console

### Multi-Session Benefits

- **Focused Analysis**: Each ticket analyzed independently with fresh LLM context
- **No Cross-Ticket Bias**: One ticket's analysis doesn't influence the next
- **Better Context Utilization**: Smaller payloads = more room for detailed analysis
- **Parallel Capability**: Subagents can run concurrently (future enhancement)
- **Clear Audit Trail**: Each ticket's reasoning separately recorded
- **Error Isolation**: Failure in one ticket doesn't stop entire batch

## Batch Orchestrator Implementation

The batch processing is orchestrated by `batch-orchestrator.js`, which:

1. **Detects `--all` flag** and enters orchestration mode
2. **Scans jira/** directory for all FHIR-* folders
3. **Filters unresolved tickets** based on Status field
4. **Plans subagent invocations** for each unresolved ticket
5. **Outputs invocation plan** showing:
   - Ticket key
   - Session isolation mode
   - Expected output file path
6. **Returns orchestration results** to skill framework for execution

### Invocation from VS Code

When you invoke the skill with `--all`:
```
@propose-ticket-resolution --all
```

The skill framework:
1. Calls `batch-orchestrator.js --all`
2. Receives orchestration plan with list of subagent invocations
3. For each ticket, calls `runSubagent` with:
   - Ticket key
   - Isolated session context
   - Prompt to run resolution analysis
4. Collects all results
5. Generates batch summary report

### Terminal Invocation

From the command line in the jira directory:
```bash
# Batch orchestration
node ../.github/skills/propose-ticket-resolution/batch-orchestrator.js --all

# Single ticket (direct)
node ../.github/skills/propose-ticket-resolution/batch-orchestrator.js FHIR-51010
```

## Error Handling & Recovery

- **Ticket Not Found**: Error message printed; no file generated. Verify ticket key exists in `jira/FHIR-*/` directories.
- **Malformed Markdown**: Warning printed; empty or malformed fields skipped gracefully without stopping processing.
- **Invalid GitHub Links**: Warnings logged; links still included in output for manual review.
- **No Unresolved Tickets**: Clean exit with "No unresolved tickets found" message when using `--all`.
- **Write Permission Issues**: Descriptive error message with guidance on file permissions.
- **Subagent Failures**: If a subagent session fails for one ticket, orchestrator continues with remaining tickets and reports failures in summary.
- **Partial Batch Completion**: Summary clearly indicates which tickets succeeded and which failed or were skipped.

---

*Last updated: 2026-05-07*
*Skill version: 1.0*
