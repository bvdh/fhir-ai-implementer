# Implementation Change Log: FHIR-55155

## Summary
- Plan: jira/active/FHIR-55155/FHIR-55155-implementation-plan.md
- Ticket: jira/active/FHIR-55155/FHIR-55155.md
- Execution date: 2026-06-05

## Files Changed
- fhir-fork/source/capabilitystatement/structuredefinition-CapabilityStatement.xml

## Changes Applied
1. Updated `CapabilityStatement.rest.resource.searchParam.type` comment to include the ticket-resolved fallback guidance: `If down-converting from a version of FHIR that has additional types, they would map to 'special'.`
2. Preserved existing short list and required binding canonical (`http://hl7.org/fhir/ValueSet/search-param-type`) with no terminology expansion.

## Validation Performed
- Plan and ticket key alignment (`FHIR-55155`): PASS
- Edits constrained to `fhir-fork/source/`: PASS
- Required down-conversion guidance to `special` present in target element comment: PASS
- No `unknown` or `other` concept additions in SearchParamType artifacts: PASS
- Diff scope contains only intended `CapabilityStatement` source change: PASS

## Proposed Instruction Update
Pattern observed: Some escape-valve tickets are resolved as explanatory mapping guidance rather than value set/code system expansion, and should be implemented as focused `comment` updates on the bound element.

Suggested addition to .github/instructions/fhir-fork.instructions.md:
- Escape Valve Comment-Only Resolution Rules
	- When ticket resolution explicitly maps unknown future values to an existing code (for example map additional types to `special`), implement the change as a targeted `comment` update on the bound `StructureDefinition` element.
	- Do not add new terminology concepts (`unknown`/`other`) when resolution text indicates explanation-only guidance.
	- Preserve the existing required binding canonical and short code list unless the ticket explicitly requires terminology expansion.

## Notes
- This ticket intentionally avoids SearchParamType code system/value set changes; behavior is clarified through element comment guidance.
- No build/tooling/config files were modified.
