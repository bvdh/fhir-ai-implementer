# Implementation Plan: FHIR-54053

## Scope Summary
- Workgroup/source: FHIR Infrastructure; ticket source is jira/active/FHIR-54053/FHIR-54053.md
- Tickets in scope: FHIR-54053
- Primary fix pattern: wording and section cleanup in CapabilityStatement notes to align with R6 status and approved resolution

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-54053 | Update MessageDefinition-related bullet point for CapabilityStatement | Resolved - change required | capabilitystatement.html (section 5.3.5 Notes, Messaging rules) | Structural wording removal | Resolution says to remove the whole "Messaging CapabilityStatement rules" section. Likely source edit surface: fhir-fork/source/capabilitystatement/capabilitystatement-notes.xml:22-34 |

## Shared Implementation Approach
1. Locate notes content under fhir-fork/source/capabilitystatement/.
2. Remove the full Messaging CapabilityStatement rules list item (not just the MessageDefinition sentence) to match approved resolution text.
3. Keep surrounding Notes sections intact and preserve XHTML structure.

## Execution Steps
1. Open fhir-fork/source/capabilitystatement/capabilitystatement-notes.xml and inspect lines 22-34.
2. Remove the complete block:
- Opening list item at line 22: Messaging CapabilityStatement rules:
- Nested dense list lines 23-33
- Closing list item line 34
3. Verify neighboring sections remain valid and contiguous:
- RESTful CapabilityStatement rules ends at line 21
- Document CapabilityStatement rules starts at line 35
4. Confirm no parallel stale wording exists that should be updated for consistency (review-only targets, no planned edits unless exact duplicate policy text is found):
- fhir-fork/source/capabilitystatement/structuredefinition-CapabilityStatement.xml:1463-1498 (supportedMessage definitions)
- fhir-fork/source/capabilitystatement/capabilitystatement-messagedefinition.xml:46-49 (example usage)
5. Run a focused diff to ensure only the intended source file changed under fhir-fork/source/.

## Validation Checklist
- [ ] Ticket FHIR-54053 is mapped to at least one concrete source file and line range
- [ ] Planned edit is restricted to fhir-fork/source/ only
- [ ] Messaging CapabilityStatement rules section is fully removed from capabilitystatement-notes.xml
- [ ] Surrounding Notes content renders as valid list structure after edit
- [ ] No unrelated formatting/tooling or non-source changes are introduced
- [ ] Final diff is traceable to ticket intent and resolution text

## Risks and Assumptions
- Risk: Removing the entire Messaging rules block may be broader than stakeholders expect if only the draft-status sentence was intended.
- Assumption: Resolution description is authoritative and requires removing the whole Messaging rules section, not replacing wording.
- Open questions: Should any retained messaging guidance be relocated elsewhere (for example to messaging-specific pages), or is full removal from CapabilityStatement notes the desired end state?
