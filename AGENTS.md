# AI Coding Agent Instructions for fhir-ai-implementer

This repository manages AI-assisted work for resolving Jira tickets on the FHIR core specification.

## FHIR Fork Context

- The FHIR fork used by this project is git@github.com:bvdh/fhir-bvdh.git.
- It is a fork of https://github.com/HL7/fhir.git.
- The fork is expected in fhir-fork/.
- FHIR core extensions are stored in the `fhir-extensions-fork` repository.
- Tickets that primarily change FHIR core extensions should typically be implemented in `fhir-extensions-fork` rather than `fhir-fork`.

## Scope and Allowed Changes in the Fork

- When working in fhir-fork/, only files under fhir-fork/source/ are allowed to be modified.
- Do not modify files outside fhir-fork/source/ unless explicitly instructed by the user.

## Repository Rules

- Treat upstream HL7 FHIR conventions as authoritative for specification content.
- Do not change build tooling, scripts, Gradle configuration, CI pipelines, or implementation code in the fork unless explicitly requested.
- Prefer source edits over generated output edits.
- When ticket scope relates to FHIR core extensions, prefer making the change in `fhir-extensions-fork` unless the user explicitly directs otherwise.

## Interactive Questions

- Use `vscode_askQuestions` when a user needs to answer by clicking on options or when a task benefits from a constrained multiple-choice prompt.
- Prefer click-based questions over freeform text for discrete choices in this project.

## Required Workflow (Aligned with README)

When executing ticket work, follow this sequence:

1. In Jira, assign all tickets to be processed to the current user.
2. Download a new export of all relevant tickets.
3. Update local history and status of tickets in the jira directory.
4. Update tickets that were applied and merged:
	- Check PRs for non-applied tickets labeled PENDING-PR-REVIEW and verify whether the corresponding PR was merged.
	- Make a list of those tickets.
	- Ask the user to change status to applied.
5. Select one or more tickets to apply and list them in currentTickets.md at repository root.
	- The presence of currentTickets.md indicates active work in progress.
6. Update the GitHub fork so it aligns with the current HL7 FHIR repository.
7. Create a branch for work based on the current main FHIR repository state.
8. For each ticket listed in currentTickets.md:
	- For technical corrections, create a resolution proposal.
	- Create an implementation plan based on the proposal or spec resolution.
	- Inspect and correct the plan, then select the accepted solution directory.
	- Implement the plan.
	- Check outcome against plan and ticket resolution.
	- Commit changes with a message describing the change and mentioning the FHIR ticket in the title.
	- Document rationale and changes in relevant ticket files under jira.
9. When all tickets in currentTickets.md are resolved, create a pull request listing all tickets and summarizing the changes.
10. Ask the user to update all tickets with a PR link in comments and add grouping tag PENDING-PR-REVIEW.

## Agent Behavior Expectations

- Keep changes minimal, traceable, and tied to ticket intent.
- If a requested action conflicts with this workflow, ask the user for explicit override.