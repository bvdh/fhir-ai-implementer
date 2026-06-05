# Implementation Plan: FHIR-54057

## Scope Summary
- Workgroup/source: FHIR Infrastructure; ticket source is jira/active/FHIR-54057/FHIR-54057.md
- Tickets in scope: FHIR-54057
- Primary fix pattern: capability cleanup via deprecations and interaction-code normalization for conditional behavior in CapabilityStatement

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-54057 | Clean up conditional* elements in CapabilityStatement | Resolved - change required | capabilitystatement.html (5.3.4) | Structural + terminology/deprecation | Resolution requires adding `read-conditional-modified-since` and `read-conditional-not-match` interaction codes, and deprecating `conditionalCreate`, `conditionalRead`, `conditionalUpdate`, `conditionalDelete`, `conditionalPatch` plus associated value sets/code systems where they exist |

## Shared Implementation Approach
1. Update REST interaction code definitions first so replacement interaction semantics are available.
2. Mark conditional* CapabilityStatement resource elements as deprecated with explicit migration guidance to interaction codes.
3. Deprecate associated conditional status code systems/value sets while preserving backward-compatibility text.
4. Keep edits minimal and confined to `fhir-fork/source/`.

## Execution Steps
1. Add new interaction codes in the RESTful interaction code system and include them in the type-level interaction value set.
- Primary file: `fhir-fork/source/codesystem/codesystem-restful-interaction.xml` (insert near existing conditional interactions at lines 44-71 and read section at lines 29-36).
- Value set inclusion: `fhir-fork/source/capabilitystatement/valueset-type-restful-interaction.xml` (compose list around lines 323-370).
- Ensure labels/definitions align with existing naming style (`*-conditional-*`).

2. Update CapabilityStatement element metadata for the five conditional* fields to deprecated status and migration guidance.
- File: `fhir-fork/source/capabilitystatement/structuredefinition-CapabilityStatement.xml`.
- Target element blocks:
  - `conditionalCreate` lines 1061-1071
  - `conditionalRead` lines 1072-1090
  - `conditionalUpdate` lines 1091-1101
  - `conditionalPatch` lines 1102-1112
  - `conditionalDelete` lines 1113-1130
- Add deprecation signaling consistent with FHIR style (e.g., standards-status extension and/or explicit deprecation comment text used in neighboring artifacts), with instructions to use interaction codes (`create-conditional`, `update-conditional`, `patch-conditional`, `delete-conditional-single`, `delete-conditional-multiple`, and the two new read-conditional codes).

3. Deprecate associated conditional status artifacts where they exist.
- `fhir-fork/source/capabilitystatement/codesystem-conditional-read-status.xml` (metadata block lines 8-13, status at line 27, concepts lines 45-64).
- `fhir-fork/source/capabilitystatement/valueset-conditional-read-status.xml` (status/compose metadata; line anchors to confirm during execution).
- `fhir-fork/source/capabilitystatement/codesystem-conditional-delete-status.xml` (metadata block lines 8-13, status at line 32, concepts lines 50-64).
- `fhir-fork/source/capabilitystatement/valueset-conditional-delete-status.xml` (status/compose metadata; line anchors to confirm during execution).
- If deprecating these artifacts requires terminology-page narrative updates, apply only directly related wording updates.

4. Align derived textual summaries that enumerate allowed interaction codes.
- `fhir-fork/source/capabilitystatement/structuredefinition-CapabilityStatement.xml` short list at line 990 should include the new read-conditional codes if this short string remains authoritative.
- Review any corresponding capabilitystatement narrative templates for references that need migration notes:
  - `fhir-fork/source/capabilitystatement/capabilitystatementNarrative.xslt` around lines 222, 247, 254, 260.
- Only edit if directly needed for consistency with deprecation guidance.

5. Cross-file consistency and scope control.
- Ensure deprecation wording in structure definition and terminology artifacts is aligned.
- Ensure only ticket-related files under `fhir-fork/source/` are changed.

## Validation Checklist
- [ ] Ticket mapped to concrete files and line ranges before editing
- [ ] New interaction codes `read-conditional-modified-since` and `read-conditional-not-match` are present in both code system and relevant value set
- [ ] `conditionalCreate`, `conditionalRead`, `conditionalUpdate`, `conditionalDelete`, `conditionalPatch` are marked deprecated with migration guidance
- [ ] Associated conditional read/delete value sets and code systems are deprecated where present
- [ ] No edits outside `fhir-fork/source/`
- [ ] No unrelated formatting/tooling/build changes
- [ ] Diff is reviewable and directly traceable to FHIR-54057 resolution

## Risks and Assumptions
- Risk: Deprecation mechanism may vary by artifact type (StructureDefinition vs CodeSystem/ValueSet), requiring adherence to existing local conventions.
- Assumption: Existing `modified-since`/`not-match` values in conditional-read-status remain for backward compatibility while new interaction codes become preferred forward path.
- Open questions: Should `conditionalRead` be deprecated now despite ticket notes initially distinguishing it, given resolution explicitly includes deprecating `conditionalRead`?
