# Implementation Plan: FHIR-54000

## Scope Summary
- Workgroup/source: FHIR Infrastructure; ticket file `jira/active/FHIR-54000/FHIR-54000.md`
- Tickets in scope: FHIR-54000
- Primary fix pattern: Broaden `SearchParameter.base`/`SearchParameter.target` to support Additional Resources by changing datatype/binding and aligning explanatory wording with existing `CapabilityStatement` pattern

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-54000 | Bindings on SearchParameter should support Additional Resources | Resolved - change required (Resolution: Persuasive with Modification) | `searchparameter.html` / SearchParameter definition | Structural + wording clarification | Resolution also requires changing datatype to `uri` and reusing established explanatory pattern |

## Shared Implementation Approach
1. Treat ticket `Resolution Description` as the source-of-truth for both required changes:
   - datatype update (`code` -> `uri`) for `SearchParameter.base` and `SearchParameter.target`
   - binding update to extended resource types and explanatory wording consistent with prior additional-resource handling.
2. Constrain edits to `fhir-fork/source/` and keep the smallest possible hunk set.
3. Use `CapabilityStatement.rest.resource.type` wording/style as the consistency reference.

## Execution Steps
1. Open `fhir-fork/source/searchparameter/structuredefinition-SearchParameter.xml`.
2. In element `SearchParameter.base` (around lines 505-534):
   - change datatype from `<code value="code"/>` to `<code value="uri"/>`
   - update binding from `http://hl7.org/fhir/ValueSet/version-independent-all-resource-types` to `http://hl7.org/fhir/ValueSet/extended-resource-types`
   - update short descriptive binding text if needed so it explicitly allows additional resources and avoids fixed-list semantics.
3. In element `SearchParameter.target` (around lines 596-625):
   - change datatype from `<code value="code"/>` to `<code value="uri"/>`
   - update binding from `http://hl7.org/fhir/ValueSet/version-independent-all-resource-types` to `http://hl7.org/fhir/ValueSet/extended-resource-types`
   - align descriptive text with the same additional-resource explanation used elsewhere.
4. Use `fhir-fork/source/capabilitystatement/structuredefinition-CapabilityStatement.xml` as the style reference (around lines 897-917, `CapabilityStatement.rest.resource.type`) for:
   - `uri` datatype use
   - non-fixed-list language for additional resources
   - `extended-resource-types` binding semantics.
5. If any SearchParameter narrative/notes become inconsistent after structural changes, apply minimal follow-up text alignment in `fhir-fork/source/searchparameter/searchparameter-notes.xml`.
6. Run a scoped diff review to ensure only intended SearchParameter-related files changed.

## Likely Impacted Files and Lines
- Primary target: `fhir-fork/source/searchparameter/structuredefinition-SearchParameter.xml`
  - `SearchParameter.base` block: ~505-534
  - `SearchParameter.target` block: ~596-625
- Consistency reference (usually no edit expected): `fhir-fork/source/capabilitystatement/structuredefinition-CapabilityStatement.xml`
  - `CapabilityStatement.rest.resource.type`: ~897-917
- Optional follow-up if wording drift appears: `fhir-fork/source/searchparameter/searchparameter-notes.xml` (context near references to `SearchParameter.base` around line 24)

## Validation Checklist
- [x] Ticket eligibility confirmed (`Resolution` present, `Status` = `Resolved - change required`)
- [ ] `SearchParameter.base` datatype changed to `uri`
- [ ] `SearchParameter.target` datatype changed to `uri`
- [ ] Both bindings use `http://hl7.org/fhir/ValueSet/extended-resource-types`
- [ ] Wording aligns with additional-resource guidance style used in `CapabilityStatement`
- [ ] Planned/actual edits stay within `fhir-fork/source/`
- [ ] No unrelated formatting/tooling changes

## Risks and Assumptions
- Risk: Changing datatype from `code` to `uri` may require careful wording updates to avoid ambiguity with legacy expectations.
- Risk: Binding text could drift from established language if not normalized against `CapabilityStatement`.
- Assumption: `structuredefinition-SearchParameter.xml` is the authoritative source for these element constraints in this workflow.
- Open question: whether downstream generated artifacts will need a separate regeneration pass after source merge (outside this planning step).
