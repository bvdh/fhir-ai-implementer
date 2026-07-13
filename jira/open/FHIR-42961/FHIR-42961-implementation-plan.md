# Implementation Plan: FHIR-42961

## Scope Summary

- Workgroup/source: FHIR Infrastructure / Jira ticket markdown plus `fhir-fork/source/`
- Tickets in scope: FHIR-42961
- Primary fix pattern: verify-and-align deprecation wording for `Bundle.signature`, with minimal source edits only if upstream source does not fully match the approved resolution

## Ticket Matrix

| Ticket | Summary | Status | Target page(s) | Change type | Notes |
| :--- | :--- | :--- | :--- | :--- | :--- |
| FHIR-42961 | Update the cardinarly if the bundler signature to to have an upper bound | Resolved - change required | `bundle/structuredefinition-Bundle.xml`, `signatures.html`, possibly `versions.html` | wording / deprecation alignment | Ticket resolution supersedes the requested cardinality change and instead requires `Bundle.signature` to be deprecated with updated text |

## Shared Implementation Approach

1. Start from the ticket resolution, not the original requested change: do not change `Bundle.signature` cardinality unless the approved resolution text explicitly requires it.
2. Inspect the canonical Bundle element definition first, then inspect nearby explanatory narrative for consistency.
3. If the source already reflects the approved resolution, keep source changes at zero and validate that no additional spec wording remains inconsistent.

## Likely Edit Surface

- [fhir-fork/source/bundle/structuredefinition-Bundle.xml](/home/nly98977/SwArchives/bvdh/fhir-ai-implementer/fhir-fork/source/bundle/structuredefinition-Bundle.xml#L657)
  Current upstream source already shows:
  - deprecated standards-status extension on `Bundle.signature`
  - short text `Digital Signature (deprecated: use Provenance Signatures)`
  - definition text directing readers to Provenance-based signatures
- [fhir-fork/source/signatures.html](/home/nly98977/SwArchives/bvdh/fhir-ai-implementer/fhir-fork/source/signatures.html#L464)
  Narrative currently states that `Bundle.signature` has identified issues and is deprecated, and points readers to the Provenance-based signing approach.
- [fhir-fork/source/versions.html](/home/nly98977/SwArchives/bvdh/fhir-ai-implementer/fhir-fork/source/versions.html#L690)
  Historical extension URL reference for `Bundle.signature`; inspect only if wording or deprecation cross-links need consistency review.

## Execution Steps

1. Re-read the approved resolution in [jira/active/FHIR-42961/FHIR-42961.md](/home/nly98977/SwArchives/bvdh/fhir-ai-implementer/jira/active/FHIR-42961/FHIR-42961.md#L1) and treat it as authoritative over the original enhancement request.
2. Compare the resolution text against [fhir-fork/source/bundle/structuredefinition-Bundle.xml](/home/nly98977/SwArchives/bvdh/fhir-ai-implementer/fhir-fork/source/bundle/structuredefinition-Bundle.xml#L657) to verify that all of the following are true:
   - `Bundle.signature` is flagged as deprecated
   - the short text communicates deprecation clearly
   - the definition text redirects implementers to Provenance-based signatures
   - cardinality remains unchanged unless an additional approved instruction requires otherwise
3. Compare the same resolution against [fhir-fork/source/signatures.html](/home/nly98977/SwArchives/bvdh/fhir-ai-implementer/fhir-fork/source/signatures.html#L464) and update narrative wording only if it is materially less explicit than the element definition.
4. Inspect [fhir-fork/source/versions.html](/home/nly98977/SwArchives/bvdh/fhir-ai-implementer/fhir-fork/source/versions.html#L690) for any stale wording or references that would contradict the deprecated status; edit only if the page now misstates the current behavior.
5. If all three surfaces already align with the approved resolution, record that the ticket is effectively already satisfied upstream and avoid speculative wording churn.
6. If any edit is needed, keep it limited to `fhir-fork/source/` and avoid generated artifacts or unrelated cleanup.

## Validation Checklist

- [ ] Ticket resolution, not the original request text, is used as the implementation target
- [ ] `Bundle.signature` deprecation is confirmed in [fhir-fork/source/bundle/structuredefinition-Bundle.xml](/home/nly98977/SwArchives/bvdh/fhir-ai-implementer/fhir-fork/source/bundle/structuredefinition-Bundle.xml#L657)
- [ ] Narrative in [fhir-fork/source/signatures.html](/home/nly98977/SwArchives/bvdh/fhir-ai-implementer/fhir-fork/source/signatures.html#L464) is consistent with the element definition
- [ ] No planned edits escape `fhir-fork/source/`
- [ ] No cardinality change is introduced unless explicitly re-authorized by approved ticket disposition
- [ ] If no source delta is needed, validation still records why the ticket is considered already implemented upstream

## Risks and Assumptions

- Risk: the ticket status indicates change required, but upstream master already appears to contain the requested deprecation text; execution may need to conclude with a no-op plus evidence rather than a source edit.
- Risk: related generated/derived artifacts in `source/bundle/` may reflect the same wording, but the workflow should avoid editing generated outputs unless the canonical source edit requires regeneration in a later implementation step.
- Assumption: [fhir-fork/source/bundle/structuredefinition-Bundle.xml](/home/nly98977/SwArchives/bvdh/fhir-ai-implementer/fhir-fork/source/bundle/structuredefinition-Bundle.xml#L657) is the canonical source for the Bundle element definition.
- Open question: if the source is already correct, should the implementation step close the ticket as already applied upstream, or should a minimal clarifying wording adjustment still be made to align the repository workflow with the ticket state?
