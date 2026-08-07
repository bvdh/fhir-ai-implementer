---
name: validate-fhir-repo-source-boundary
description: 'Validate that all pending fhir-repo changes are under fhir-repo/source only. Use before commit to enforce fork edit boundaries.'
argument-hint: '[--staged] optional flag to check staged changes only'
---

# Validate FHIR Fork Source Boundary

Check whether changed files in `fhir-repo/` are restricted to `source/`.

## When to Use
- Before committing ticket implementation changes
- After editing to verify no accidental updates outside specification source
- During review to enforce fhir-repo boundary rules

## Run
From repository root:

```bash
bash ./.github/skills/validate-fhir-repo-source-boundary/scripts/check-changed-paths.sh
```

Staged-only check:

```bash
bash ./.github/skills/validate-fhir-repo-source-boundary/scripts/check-changed-paths.sh --staged
```

## Output
- PASS when all changed paths are under `fhir-repo/source/`
- FAIL with a list of violating paths when any changes exist outside `source/`

## Notes
- This skill validates paths only; it does not modify files.
- Use with your normal commit flow and ticket-specific validation.
