# Proposed Resolution for FHIR-50586

## Ticket Summary

| Field | Value |
|---|---|
| Key | FHIR-50586 |
| Issue Type | Technical Correction |
| Status | Resolved - change required |
| Resolution | Persuasive |
| Reporter | James Jahns |
| Assignee | Unassigned |
| Created | 2025-05-01 |
| Updated | 2026-04-13 |
| Related Page(s) | Datatypes |
| Related Section(s) | 2.1.28.0.12, 2.1.28.0.18 |
| Jira | https://jira.hl7.org/browse/FHIR-50586 |

## Description

On the main Datatypes page, some datatypes do not show the constraints box even though constraints exist.

- SampledData: `sdd-1` did not appear
- RelativeTime: `rlt-1` and `rlt-2` did not appear

Ticket notes indicate partial correction:

- Resolution Description: "This is fixed for SampledData but is still broken for RelativeTime"

## Implementation Status

Pending (partially addressed).

- Disposition from Jira indicates acceptance (`Resolution: Persuasive`) and implementation required.
- Current ticket state is still `Resolved - change required` (not `Applied`).
- Based on source inspection, `SampledData` constraints rendering appears wired on the main datatype page, while `RelativeTime` still lacks equivalent constraints box rendering.

### Implementation Details (current evidence)

- Main datatype page source includes constraints insertion for SampledData:
  - `fhir-fork/source/datatypes.html` contains `[%dt.constraints SampledData%]` (around line 1366).
- RelativeTime section on main datatype page does not include a matching constraints insertion block in the visible section body:
  - `fhir-fork/source/datatypes.html` section around `#RelativeTime` (lines ~1771-1804).
- RelativeTime constraints are present in datatype definition source, indicating the data exists but is not fully surfaced on the main page:
  - `fhir-fork/source/datatypes/relativetime.xml` includes constraint statements for the datatype (around lines ~3722 and ~3731 in spreadsheet XML content).

## Related Tickets

- No explicit parent key/grouping captured in the local ticket markdown.
- Historical regression context noted in ticket description: FHIR-8889.

## Disposition Analysis

### Disposition Taken

Pending completion (partial fix already landed).

### Rationale

The workgroup accepted the correction. Existing evidence suggests only part of the requested behavior is present on the Datatypes summary page. To honor the accepted correction, RelativeTime constraint visibility needs to be made consistent with SampledData.

### Evidence

- Status markers:
  - `Status: Resolved - change required`
  - `Resolution: Persuasive`
  - Resolution Description explicitly states partial completion (SampledData fixed, RelativeTime still broken).
- Source anchors:
  - `fhir-fork/source/datatypes.html` (`[%dt.constraints SampledData%]` present).
  - `fhir-fork/source/datatypes.html` RelativeTime section lacks corresponding constraints block.
  - `fhir-fork/source/datatypes/relativetime.xml` contains RelativeTime constraints text.

## Proposed Dispositions

### Disposition A: Accept As Requested

#### Proposal

Complete the accepted correction by updating Datatypes main-page generation so `RelativeTime` shows its constraints box (`rlt-1`, `rlt-2`) in the same way `SampledData` now shows `sdd-1`. Ensure both summary and detailed views are consistent for constraint visibility.

#### Justification

This directly fulfills the original request, matches the accepted Jira disposition, and preserves consistency across datatype sections. It is low-risk and editorial/rendering-scoped rather than semantic model change.

---

### Disposition B: Alternative Approach

#### Proposal

Instead of adding/repairing RelativeTime constraints rendering on the main Datatypes page, add an explicit, prominent "constraints in detailed descriptions" callout in the RelativeTime section that links to the detailed definitions page for `rlt-1` and `rlt-2`.

#### Justification

This reduces template/generation complexity and still improves discoverability. However, it leaves an inconsistent UX between datatypes and does not fully meet the intent that constraints appear in the main datatype section.

---

### Disposition C: Decline

#### Proposal

Decline further changes and treat the current partial state as sufficient.

#### Justification

This is weakly defensible because the ticket was accepted and explicitly records remaining breakage for RelativeTime. Declining would contradict accepted workgroup direction and leave known inconsistency unresolved.

---

### Recommendation

**Recommended disposition:** A

**Selected disposition for execution planning:** A

The correction is already approved and partially implemented. Finishing RelativeTime constraints rendering is the most direct, lowest-risk path that restores consistency and aligns with workgroup intent. It also avoids future confusion where constraints exist in source/detailed pages but are missing from the main Datatypes page.

## Next Steps

Ready for Review

### Verification Checklist

- [ ] Work group review completed
- [ ] Implementation code committed
- [ ] Verification in main branch
- [ ] Documentation updated
