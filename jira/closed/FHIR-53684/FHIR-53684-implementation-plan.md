# Implementation Plan: FHIR-53684

## Scope Summary
- Workgroup/source: Ticket markdown in `jira/active/FHIR-53684/FHIR-53684.md`
- Tickets in scope: FHIR-53684
- Primary fix pattern: Specification narrative clarification (no new `ImplementationGuide.abstract` element) plus alignment text about declaring conformance and use of `useContext`

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-53684 | Add "abstract" flag to ImplementationGuide | Resolved - change required | ImplementationGuide notes + related conformance clarifications | Wording/structural documentation update | Resolution says "Not Persuasive with Modification": do not add abstract flag; add "Declaring conformance to guides" guidance and reference `ImplementationGuide.useContext` |

## Likely Edit Surface (Files and Lines)
- `fhir-fork/source/implementationguide/implementationguide-notes.xml:38`
- `fhir-fork/source/implementationguide/implementationguide-notes.xml:70`
- `fhir-fork/source/implementationguide/structuredefinition-ImplementationGuide.xml:330`
- `fhir-fork/source/capabilitystatement/structuredefinition-CapabilityStatement.xml:746`

Line mapping rationale:
- `implementationguide-notes.xml` currently has role-oriented narrative sections and is the most likely location for a new subsection titled "Declaring conformance to guides".
- `structuredefinition-ImplementationGuide.xml` contains `ImplementationGuide.useContext` definitions/comments likely to need wording alignment.
- `structuredefinition-CapabilityStatement.xml` already contains explanatory commentary for `CapabilityStatement.implementationGuide` vs `CapabilityStatement.instantiates`; may need consistency tuning with the new notes text.

## Shared Implementation Approach
1. Keep all edits inside `fhir-fork/source/` and focus on narrative/definition text only.
2. Implement the ticket resolution literally: guidance addition and clarification, not schema expansion.
3. Ensure cross-page consistency between ImplementationGuide notes, `useContext` narrative, and CapabilityStatement conformance commentary.

## Execution Steps
1. Open `fhir-fork/source/implementationguide/implementationguide-notes.xml`.
2. Add a new subsection under Implementation Guide notes named `Declaring conformance to guides` (or equivalent anchor/heading style used in file).
3. Add resolution-aligned text covering:
- Contractual/regulatory references to IGs.
- Why some guides are not appropriate to reference as direct implementation targets.
- Need to point to child `CapabilityStatement` and/or `ActorDefinition` resources when those are the concrete conformance targets.
- Recommendation that guides clearly declare intended purpose and use.
4. Include explicit mention that `ImplementationGuide.useContext` can help communicate intended purpose in a computable way.
5. Review `fhir-fork/source/implementationguide/structuredefinition-ImplementationGuide.xml` at `ImplementationGuide.useContext` and adjust comment text only if needed to align with the new guidance without changing element cardinality/type.
6. Review `fhir-fork/source/capabilitystatement/structuredefinition-CapabilityStatement.xml` comment on `CapabilityStatement.implementationGuide` and adjust wording only if needed for consistency with the new notes section.
7. Confirm no attempt is made to add `ImplementationGuide.abstract` or any new element/extension in this ticket.
8. Perform a terminology pass for consistency of terms: `implementation guide`, `CapabilityStatement.implementationGuide`, `CapabilityStatement.instantiates`, `ImplementationGuide.useContext`.
9. run ./gradlew publish and check with user that the changes are made correctly.

## Validation Checklist
- [ ] FHIR-53684 is mapped to at least one concrete source file and section.
- [ ] Planned edits remain within `fhir-fork/source/` only.
- [ ] No new `abstract` flag/element is introduced in `ImplementationGuide` structure definitions.
- [ ] New "Declaring conformance to guides" guidance appears in ImplementationGuide notes.
- [ ] Guidance explicitly references `ImplementationGuide.useContext` as computable support for intended purpose.
- [ ] Any CapabilityStatement commentary changes remain consistent with `implementationGuide` vs `instantiates` semantics.
- [ ] No unrelated formatting/tooling/build changes are introduced.

## Risks and Assumptions
- Risk: Existing normative wording in `CapabilityStatement` comments may already capture portions of the intended guidance; over-editing could create duplication.
- Risk: Exact section heading style/anchor conventions in `implementationguide-notes.xml` may require local adaptation.
- Assumption: Ticket scope is limited to documentation/specification wording and does not require model/schema change.
- Assumption: Cross-reference ticket FHIR-48768 remains informational and does not require implementation in this change.
- Open questions: Should the new notes section include an explicit link to `ActorDefinition` and `CapabilityStatement` pages, or rely on plain text references only?
