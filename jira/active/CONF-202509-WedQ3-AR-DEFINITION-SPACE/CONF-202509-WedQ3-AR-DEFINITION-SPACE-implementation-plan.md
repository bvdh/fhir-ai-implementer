# Implementation Plan: CONF-202509-WedQ3-AR-DEFINITION-SPACE

## Scope Summary
- Workgroup/source: FHIR Infrastructure WGM 202509 WedQ3 Confluence minutes
- Tickets in scope: CONF-202509-WedQ3-AR-DEFINITION-SPACE
- Primary fix pattern: Core specification wording/policy update for additional-resource definition-space constraint

## Ticket Matrix
| Ticket | Summary | Status | Target page(s) | Change type | Notes |
|---|---|---|---|---|---|
| CONF-202509-WedQ3-AR-DEFINITION-SPACE | Change additional resource definition space to http://hl7.org/fhir | Resolved - change required | resource.html, references.html | Wording/policy rule update | Source edits expected in `fhir-fork/source/resource/resource-introduction.xml` and consistency check/update in `fhir-fork/source/references.html` |

## Likely Edit Surface (Files and Line Anchors)
- `fhir-fork/source/resource/resource-introduction.xml:49`
  - Section header: "Additional Resources Defined Outside This Specification"
- `fhir-fork/source/resource/resource-introduction.xml:57`
  - Rule list where additional-resource constraints are enumerated (primary insertion/update point)
- `fhir-fork/source/references.html:305`
  - "Additional References" context for allowed reference behavior
- `fhir-fork/source/references.html:323`
  - Existing language for normal references to additional resources via extension (consistency alignment point)

## Shared Implementation Approach
1. Locate and update the normative rule text in `fhir-fork/source/resource/resource-introduction.xml` to require definition space `http://hl7.org/fhir` for approved additional resources (per approved motion intent).
2. Ensure `fhir-fork/source/references.html` remains consistent with the updated rule and does not contradict the definition-space constraint.
3. Keep edits minimal, localized, and traceable to ticket intent.

## Execution Steps
1. Update additional-resource rule bullets in `fhir-fork/source/resource/resource-introduction.xml` around the list starting near line 57:
   - Add/adjust text so approved additional resources are required to use `http://hl7.org/fhir` as the definition space.
   - Preserve surrounding registration and approval requirements.
2. Review `fhir-fork/source/references.html` around lines 305-325 and update wording only if needed for consistency with the updated definition-space requirement.
3. Run a focused diff review restricted to `fhir-fork/source/` to confirm no unrelated formatting/content churn.
4. Run build validation (`./_genonce.sh` in `fhir-extensions-fork`) and inspect QA output for regressions related to references/additional-resource sections.
5. Record final validation notes in the ticket folder after implementation.

## Validation Checklist
- [ ] Ticket is mapped to concrete source files under `fhir-fork/source/`
- [ ] Planned edits stay within `fhir-fork/source/`
- [ ] `resource-introduction.xml` contains explicit required definition-space wording (`http://hl7.org/fhir`)
- [ ] `references.html` is consistent with the updated additional-resource policy
- [ ] No unrelated formatting/tooling changes are included
- [ ] `_genonce.sh` completes without introducing new errors tied to this change area
- [ ] Plan-to-implementation traceability is preserved in commit notes

## Risks and Assumptions
- Risk: "definition space" wording may be interpreted differently (canonical URL base vs strict namespace policy), creating downstream interpretation variance.
- Risk: Existing examples or external references might implicitly assume non-`http://hl7.org/fhir` definition spaces and could require follow-up cleanup.
- Assumption: The approved motion text is authoritative for this ticket and supersedes previous wording.
- Assumption: `fhir-fork/source/resource/resource-introduction.xml` is the canonical source for generated `resource.html` policy language.
- Open question: Whether the updated requirement should also be mirrored in additional pages beyond `references.html` (for example, `json.html`/`xml.html` additional-resource explanatory text) in this same ticket or as follow-up.
