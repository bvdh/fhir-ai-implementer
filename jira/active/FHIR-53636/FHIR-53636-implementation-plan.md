# Implementation Plan: FHIR-53636

## Scope Summary
- Workgroup/source: FHIR Infrastructure; ticket file jira/active/FHIR-53636/FHIR-53636.md
- Tickets in scope: FHIR-53636
- Primary fix pattern: Wording clarification for id datatype whitespace semantics (all whitespace prohibited)

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| FHIR-53636 | Clarify that Element.id prohibits all whitespace, not just the space character | Resolved - change required | Datatypes (primitive id) | Clarification wording + regex intent confirmation | Keep edit minimal and aligned with existing id regex semantics |

## Likely Edit Surface (Files and Line References)
| File | Line | Purpose |
|---|---:|---|
| fhir-fork/source/datatypes/primitives.xml | ~304 | id primitive narrative text; likely place to add explicit all-whitespace prohibition wording |
| fhir-fork/source/datatypes/primitives.xml | ~309 | id regex source value (`[A-Za-z0-9\-\.]{1,64}`); verification anchor for no-whitespace semantics |
| fhir-fork/source/datatypes.html | ~204 | rendered id narrative text in primitive table; likely wording sync point |
| fhir-fork/source/datatypes.html | ~210 | `[%regex id%]` reference; verification anchor that page remains token-wired |
| fhir-fork/source/datatypes.html | ~427 | "About the id datatype" notes section; optional clarification placement if table wording alone is insufficient |

## Shared Implementation Approach
1. Locate id primitive source narrative and keep regex unchanged unless ticket evidence requires otherwise.
2. Add concise wording that makes explicit that id excludes all whitespace characters, not only literal spaces.
3. Keep wording synchronized between primitive source table and rendered datatypes narrative where applicable.
4. Preserve existing style and avoid unrelated textual normalization.

## Execution Steps
1. Open fhir-fork/source/datatypes/primitives.xml at id row (~304) and identify current prose.
2. Update id prose to explicitly state all whitespace is prohibited (e.g., spaces, tabs, carriage returns, line feeds, non-breaking spaces) while preserving existing length/character constraints.
3. Confirm id regex at ~309 remains `[A-Za-z0-9\-\.]{1,64}` unless a mismatch with intended semantics is discovered.
4. Open fhir-fork/source/datatypes.html id row (~204) and apply equivalent clarification text only if it is source-authored text (not generated-only content in this workflow).
5. Verify datatypes page still references `[%regex id%]` at ~210 with no token changes.
6. Review id notes section around ~427 and add a minimal bullet clarification only if needed to prevent ambiguity not resolved by table prose.
7. Run focused diff review scoped to id-related text and confirm no unrelated changes under fhir-fork/source/.

## Validation Checklist
- [ ] FHIR-53636 maps to concrete edit locations for id prose and regex anchor checks
- [ ] Planned edits stay within fhir-fork/source/
- [ ] id wording explicitly indicates all whitespace is prohibited
- [ ] id regex anchor remains consistent with no-whitespace intent
- [ ] `[%regex id%]` token wiring remains unchanged in datatypes.html
- [ ] No unrelated formatting/tooling/build changes are introduced
- [ ] Diff is traceable to ticket intent: clarify all whitespace prohibition for id

## Risks and Assumptions
- Risk: Editing both primitives.xml and datatypes.html manually could introduce wording drift if one location is generated from another in this branch workflow.
- Assumption: id regex source in primitives.xml is authoritative and already enforces no-whitespace behavior.
- Assumption: Ticket intent is clarification only, not a behavioral regex change.
- Open questions: Should the clarification explicitly enumerate whitespace classes, or is "no whitespace characters" sufficient for normative clarity?
