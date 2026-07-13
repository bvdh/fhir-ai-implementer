# Implementation Plan: FHIR-57567

## Scope Summary
- Workgroup/source: FHIR Infrastructure; ticket file jira/active/FHIR-57567/FHIR-57567.md
- Tickets in scope: FHIR-57567
- Primary fix pattern: Clarify and/or complete core-spec guidance for the extension that authorizes additional-resource reference targets with work-group approval

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-57567 | Define an extension for additional resources to declare which core/additional resource reference elements may target them, with WG approval required before inclusion | Resolved - change required (Resolution: Persuasive) | references.html#additional (source: fhir-fork/source/references.html around lines 315-320) | Behavioral/spec guidance clarification with extension-link validation | The section already references `additional-resource-reference-target`; implementation should ensure wording and approval semantics align with ticket intent |

## Shared Implementation Approach
1. Use the ticket resolution/description as the source of truth for intended behavior and approval semantics.
2. Apply minimal wording updates in `fhir-fork/source/references.html` only if needed to fully reflect:
   - extension-driven declaration of allowed targets, and
   - responsible work-group approval before inclusion.
3. Preserve existing link/token style for extension references and keep changes tightly scoped.

## Execution Steps
1. Open `fhir-fork/source/references.html` and navigate to the Additional References subsection (`<a name="additional"></a>`, around lines 305-323).
2. Review the existing paragraph containing the extension link `[%extensions-location%]StructureDefinition-additional-resource-reference-target.html` (line ~317).
3. Check whether the extension exist, if not create it, if so check whether the definition corresponds to the intent of this ticket.
3. If needed, adjust wording so it explicitly captures both ticket requirements:
   - additional resources declare which reference elements can target them, and
   - the responsible work group must approve inclusion.
4. Keep the extension link format unchanged and compliant with repository conventions.
5. Verify no unrelated changes are made outside this subsection.
6. Run a localized consistency pass for adjacent fallback guidance (alternate-reference lines ~323-324) so behavior boundaries remain clear.

## Likely Impacted Files and Lines
- Primary edit target: `fhir-fork/source/references.html`
  - Additional reference scenario for additional resources: lines ~315-320
  - Extension link token and label: line ~317
  - Adjacent fallback guidance for alternate-reference: lines ~323-324
- Verification context only:
  - `fhir-fork/source/resource/resource-introduction.xml` Additional Resources section lines ~47-81 (no edit expected)

## Validation Checklist
- [ ] Ticket eligibility confirmed (`Resolution` present and `Status` = `Resolved - change required`)
- [ ] Planned edit remains inside `fhir-fork/source/`
- [ ] Additional-resource-target extension semantics match ticket intent
- [ ] Work-group approval requirement is explicitly represented in final wording
- [ ] Extension link token/label are consistent and unchanged unless correction is required
- [ ] Diff scope is limited to planned subsection in `references.html`
- [ ] No unrelated formatting/tooling changes

## Risks and Assumptions
- Risk: Existing wording may already satisfy ticket intent; over-editing could introduce unnecessary churn.
- Risk: Ticket language implies extension-definition work that may primarily live outside `fhir-fork/source/`; this plan intentionally limits implementation to core spec text/guidance in this repository.
- Assumption: For this workflow, implementation evidence in core-spec source is sufficient to satisfy `FHIR-57567` scope in this repository.
- Open questions:
  - Should execution include no-op validation-only outcome if current wording is already fully compliant?
  - Is any additional cross-reference needed to extension governance text elsewhere in core pages?
