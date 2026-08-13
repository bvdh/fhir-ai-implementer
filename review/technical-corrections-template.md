# Technical Corrections Review Template

## Metadata
- Review ID: <auto-or-manual-id>
- Date: <YYYY-MM-DD>
- Mode: <page|full-spec>
- Target: <page path or full-spec scope>
- Ticket: <optional>

## Build Evidence
- Build check command: `./.github/skills/build-fhir/scripts/build-if-needed.sh --repo ./fhir-repo --mode check`
- Build check result: <BUILD_NEEDED: no|yes>
- Build status used for review: <current|rebuilt|blocked>
- Additional evidence: <command output summary>

## Inputs Used
- Source files:
  - <fhir-repo/source/...>
- Output files:
  - <fhir-repo/output/...>

## W3C Findings
### Section 7.2
- <finding or None>

### Section 7.3
- <finding or None>

### Section 11
- <finding or None>

### Section 13
- <finding or None>

## Link Target Validation Findings
- <finding or None>

For each link-target finding, include:
- Link ID: <LNK-001, LNK-002, ...>
- Source location: <file path + heading/anchor>
- Link text: <exact text>
- Href: <exact href>
- Target type: <internal-anchor|internal-file|external-http>
- Validation status: <exists|missing|unreachable|indeterminate>
- Evidence: <how status was determined>

## Link Description Correspondence Findings
- <finding or None>

For each correspondence finding, include:
- Link ID: <LNK-xxx>
- Source location: <file path + heading/anchor>
- Link text: <exact text>
- Target descriptor: <target heading/title/metadata>
- Correspondence result: <aligned|mismatch|ambiguous>
- Confidence: <high|medium|low>
- Rationale: <why it aligns or mismatches>

## Spelling Findings
- <finding or No spelling issues found>

## Non-W3C Technical Corrections
- <finding or None>

## Patch-Ready Change Set
### CHG-001
- Target file: <path>
- Anchor: <heading/section>
- Edit type: <replace|insert-before|insert-after|delete>
- Current text (exact): <text>
- Proposed text (exact): <text>
- Pre-context (exact): <5-20 words>
- Post-context (exact): <5-20 words>
- Occurrence rule: <unique|first under heading|nth>
- Rationale: <why>
- Validation check: <how to verify>

## Apply Sequence
1. <CHG-xxx>
2. <CHG-xxx>

## Blocking Issues
- <None|details>
