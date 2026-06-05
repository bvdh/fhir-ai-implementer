# Implementation Plan: FHIR-51160

## Scope Summary
- Workgroup/source: FHIR Infrastructure; ticket source is jira/active/FHIR-51160/FHIR-51160.md
- Tickets in scope: FHIR-51160
- Primary fix pattern: Correct a copied/incorrect wording fragment in a system-level CapabilityStatement comment

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-51160 | incorrect comments on CapabilityStatement.rest.searchParam | Resolved - change required | capabilitystatement-definitions.html#CapabilityStatement.rest.searchParam | Comment wording correction | Keep sentence structure, but replace "that also apply to this resource (...)" with "that apply to all resources." |

## Likely Edit Surface (Files and Lines)
1. System-level search parameter comment to correct
- fhir-fork/source/capabilitystatement/structuredefinition-CapabilityStatement.xml:1382
- fhir-fork/source/capabilitystatement/structuredefinition-CapabilityStatement.xml:1389
- fhir-fork/source/capabilitystatement/structuredefinition-CapabilityStatement.xml:1392
2. Resource-level search parameter comment for contrast/guardrail (verify-only)
- fhir-fork/source/capabilitystatement/structuredefinition-CapabilityStatement.xml:1215
- fhir-fork/source/capabilitystatement/structuredefinition-CapabilityStatement.xml:1218

## Shared Implementation Approach
1. Locate the `CapabilityStatement.rest.searchParam` comment in the structure definition source.
2. Apply the minimal text substitution requested by ticket resolution.
3. Preserve punctuation, escaping, and the remainder of the comment value unchanged.
4. Confirm the resource-level `CapabilityStatement.rest.resource.searchParam` comment is not modified unless explicitly required.

## Execution Steps
1. Open `structuredefinition-CapabilityStatement.xml` at `CapabilityStatement.rest.searchParam` and isolate the incorrect phrase segment inside the `<comment value="..."/>` text.
2. Replace only this segment:
- From: `that also apply to this resource (though many will be listed at [CapabilityStatement.rest.searchParam](capabilitystatement-definitions.html#CapabilityStatement.rest.searchParam)).`
- To: `that apply to all resources.`
3. Keep all remaining surrounding text intact, including the final sentence beginning `The behavior of some search parameters...` and the `special` guidance sentence.
4. Verify no changes were introduced in `CapabilityStatement.rest.resource.searchParam` comment text.
5. Review diff to ensure single-file, single-element, minimal-scope correction.

## Validation Checklist
- [ ] Ticket FHIR-51160 is mapped to concrete files under `fhir-fork/source/`
- [ ] Planned edits stay within `fhir-fork/source/`
- [ ] `CapabilityStatement.rest.searchParam` comment includes `that apply to all resources.`
- [ ] Removed phrase `that also apply to this resource (though many will be listed at [CapabilityStatement.rest.searchParam](...))` from system-level comment
- [ ] `CapabilityStatement.rest.resource.searchParam` comment remains unchanged
- [ ] No unrelated formatting/tooling/config changes

## Risks and Assumptions
- Risk: Over-editing the long XML comment string could unintentionally alter unrelated wording or escaping.
- Risk: Editing the wrong searchParam context (`rest.resource.searchParam` instead of `rest.searchParam`).
- Assumption: Resolution intent is scoped only to `CapabilityStatement.rest.searchParam` comment text.
- Open questions: None; ticket resolution text provides explicit replacement intent.
