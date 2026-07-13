# Implementation Plan: FHIR-57565

## Scope Summary
- Workgroup/source: FHIR Infrastructure; ticket file jira/active/FHIR-57565/FHIR-57565.md
- Tickets in scope: FHIR-57565
- Primary fix pattern: Update additional-resource definition-space rule to require `http://hl7.org/fhir` canonical space instead of requiring a non-core canonical space

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-57565 | Modify rule for additional-resource definition space from "not http://hl7.org/fhir" to requiring "http://hl7.org/fhir" | Resolved - change required (Resolution: Persuasive) | structuredefinition.html#additional (source: fhir-fork/source/structuredefinition/structuredefinition-notes.xml) | Normative rule clarification | Current rule says canonical URL is in a non-core space; ticket requires inversion to `http://hl7.org/fhir` |

## Shared Implementation Approach
1. Use the Jira resolution text as authoritative wording intent.
2. Apply a minimal, explicit wording change in the Additional Resource definition rules source (`structuredefinition-notes.xml`).
3. Verify that nearby examples and cross-references remain coherent with the updated canonical-space rule.

## Execution Steps
1. Open `fhir-fork/source/structuredefinition/structuredefinition-notes.xml` and navigate to the "Using StructureDefinitions to Define Additional Resource" section.
2. Update the bullet at line ~232 that currently states: canonical URL is in "some other canonical space than `http://hl7.org/fhir`".
3. Replace that rule with wording that requires the additional-resource definition canonical URL to be in the `http://hl7.org/fhir` space, matching ticket intent.
4. Review adjacent bullets in the same section (lines ~233-247) to ensure no contradictory language remains after the rule inversion.
5. Re-check the example block (lines ~253-267) for consistency with the revised canonical-space rule; adjust example URL only if needed for internal consistency.
6. Perform a narrow consistency pass on nearby narrative references to additional resources in:
   - `fhir-fork/source/resource/resource-introduction.xml` (Additional Resources introduction, lines ~47-81)
   - `fhir-fork/source/references.html` (Additional References discussion, lines ~305-323)
   No edit is planned in these files unless explicit inconsistency is found.

## Likely Impacted Files and Lines
- Primary edit target: `fhir-fork/source/structuredefinition/structuredefinition-notes.xml`
  - Additional-resource canonical-space rule: line ~232
  - Adjacent constraints for the same rule set: lines ~233-247
  - Example JSON block that may need harmonization: lines ~253-267
- Verification context only:
  - `fhir-fork/source/resource/resource-introduction.xml` lines ~47-81
  - `fhir-fork/source/references.html` lines ~305-323

## Validation Checklist
- [ ] Ticket eligibility confirmed (`Resolution` present and `Status` = `Resolved - change required`)
- [ ] Planned edit stays within `fhir-fork/source/`
- [ ] Canonical-space rule text now clearly requires `http://hl7.org/fhir`
- [ ] No contradictory wording remains in the same Additional Resource rules block
- [ ] Example and surrounding guidance remain internally consistent
- [ ] No unrelated formatting/tooling changes
- [ ] Plan remains traceable to Jira ticket intent

## Risks and Assumptions
- Risk: Inverting canonical-space guidance could conflict with existing IG ecosystem conventions if not coordinated with related additional-resource governance text.
- Risk: Example URLs in the same section may implicitly assume non-core canonical spaces and could become misleading if left unchanged.
- Assumption: Jira resolution "Persuasive" plus status "Resolved - change required" is sufficient authorization to update normative rule wording in `structuredefinition-notes.xml`.
- Open questions:
  - Should companion guidance be added to explain migration/compatibility for existing additional resources currently defined outside `http://hl7.org/fhir`?
  - Should this rule change also be reflected in any registration-process documentation beyond core spec text?
