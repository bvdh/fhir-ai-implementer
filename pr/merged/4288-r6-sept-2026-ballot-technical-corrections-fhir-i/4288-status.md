# PR #4288: R6 sept 2026 ballot Technical Corrections - FHIR-i

- Repository: [HL7/fhir](https://github.com/HL7/fhir)
- Pull request: [#4288](https://github.com/HL7/fhir/pull/4288)
- Status: `MERGED`
- Draft: false
- Branches: `r6-sept-2026-ballot-tc-fhiri` → `master`
- Review decision: not reported
- Created: 2026-08-18T08:32:48Z
- Updated: 2026-08-18T16:58:31Z
- Closed: 2026-08-18T16:58:29Z
- Merged: 2026-08-18T16:58:29Z
- Synced: 2026-10-20T12:17:58Z

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

FHIR-58621

**Summary**
This PR applies a set of technical corrections across FHIR source content, including async and best-practices updates plus a workflow messaging anchor/label fix.

**What changed**
Corrected the duplicated workflow option labeling in source/workflow-management.html:
The second Option I section is now Option J.
The section anchor is now optionj at the correct location.
Option K remains separately anchored.
Updated cross-reference in source/exchanging-messaging.html to point to workflow-management optionj.
Removed an accidental duplicate Asynchronous messaging header in source/exchanging-messaging.html.
Applied small wording/spelling fixes in source/exchanging-messaging.html for clarity.
Included prior branch technical corrections in:
source/async.html
source/best-practices.html
source/appointment/structuredefinition-Appointment.xml
source/domainresource/structuredefinition-DomainResource.xml
Commits in this PR
44e1164709 Fix async page technical corrections
0b23cb5d09 Fix best-practices page technical corrections
c1245c0144 Fix messaging option anchor and clean exchanging-messaging text

## Comments

### Review by lmckenzi

- Date: 2026-08-18T16:58:22Z
- Link: https://github.com/HL7/fhir/pull/4288#pullrequestreview-4963646019
- Review state: APPROVED

_No comment text._

