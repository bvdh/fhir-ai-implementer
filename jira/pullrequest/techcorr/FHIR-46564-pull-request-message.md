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

## Validation
- Confirmed replacement content is present in `source/messaging.html`:
  - `Asynchronous Application Responses`
  - `allowedResponse`
  - `$submit-message`
  - `Message Delivery without Operations`
- Confirmed legacy walkthrough block is absent from the replaced subsection.
- Confirmed change scope is limited to specification source content.

## Commit Reference
- Spec commit in `fhir-fork`: `c921f468e1152c4cac9f4b25da117caefb5d5843`

## Tracking Artifacts (outer repo)
- `jira/active/FHIR-46564/FHIR-46564.md`
- `jira/active/FHIR-46564/FHIR-46564-implementation-plan.md`
- `jira/active/FHIR-46564/FHIR-46564-implementation-change-log.md`
- `jira/active/FHIR-46564/FHIR-46564-commit-message.txt`
- Outer repo commit: `993770f3db320ca99eded87770e9b2ebdd314177`

## Notes
- Additional uncommitted changes currently exist in `fhir-fork/source/*` from unrelated work and are intentionally not part of this ticket scope.
