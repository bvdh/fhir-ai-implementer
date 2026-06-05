# Implementation Plan: FHIR-55170

## Scope Summary
- Workgroup/source: jira/open/FHIR-55170 (moved to jira/active/FHIR-55170)
- Tickets in scope: FHIR-55170
- Primary fix pattern: relax the page-generation constraint on ImplementationGuide and add explicit fallback guidance in the element documentation

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-55170 | ImplementationGuide.definition.page.generation has no escape valve | Resolved - change required | ImplementationGuide.definition.page.generation | Constraint removal + documentation update | Keep the required binding; do not expand the value set unless review later reopens that path |

## Shared Implementation Approach
1. Work only in fhir-fork/source/ and keep the change anchored to the ImplementationGuide structure definition.
2. Remove the `ig-3` invariant from `ImplementationGuide.definition.page.generation` so the element is not blocked by the existing constraint.
3. Update the element documentation to explain the fallback approach for future or alternate page-generation mechanisms, including the guidance to use `generated` together with an extension when a new mechanism is needed.
4. Leave the Guide Page Generation code system and value set unchanged unless a later review explicitly asks for an enum expansion.

## Execution Steps
1. Edit `fhir-fork/source/implementationguide/structuredefinition-ImplementationGuide.xml` at the `ImplementationGuide.definition.page.generation` element, removing the `ig-3` condition from the element definition.
2. Rewrite the element `definition` and/or `comment` text so it states the intended escape valve for future capabilities: use `generated` and describe the new generation mechanism through an extension.
3. Verify the surrounding `ImplementationGuide.definition.page.generation` metadata still has the required binding and the existing `GuidePageGeneration` value set reference.
4. Check the generated/derived implementation guide documentation artifacts under `fhir-fork/source/implementationguide/` for consistency, especially the definitions rendering and any diagram text derived from the structure definition.
5. Confirm no unrelated implementation-guide pages, code systems, or value sets were modified as part of this fix.

## Validation Checklist
- [ ] `ImplementationGuide.definition.page.generation` no longer carries the `ig-3` condition.
- [ ] The element documentation explicitly describes the `generated` + extension fallback for future mechanisms.
- [ ] The required binding to `GuidePageGeneration` remains intact.
- [ ] No value set or code system concepts were added unnecessarily.
- [ ] All edits stay within `fhir-fork/source/`.
- [ ] Derived docs/diagrams remain consistent with the updated source.

## Risks and Assumptions
- Risk: removing the invariant may affect downstream tooling assumptions if the guidance text is not clear enough about the intended fallback.
- Risk: the generated documentation may need a rebuild to reflect the updated wording even though the source change is localized.
- Assumption: the fix is intentionally documentation-led rather than an enum expansion, based on the ticket resolution description.
- Open question: whether any adjacent ImplementationGuide narrative page should cross-link this guidance for discoverability, or whether the element-level documentation is sufficient.
