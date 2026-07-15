# Implementation Plan: FHIR-48493

## Scope Summary
- Workgroup/source: Direct ticket scope from FHIR-48493 in jira/active/FHIR-48493/FHIR-48493.md
- Tickets in scope: FHIR-48493
- Primary fix pattern: Add missing UsageContext additional binding(s) so `UsageContext.valueCodeableConcept` is bound per `UsageContext.code`, matching the recommended value sets documented in the `usage-context-type` CodeSystem concept definitions.

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-48493 | UseageContext should be sliced to match valueCodeableConcept domains to code | Resolved - change required | Datatypes (UsageContext) | Additional binding addition/normalization | Resolution: add additional bindings with purpose 'preferred' where recommended value sets are documented; description notes binding strength (required/extensible) may vary by concept |

## Existing Implementation Context
`fhir-fork/source/datatypes/UsageContext-additional-bindings.xml` already implements this pattern (one `<additional>` block per `UsageContext.code` value) for 7 of the 10 `usage-context-type` codes:

| usage-context-type code | Current binding present | purpose | valueSet |
|---|---|---|---|
| gender | Yes | required | http://hl7.org/fhir/ValueSet/administrative-gender |
| focus | Yes | starter | http://hl7.org/fhir/ValueSet/condition-code |
| user | Yes | starter | http://hl7.org/fhir/ValueSet/provider-taxonomy |
| workflow | Yes | starter | http://terminology.hl7.org/ValueSet/v3-ActEncounterCode |
| task | Yes | starter | http://terminology.hl7.org/ValueSet/v3-ActTaskCode |
| venue | Yes | starter | http://terminology.hl7.org/ValueSet/v3-ServiceDeliveryLocationRoleType |
| jurisdiction | Yes | exetensible (typo for "extensible") | http://terminology.hl7.org/ValueSet/jurisdiction |
| age | **No** | — | recommended: http://terminology.hl7.org/ValueSet/v3-AgeGroupObservationValue (per THO concept definition) |
| species | No | — | No formal recommended value set in concept definition (illustrative SNOMED code only) |
| program | No | — | No recommended value set in concept definition |

Source for the code list and definitions: `http://terminology.hl7.org/CodeSystem/usage-context-type` (external THO resource, not editable in this fork).

## Likely Edit Surface (Files and Lines)
- fhir-fork/source/datatypes/UsageContext-additional-bindings.xml
  - Append one new `<additional>` block for `age`, following the existing block structure (key/purpose/valueSet/usage/any).
  - Optional/bonus: correct the pre-existing `purpose value="exetensible"` typo on the `jurisdiction` block to `extensible` while the file is open for edit (flag for explicit confirmation since it is not the literal ticket ask).

## Shared Implementation Approach
1. Do not touch the external `usage-context-type` CodeSystem; treat its published concept definitions as the authoritative source for "recommended value sets."
2. Add exactly one new additional-binding entry for the `age` code, since it is the only code among the 10 with a documented recommended value set that is not yet represented in `UsageContext-additional-bindings.xml`.
3. Use `purpose="preferred"` for the new `age` entry per the ticket Resolution text ("add additional bindings with purpose 'preferred'").
4. Do not add entries for `species` or `program`: their concept definitions do not name a specific recommended value set, so there is nothing concrete to bind.
5. Keep the new block's shape identical to sibling blocks (`key`, `purpose`, `valueSet`, `usage/code`, `usage/valueCodeableConcept/coding`, `any`).

## Execution Steps
1. Confirm current file state of `fhir-fork/source/datatypes/UsageContext-additional-bindings.xml` (7 existing `<additional>` blocks).
2. Insert a new `<additional>` block for `age`:
   - `key`: `uc-bind-age` (follows existing `uc-bind-<code>` naming convention)
   - `purpose`: `preferred`
   - `valueSet`: `http://terminology.hl7.org/ValueSet/v3-AgeGroupObservationValue`
   - `usage/code`: `UsageContext.code`
   - `usage/valueCodeableConcept/coding`: system `http://hl7.org/fhir/usage-context-type`, code `age`
   - `any`: `false`
3. Verify the `system` value used in sibling `usage/valueCodeableConcept/coding` blocks (`http://hl7.org/fhir/usage-context-type` vs `http://terminology.hl7.org/CodeSystem/usage-context-type`) and keep the new entry consistent with existing entries rather than introducing a second convention.
4. Ask/confirm before touching the pre-existing `exetensible` typo on the `jurisdiction` block, since it is outside the literal ticket ask; only fix if explicitly approved.
5. Rebuild (`./gradlew publish` from `fhir-fork`) and inspect the generated `metadatatypes.html`/UsageContext additional-bindings table for the new `age` row.
6. Confirm no other `usage-context-type` codes were altered and no unrelated file changes were introduced.

## Validation Checklist
- [ ] New `age` additional-binding entry present and structurally matches sibling entries
- [ ] `valueSet` target for `age` matches the THO-documented recommended value set (v3-AgeGroupObservationValue)
- [ ] `purpose` for the new entry is `preferred` per ticket Resolution wording
- [ ] `species` and `program` intentionally left unbound (no recommended value set documented) and this is recorded as a decision, not an oversight
- [ ] No edits made outside `fhir-fork/source/datatypes/UsageContext-additional-bindings.xml` unless explicitly approved (e.g., the `exetensible` typo fix)
- [ ] Publish build succeeds and renders the new binding
- [ ] Plan remains review-ready and references ticket intent

## Risks and Assumptions
- Risk: Ticket Resolution says purpose `preferred` uniformly, while the ticket Description says binding strength "will vary depending on concept"; the existing file already uses `required` and `starter` for other codes, so a reviewer may want a stronger/weaker strength than `preferred` for `age`. Flag for workgroup confirmation before final wording lock-in.
- Risk: The pre-existing `exetensible` typo on the `jurisdiction` entry is a latent defect discovered during this ticket's investigation but is not explicitly in scope; fixing it could be seen as scope creep.
- Assumption: `fhir-fork/source/datatypes/UsageContext-additional-bindings.xml` is the correct/only file needing an edit for this ticket (no separate generated/definitions file needs a matching change).
- Assumption: `species` and `program` are correctly out of scope because THO does not document a recommended value set for them.
- Open questions:
  - Should the `exetensible` typo be corrected as part of this ticket, or deferred to a separate technical correction?
  - Should `purpose` for the new `age` binding be `preferred` (per Resolution text) or something else (per Description text), and should existing `starter` entries be normalized to match?
