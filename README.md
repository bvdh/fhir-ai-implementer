# fhir-ai-implementer
Set of AI files, scripts and records of ongoing work used to ease committing resolutions to FHIR tickets.

## Process supported

This project contains LLM scripts that help with the resolution of the Jira tickets on the FHIR core specification.

Update to applied: 

1. In Jira, assign all tickets to be processed to the current user.
2. Download a new export of all relevant tickets.
3. Update the local history/status of the tickets in the jira directory.
3. Update the tickets that have been applied and merged  
   1. Check the PRs for non-applied tickets labeled as PENDING-PR-REVIEW whether the corresponding PR (see PR description) has been merged
   2. Make a list of all those tickets 
   3. And ask the user to change the status to applied.
5. Create a selection of one or more tickets to apply and list them in file currentTickets.md in the root of the repo. The presence of this file signals that there is work in progress and to what tickets the work relates.
6. Update the github fork to align with the current version of the FHIR core github repo
7. Create a branch for the commit that reflects the current version of the main FHIR github repo.
8. For each ticket listed in currentTickets.md.
   1.  For technical corrections: created resolution proposal.
   2.  Create implementation plan based on the technical correction proposal or the resolution in the spec.
   3.  Inspect the plan, correct it and select the accepted solution directory
   4.  Implement the plan
   5.  Check the outcome against the plan and the ticket resolution
   6.  Commit it in using a commit message that describes the made change and mentions the FHIR ticket in the title.
   7.  Document the rationale and changes in the relevant ticket files under jira.
9.  When all tickets in currentickets.md have been resolved, create a pull request that lists all tickets and a summary of the changes.
10. Ask the use to update all tickets to hold a link to the PR in the comments; add a tag/grouping stating PENDING-PR-REVIEW
