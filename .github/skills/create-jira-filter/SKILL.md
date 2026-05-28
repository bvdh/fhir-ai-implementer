---
name: create-jira-filter
description: "Generate a Jira filter URL for all tickets in currentTickets.md. Use when: reviewing all current tickets in Jira, bulk-viewing ticket progress, filtering work-in-progress tickets, creating a shared Jira dashboard link."
argument-hint: "(optional: Jira instance URL, defaults to Atlassian cloud)"
---

# Create Jira Filter

This skill generates a Jira JQL filter that shows all tickets listed in `currentTickets.md`.

## When to Use

- **Bulk review**: Open all current tickets in a single Jira view
- **Progress tracking**: Check status of all work-in-progress tickets at once
- **Shared links**: Generate a URL to share with team members
- **Workflow verification**: Confirm all planned tickets are tracked

## What It Does

1. Reads `currentTickets.md` from the repository root
2. Extracts all FHIR ticket identifiers (FHIR-XXXXX)
3. Generates a Jira filter using the pattern:
   ```
   project = FHIR AND Specification = "FHIR Core (FHIR) [FHIR-core]" AND key in (FHIR-33050, FHIR-40580, ...)
   ```
4. Creates a URL-encoded Jira filter link
5. Stores both of them in the file `pr/<branch>/jira-filter.md` directory for easy access

## Usage

### Option 1: Use the Helper Script
Run [generate-jira-filter.sh](./scripts/generate-jira-filter.sh) to generate and copy the filter URL:

```bash
./.github/skills/create-jira-filter/scripts/generate-jira-filter.sh
```

The script outputs:
- **JQL query** (copy-paste into Jira manually)
- **Filter URL** (click to open in Jira)
- **Ticket count** (verify all tickets are included)

### Option 2: Manual Jira Steps

1. Go to **Filters** → **Advanced Issue Search** in Jira
2. Paste the generated JQL query
3. Click **Search**
4. Save as a new filter if desired

## Filter Details

- **Project**: FHIR
- **Specification**: "FHIR Core (FHIR) [FHIR-core]"
- **Keys**: All tickets from `currentTickets.md`
- **Current ticket count**: 89 (dynamically updated from currentTickets.md)

## Customization

To modify the filter criteria:
- Edit the JQL pattern in [generate-jira-filter.sh](./scripts/generate-jira-filter.sh)
- Change the Jira instance URL (defaults to `https://jira.hl7.org/browse/`)
- Adjust the specification or project constraints as needed

## References

- [Jira Query Language (JQL) Documentation](https://support.atlassian.com/jira-software-cloud/articles/advanced-searching-using-jql/)
- `currentTickets.md` — List of active FHIR Core tickets
