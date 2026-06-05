# Implementation Plan: FHIR-46564

## Scope Summary
- Workgroup/source: Ticket markdown in `jira/active/FHIR-46564/FHIR-46564.md`
- Tickets in scope: FHIR-46564
- Primary fix pattern: Content clarification and section-level wording update for asynchronous messaging behavior in RESTful exchange

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-46564 | Clarify 3.5.4.1 Asynchronous Messaging using the RESTful API, including orchestration context and polling/subscription expectations | Resolved - change required | `fhir-fork/source/messaging.html` (Asynchronous section) | Wording/content clarification | Resolution text proposes replacing/expanding the asynchronous subsection and adding implementation note alignment |

## Likely Edit Surface (Files and Lines)
- `fhir-fork/source/messaging.html:393`
- `fhir-fork/source/messaging.html:399`
- `fhir-fork/source/messaging.html:402`
- `fhir-fork/source/messaging.html:441`

Notes on line targets:
- Line locations are based on current branch state and identify the full subsection bounded by the `<h3>Asynchronous Messaging using the RESTful API</h3>` heading and the next section heading.
- Expect line drift after edits; preserve section boundaries and semantics.

## Shared Implementation Approach
1. Replace the asynchronous messaging subsection content in `fhir-fork/source/messaging.html`.
2. Apply resolution-approved wording that distinguishes payload-level messaging asynchrony from protocol-level async handling.
3. Keep all edits minimal, traceable to ticket intent, and consistent with existing specification style.

## Execution Steps
1. Open `fhir-fork/source/messaging.html` and isolate the subsection beginning at the heading `Asynchronous Messaging using the RESTful API`.
2. Replace the opening explanatory paragraph(s) to align with the approved resolution:
- Clarify that REST transport interactions are not always immediate and that messaging handles asynchronous business responses as message payloads.
- Preserve the low-volume exchange framing while improving precision.
3. Add or refine paragraph content describing delayed processing outcomes:
- Case A: return an in-progress/pended business response when supported by `MessageDefinition.allowedResponse`.
- Case B: return HTTP 200 with empty body when no immediate message-level response is appropriate.
4. Ensure the text explains that eventual full responses are conveyed as follow-up messages from recipient back to requester.
5. Add/update implementation note text for message identity consistency:
- Confirm current-release guidance uses `Bundle.identifier` for message identity.
- Ensure note language remains consistent with surrounding sections.
6. Remove legacy protocol walkthrough text from this subsection when it conflicts with the "update the section as follows" replacement intent.
7. Perform a final terminology pass in the subsection:
- Consistent use of "message", "response", "recipient/requester", and REST references.
- Maintain heading structure and avoid unrelated edits in adjacent sections.

## Validation Checklist
- [ ] Ticket FHIR-46564 is mapped to at least one concrete source file and subsection.
- [ ] Planned edits stay within `fhir-fork/source/` only.
- [ ] Updated text reflects the Jira resolution intent (payload-level asynchronous handling, delayed response options).
- [ ] Section reflects replacement intent and does not retain superseded legacy explanatory blocks from the prior version.
- [ ] No unrelated formatting, tooling, or build file changes are introduced.
- [ ] Final wording is terminology-consistent with nearby messaging sections.

## Risks and Assumptions
- Risk: Resolution text in Jira is more detailed than current section context; direct insertion may require light adaptation to match spec voice.
- Risk: Minor line-reference drift after edits may complicate review diffs if additional nearby adjustments are needed.
- Assumption: `fhir-fork/source/messaging.html` is the sole normative source for this subsection in the current workflow.
- Assumption: No parallel ticket requires conflicting edits in the same subsection on this branch.
- Open questions: Should the resulting text include an explicit inline reference to `async.html`, or keep explanation fully self-contained in `messaging.html` to avoid over-cross-linking?
