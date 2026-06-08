---
name: create-confluence-ticket
description: 'Create a Jira-style ticket markdown file from approved Confluence minutes or motion text. Use when you have a Confluence page URL and motion text, want a ticket under jira/confluence/, or need a Confluence-derived tracking item that can be planned and documented like Jira tickets.'
argument-hint: 'Confluence URL and motion text, or a description of the approved Confluence item to capture'
user-invocable: true
---

# Create Confluence Ticket

Create a Confluence-derived ticket markdown file under `jira/confluence/` that mirrors the local Jira ticket structure closely enough to support planning, execution, and documentation workflows in this repository.

## Use When

- You have an approved motion or decision captured in Confluence minutes and want it tracked like a Jira ticket.
- A work group decision exists in Confluence before a Jira ticket is created.
- You want a planning-ready markdown item with explicit Confluence provenance.
- You need a reusable placeholder for implementation planning that is clearly marked as non-Jira source material.

## Inputs

- Confluence page URL.
- Motion text, approved wording, or decision text.
- Vote text in the format `<person1> / <person2> : <for>-<against>-<abstain>`, or a source excerpt that includes it.
- Optional source anchor/section name (for example `WedQ3`).
- Optional proposed key/slug.
- Optional affected page(s), related section(s), artifact(s), and work group.

## Output

- One markdown file under `jira/confluence/<key>/<key>.md`.
- The file should mirror Jira ticket structure while clearly identifying itself as Confluence-derived.
- Default key pattern when the user does not provide one:
  - `CONF-<source-period>-<short-slug>`
  - Example: `CONF-202509-WedQ3-AR-TARGETS`

## Constraints

- Do not invent Jira IDs for Confluence-derived items.
- Preserve the approved motion text as faithfully as possible.
- Do not treat a Confluence motion as planning-ready unless the source includes a recorded vote in the format `<person1> / <person2> : <for>-<against>-<abstain>`.
- Before creating a Confluence-derived ticket, check existing Jira ticket markdown for possible tickets that refer to or reflect the same approved change.
- Make Confluence provenance explicit in metadata.
- Structure the file so that it can be used by downstream planning/documentation workflows with minimal adaptation.
- If the motion concerns FHIR core extensions, note that implementation will typically belong in `fhir-extensions-fork`.

## Workflow

1. Determine whether the user provided both the Confluence page URL and the source motion/decision text.
2. Confirm that the supplied source also includes a recorded vote in the format `<person1> / <person2> : <for>-<against>-<abstain>`.
3. If the URL, motion text, or vote text is missing, stop and ask for the missing input.
4. Extract or infer the following:
   - source page title
   - source anchor/section
   - concise summary/title
   - work group
  - motion proposer/seconder and vote tally
   - affected artifact/page/section if available
5. Search existing ticket markdown under `jira/open/`, `jira/active/`, and `jira/closed/` for possible Jira tickets that describe the same or a materially overlapping change.
6. If likely Jira matches are found, stop and ask the user whether one of those tickets should be used instead of creating a Confluence-derived ticket. Present clickable links to the candidate tickets.
7. Only if the user confirms that no existing Jira ticket should be used, generate or confirm a Confluence tracking key.
8. Create the ticket directory under `jira/confluence/<key>/`.
9. Write a markdown file that follows local Jira ticket conventions with these required sections:
   - title line with key and summary
   - `## Metadata`
   - source/provenance fields
   - resolution/status fields
   - motion text or source text section
   - notes/comments section
10. Ensure the metadata includes explicit distinction from Jira:
   - `Source Type: Confluence Minutes`
   - `Jira: None - Confluence-derived tracking item`
11. Record the vote in metadata and/or the motion section using the captured vote line.
12. Add a note when the resulting work likely belongs in `fhir-extensions-fork`.
13. Report the created file path and any assumptions used to fill missing metadata.

## Decision Points

- Missing source inputs:
  - If Confluence URL is missing, ask for it.
  - If approved motion text is missing, ask for it.
  - If the source does not include a recorded vote in the expected format, ask for the vote text before creating the file.
- Existing Jira ticket overlap:
  - If one or more likely Jira tickets already capture the same change, ask the user whether to use those tickets instead.
  - Present clickable links to the candidate Jira ticket files when asking.
  - Do not create a Confluence-derived ticket until the user confirms that a new Confluence ticket is still desired.
- Key naming:
  - If the user provides a key, use it.
  - Otherwise generate a `CONF-...` key from date/anchor/topic.
- Location:
  - Default to `jira/confluence/<key>/`.
  - Do not place Confluence-derived items in `jira/open/`, `jira/active/`, or `jira/closed/` unless the user explicitly requests it.
- Fidelity vs normalization:
  - Keep quoted motion text verbatim.
  - Normalize surrounding metadata labels to local ticket style.
- Extension ownership:
  - If the motion concerns FHIR core extensions, include a note that implementation usually belongs in `fhir-extensions-fork`.

## Ticket Template

Use this structure:

```markdown
# <KEY>: <Summary>

## Metadata

- **Source Type**: Confluence Minutes
- **Source Page**:
- **Source Anchor**:
- **Source URL**:
- **Assignee**: Unassigned
- **Created**:
- **Description**:
- **Issue Type**: Confluence Motion
- **Key**:
- **Related Artifact(s)**:
- **Related Page(s)**:
- **Related Section(s)**:
- **Reporter**:
- **Resolution**:
- **Resolution Description**:
- **Status**: Resolved - change required
- **Summary**:
- **Vote / Motion**:
- **Work Group**:

- **Confluence**:
- **Jira**: None - Confluence-derived tracking item

## Motion Text

- <verbatim motion text>

## Notes

- This file mirrors Jira ticket structure for planning/documentation reuse.
- This item is Confluence-based rather than Jira-based.

## Comments

_<optional comments or "No additional comments captured." >_
```

## Quality Criteria (Completion Checks)

A generated Confluence ticket is complete only if all are true:

- The file is stored under `jira/confluence/<key>/`.
- The title, metadata, and motion text are present.
- A recorded vote is present in the format `<person1> / <person2> : <for>-<against>-<abstain>`.
- Existing Jira ticket markdown was checked for possible overlap before file creation.
- If likely Jira matches were found, the user was asked whether to use those tickets instead.
- Confluence provenance is explicit and includes the source URL.
- The file clearly states that it is not a Jira ticket.
- The structure is close enough to Jira ticket markdown to support later implementation planning.
- Any assumptions or inferred fields are identified in notes or the final report.

## Quick Invocation Examples

- `/create-confluence-ticket Create a confluence-derived ticket from this WGM motion and URL`
- `/create-confluence-ticket Use this Confluence link and approved motion text to create a planning-ready ticket`
- `/create-confluence-ticket Capture a Confluence decision under jira/confluence using Jira-style metadata`

## Notes

If the user has not supplied the page URL, the exact approved motion/decision text, and the recorded vote text, ask for the missing input before creating the file.

Before creating the file, always search existing Jira ticket markdown for possible overlap and ask the user if any candidate tickets should be used instead.

Prefer concise metadata, but do not omit source provenance or the explicit non-Jira marker.
