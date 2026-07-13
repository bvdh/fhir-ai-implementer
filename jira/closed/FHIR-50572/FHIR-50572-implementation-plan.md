# Implementation Plan: FHIR-50572

## Scope Summary
- Workgroup/source: FHIR Infrastructure; ticket file jira/active/FHIR-50572/FHIR-50572.md
- Tickets in scope: FHIR-50572
- Primary fix pattern: Normative conformance wording update in Additional Resources rule text (`must` -> `SHALL`)

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-50572 | Add conformance language to Additional Resources rule 3 | Resolved - change required (Resolution: Persuasive) | resource.html#additional (source: fhir-fork/source/resource/resource-introduction.xml) | Terminology/conformance-language normalization | The third bullet currently uses `must`; ticket requests `SHALL` for absolute requirement wording |

## Shared Implementation Approach
1. Edit the source-of-truth narrative in `fhir-fork/source/resource/resource-introduction.xml` only.
2. Apply the minimal single-term substitution in the targeted bullet sentence.
3. Preserve all surrounding wording, list structure, and punctuation.

## Execution Steps
1. Open `fhir-fork/source/resource/resource-introduction.xml` and locate the `Additional Resources Defined Outside This Specification` section.
2. Locate the third rule bullet around line ~59:
   - `Registered and approved resources are given a name by HL7, and this is the name that must be used for the resource`
3. Replace `must` with `SHALL` in that sentence only.
4. Confirm no additional normative-language changes are introduced in nearby bullets.
5. Review the resulting diff to ensure exactly one intended sentence-level change.

## Likely Impacted Files and Lines
- Primary edit target: `fhir-fork/source/resource/resource-introduction.xml`
  - Section heading: line ~49
  - Target rule bullet sentence: line ~59
- Verification context only:
  - Generated rendering path (no direct edit): `fhir-fork/publish/resource.html` (post-build output)

## Validation Checklist
- [ ] Ticket eligibility confirmed (`Resolution` present and `Status` = `Resolved - change required`)
- [ ] Planned edit stays within `fhir-fork/source/`
- [ ] Target sentence now uses `SHALL` exactly once in place of `must`
- [ ] No unrelated wording or formatting changes in the same section
- [ ] Diff scope is limited to intended bullet sentence in `resource-introduction.xml`
- [ ] Plan remains review-ready and traceable to ticket intent

## Risks and Assumptions
- Risk: Normative-language edits require explicit user approval before source execution per repository instruction rules.
- Risk: Over-editing surrounding list content could unintentionally alter requirement semantics beyond ticket scope.
- Assumption: Ticket resolution intent is limited to the third rule wording in the Additional Resources section.
- Open questions:
  - Should any matching non-normative prose elsewhere be aligned, or only the explicitly cited third rule?
  - Is there any publication-note requirement for a normative-language tightening in this section?
