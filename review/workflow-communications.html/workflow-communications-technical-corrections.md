# Technical Corrections Review Report

## Metadata
- Review ID: workflow-communications-2026-08-17
- Date: 2026-08-17
- Mode: page
- Target: fhir-repo/publish/workflow-communications.html
- Status: COMPLETE

## Build Evidence
- Build check command: `./.github/skills/build-fhir/scripts/build-if-needed.sh --repo ./fhir-repo --mode check`
- Build check result: BUILD_NEEDED: no
- Build status used for review: current
- Additional evidence: existing publish artifact is newer than every file under fhir-repo/source at review time.

## Inputs Used
- Source files:
  - fhir-repo/source/workflow-communications.html
- Output files:
  - fhir-repo/publish/workflow-communications.html

## W3C Findings
### Section 7.2
- No clear section 7.2 deviation was established by the local prose scan. Headings observed: Workflow Execution and Communication Patterns, Communication Patterns Conventions, Communication Pattern Considerations, Workflow State, Example: Workflow states for a lab order for a blood test, Example: Workflow states for a referral from a PCP to a specialist, List of patterns.
### Section 7.3
- No clear section 7.3 deviation was established by the local prose scan.
### Section 11
- No clear section 11 deviation was established. Spelling and wording checks are recorded separately below.
### Section 13
- No clear section 13 deviation was established by the local rendered/source comparison.

## Link Target Validation Findings
- Link ID: LNK-001; source: fhir-repo/source/workflow-communications.html; href: `task-operation-start.html`; target type: internal-file; validation status: missing; evidence: `task-operation-start.html` does not resolve under fhir-repo/publish.
- Link ID: LNK-002; source: fhir-repo/source/workflow-communications.html; href: `task-operation-set.html-output`; target type: internal-file; validation status: missing; evidence: `task-operation-set.html-output` does not resolve under fhir-repo/publish.
- Link ID: LNK-003; source: fhir-repo/source/workflow-communications.html; href: `task-operation-finish.html`; target type: internal-file; validation status: missing; evidence: `task-operation-finish.html` does not resolve under fhir-repo/publish.
- Link ID: LNK-004; source: fhir-repo/source/workflow-communications.html; href: `task-operation-start.html`; target type: internal-file; validation status: missing; evidence: `task-operation-start.html` does not resolve under fhir-repo/publish.
- Link ID: LNK-005; source: fhir-repo/source/workflow-communications.html; href: `task-operation-suspend.html`; target type: internal-file; validation status: missing; evidence: `task-operation-suspend.html` does not resolve under fhir-repo/publish.
- Link ID: LNK-006; source: fhir-repo/source/workflow-communications.html; href: `task-operation-resume.html`; target type: internal-file; validation status: missing; evidence: `task-operation-resume.html` does not resolve under fhir-repo/publish.
- Link ID: LNK-007; source: fhir-repo/source/workflow-communications.html; href: `task-operation-fail.html`; target type: internal-file; validation status: missing; evidence: `task-operation-fail.html` does not resolve under fhir-repo/publish.
- Link ID: LNK-008; source: fhir-repo/source/workflow-communications.html; href: `task-operation-start.html`; target type: internal-file; validation status: missing; evidence: `task-operation-start.html` does not resolve under fhir-repo/publish.
- Link ID: LNK-009; source: fhir-repo/source/workflow-communications.html; href: `task-operation-set.html-output`; target type: internal-file; validation status: missing; evidence: `task-operation-set.html-output` does not resolve under fhir-repo/publish.
- Link ID: LNK-010; source: fhir-repo/source/workflow-communications.html; href: `task-operation-finish.html`; target type: internal-file; validation status: missing; evidence: `task-operation-finish.html` does not resolve under fhir-repo/publish.

## Link Description Correspondence Findings
- Link labels were compared with their local target filenames/headings where targets resolved. No high-confidence label/target mismatch was established. Missing targets are recorded above as target-validation findings.

## Spelling Findings
- No unambiguous spelling error was established by the automated vocabulary pass; generated navigation labels and code identifiers were excluded from correction claims.

## Non-W3C Technical Corrections
- TECH-001 (warning): ten operation links reference missing local targets, including `task-operation-start.html`, `task-operation-set.html-output`, and `task-operation-finish.html`. Confirm the operation-page filenames or update the links.

## Patch-Ready Change Set
### CHG-001
- Target file: fhir-repo/source/workflow-communications.html
- Anchor: task operation communication links
- Edit type: replace
- Current text (exact): the hrefs listed under LNK-001 through LNK-010
- Proposed text (exact): existing operation-page hrefs in fhir-repo/publish, or remove obsolete links
- Pre-context (exact): task operation communication paragraph/list
- Post-context (exact): next communication pattern
- Occurrence rule: each missing target
- Rationale: Published links must resolve to local operation pages.
- Validation check: verify every local href against fhir-repo/publish after build.


## Apply Sequence
- Apply any confirmed page-specific link correction, then rebuild and rerun link validation.

## Blocking Issues
- None. Review completed against current local build artifacts.
