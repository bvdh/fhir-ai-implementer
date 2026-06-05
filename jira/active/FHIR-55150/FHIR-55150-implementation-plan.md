# Implementation Plan: FHIR-55150

## Scope Summary
- Workgroup/source: FHIR Infrastructure; ticket source is jira/active/FHIR-55150/FHIR-55150.md
- Tickets in scope: FHIR-55150
- Primary fix pattern: wording clarification for mandatory required-bound element semantics (no value set escape concept added)

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-55150 | CapabilityStatement.kind has no escape valve | Resolved - change required | capabilitystatement.html | Wording/comment update | Resolution says no new code is needed; update definition text and add a comment indicating use of `requirements` as fallback |

## Shared Implementation Approach
1. Update `CapabilityStatement.kind` narrative text in source structure definition to match approved resolution wording.
2. Add explicit implementation guidance comment for fallback usage of `requirements`.
3. Keep terminology value set/code system concepts unchanged unless a direct contradiction is found.

## Execution Steps
1. Update the `CapabilityStatement.kind` definition in:
- `fhir-fork/source/capabilitystatement/structuredefinition-CapabilityStatement.xml` at lines 488-492.
- Replace the existing definition text
  - from: "...or a class of implementation (e.g. a desired purchase)."
  - to: "...or a general statement of implementation expectations (e.g. a desired purchase, a formal specification, etc.)."

2. Add a new comment to `CapabilityStatement.kind` in the same element block:
- File: `fhir-fork/source/capabilitystatement/structuredefinition-CapabilityStatement.xml` around line 492.
- Comment text intent: "Unless knowledge of a specific system or implementation are known, use 'requirements'."

3. Cross-check for mirrored wording reuse in terminology capabilities:
- Review `fhir-fork/source/terminologycapabilities/structuredefinition-TerminologyCapabilities.xml` lines 456-460 (same definition sentence currently present).
- Decision rule during execution:
  - If ticket intent is strictly CapabilityStatement-only, leave TerminologyCapabilities unchanged.
  - If consistency across both resources is expected for shared `CapabilityStatementKind` semantics, apply matching wording update there too.

4. Confirm no terminology expansion is required:
- Validate that no changes are planned to:
  - `fhir-fork/source/capabilitystatement/codesystem-capability-statement-kind.xml` lines 262-280
  - `fhir-fork/source/capabilitystatement/valueset-capability-statement-kind.xml` lines 41-47
- This aligns with resolution: no additional escape-valve concept (`unknown`/`other`) is introduced.

## Validation Checklist
- [ ] `CapabilityStatement.kind` definition exactly matches approved replacement wording
- [ ] `CapabilityStatement.kind` has explicit fallback comment for using `requirements`
- [ ] No new concepts were added to capability statement kind code system/value set
- [ ] Edits are limited to `fhir-fork/source/` only
- [ ] Any TerminologyCapabilities change decision is documented in implementation change log
- [ ] Diff remains minimal and ticket-traceable

## Risks and Assumptions
- Risk: Shared wording between CapabilityStatement and TerminologyCapabilities may diverge if only one file is changed.
- Assumption: Resolution applies directly to `CapabilityStatement.kind`; value set concept expansion is explicitly not required.
- Open questions: Should `TerminologyCapabilities.kind` wording be kept identical to `CapabilityStatement.kind` in this ticket, or handled separately if divergence is acceptable?
