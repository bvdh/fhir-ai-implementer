# PR #4127: Fhir 46564

- Repository: [HL7/fhir](https://github.com/HL7/fhir)
- Pull request: [#4127](https://github.com/HL7/fhir/pull/4127)
- Status: `OPEN`
- Draft: false
- Branches: `FHIR-46564` → `master`
- Review decision: not reported
- Created: 2026-06-05T07:52:47Z
- Updated: 2026-10-20T11:54:36Z
- Closed: not reported
- Merged: not reported
- Synced: 2026-10-20T14:46:47Z

## Checks

| Check | Status | Conclusion |
|---|---|---|
| triage / eligibility | COMPLETED | SUCCESS |
| merge-audit | COMPLETED | SUCCESS |
| triage / build_timeout_alert | COMPLETED | SKIPPED |
| triage / triage | COMPLETED | SUCCESS |
| Master Branch Pipeline | COMPLETED | NEUTRAL |
| Pull Request Pipeline | COMPLETED | SUCCESS |


## Description

# PR Title
FHIR-46564: Replace asynchronous REST messaging subsection content

## Summary
This PR resolves FHIR-46564 by updating the asynchronous REST messaging section in the FHIR specification to match the agreed ticket resolution text.

## Ticket
- FHIR-46564: https://jira.hl7.org/browse/FHIR-46564

## What Changed
- Replaced the asynchronous REST messaging subsection content with resolution-aligned guidance.
- Clarified payload-level asynchronous responses versus protocol-level asynchronous processing.
- Added delayed-response handling guidance:
  - Use `MessageDefinition.allowedResponse` for in-progress/pended business responses when applicable.
  - Return HTTP 200 with no body for initial `$submit-message` when no immediate message-level response is available.
- Removed the superseded legacy step-by-step REST polling/search walkthrough block from the replaced subsection.

## Files Changed
- `source/messaging.html`


## Comments

No comments or reviews reported.

