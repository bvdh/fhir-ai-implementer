# Skill: review-tc-applies

**Purpose**: Apply patch-ready technical corrections from workgroup technical-corrections review files to FHIR source files.

**Triggers**: "apply technical corrections", "apply tc from", "apply review findings", "execute tc patches", "implement tc changes"

**Invokes**: File system tools (read/write), string replacement, build validation tools

**Scope**: FHIR source files under `fhir-repo/source/` only

---

## Overview

This skill automates the application of technical corrections identified in `*-technical-corrections.md` review reports. Each report may contain multiple patch-ready edits with complete context (file location, current text, proposed text, pre/post context, and validation requirements).

### Input

- **Single file path**: `review/<page>.html/<page>-technical-corrections.md`
- **Workgroup batch**: Apply all corrections from a specific workgroup folder or list of workgroup-assigned files
- **Selection mode**: Interactive selection from a workgroup (e.g., "PHX", "VOCAB", "FHIR")
- **Execution mode flag**: `--batch` (default) or `--interactive` to control confirmation prompts

### Output

- **Per-file report**: Summary of successful edits, skipped edits, validation results
- **Batch report**: Aggregated results across all processed technical-corrections files (success count, failure count, error summary)
- **Source changes**: Modified FHIR source files under `fhir-repo/source/`
- **Git integration**: Branch creation (if needed) and commit with generated messages
- **Validation artifacts**: Build check output showing current/rebuild status

---

## Workflow

### Phase 1: Parse and Inventory

1. **Accept input**
   - User provides one of:
     - Full path to a technical-corrections.md file
     - Workgroup short code (e.g., "PHX", "VOCAB", "FHIR")
     - Batch marker (e.g., "all unmapped", "all OO workgroup")
   - Optional flags: `--batch` (default), `--interactive`, `--no-git`, `--no-validate`

2. **Resolve file list**
   - If single file: load and parse
   - If workgroup code: resolve using `technical-corrections-workgroup-mapping.md`
   - If batch: expand to full file list
   - Sort files alphabetically for consistent processing

3. **Extract patches from each file**
   - Parse metadata section (date, review ID, target, status)
   - Scan for all "Patch-Ready" sections (may contain multiple patches per file)
   - For each patch, extract:
     - **Change ID** (unique within file, e.g., "LNK-001", "SP-002")
     - **Target file** (relative path under `fhir-repo/`, e.g., `source/bindings-list.html`)
     - **Anchor** (location descriptor, e.g., "line number", "element name", "table row")
     - **Edit type** (`replace`, `insert`, `delete`)
     - **Current text** (exact string to match)
     - **Proposed text** (replacement string)
     - **Pre-context** (3–5 lines before current text, for disambiguation)
     - **Post-context** (3–5 lines after current text)
     - **Validation** (description of validation step, if any)

4. **Validate patch metadata**
   - Confirm all required fields present
   - Verify target file exists under `fhir-repo/source/`
   - Check for conflicting patch IDs (same Change ID in different files)
   - Report ambiguities and defer to user confirmation
   - Count total patches: "N patches found across M files"

### Phase 2: Apply Patches (Batch or Interactive)

#### Batch Mode (Default: `--batch` or no flag)

1. **Display inventory**
   - Summary: "Found N patches across M files"
   - List: Change ID and file name for each patch
   - Prompt: "Apply all patches? (Y/n/review)"

2. **Review option** (if user selects "review")
   - Display full list with:
     - Change ID, file name, anchor, edit type, 1-line summary
   - Confirm: "Proceed? (Y/n)"

3. **Apply patches** (if user confirms)
   - Process files in alphabetical order
   - Within each file, apply patches in documented order (as they appear in file)
   - For each patch:
     - Read source file
     - Construct search context: pre-context + current text + post-context
     - Locate exact match in file
     - If found: apply replacement, log success with line/byte range
     - If not found: log mismatch, skip patch, continue to next
   - Write all changes to file atomically (all-or-nothing within file)

4. **Collect errors**
   - All skipped/failed patches logged without halting
   - Continue processing remaining files and patches
   - Compile error report for display at end

#### Interactive Mode (`--interactive`)

1. **Per-file prompts**
   - For each technical-corrections file: "Apply K patches from FILE? (Y/n/review)"
   - Show: brief patch list (Change ID, anchor, edit type, 1-line summary)

2. **Review option** (if user selects "review")
   - Display full patch details:
     - Change ID, anchor, current text (truncated), proposed text (truncated)
   - Confirm: "Apply patches from this file? (Y/n)"

3. **Apply patches in file** (if user confirms file)
   - Apply all patches in file in order
   - Log each success/failure
   - On context mismatch:
     - Display: "Change ID XXX: context not found in file at expected location"
     - Show: snippet of current text and expected context
     - Prompt: "Skip this patch? (Y/n/edit)"
     - If "edit": offer manual context entry or defer

4. **Per-workgroup summary**
   - After each file or logical batch: show "File summary: X/Y patches applied"
   - Allow user to halt, continue, or retry failed patches

### Phase 2b: Error Handling

**Strategy: Collect all errors, skip failed patches, continue processing**

- **Context mismatch** (pre/post context + current text not found):
  - Log: "Change ID XXX: context mismatch in FILE at expected line YY"
  - Show: snippet of file around expected location and expected context
  - Action: Skip patch, continue to next
  - Suggestion: "Run with `--interactive` for per-patch confirmation or manual context override"
  
- **Conflicting edits** (patches target overlapping regions within same file):
  - Apply in documented order (file source order)
  - After each patch, recalculate context for subsequent patches in file
  - Log: "Patch YY: line numbers adjusted after Patch XX (offset: +N lines)"

- **File not found** (target source file does not exist):
  - Log: "Target file not found: fhir-repo/source/PATH"
  - Skip all patches in technical-corrections file
  - Report: "1 file not found, skipped K patches"

- **Validation failure** (post-apply check fails, if validation is requested):
  - Log: "Change ID XXX applied but validation failed: [reason]"
  - Allow: user to accept changes or rollback patch

### Phase 2c: Git Integration

**Automatic branch management (enabled by default, `--no-git` to skip):**

1. **Check git state**
   - If on `main` and working directory clean:
     - Prompt: "Create working branch? (Y/n)"
       - If yes: create branch named `r6-sept-2026-ballot-tc-<wg>` (e.g., `r6-sept-2026-ballot-tc-phx`)
   - If already on feature branch: proceed without branching
   - If working directory dirty: prompt to commit or stash first

2. **Prepare commit** (after patches applied successfully)
   - Generate commit message template:
     ```
     Apply technical corrections from <WORKGROUP> workgroup
     
     Patches applied:
     - Change-001: [1-line summary] (file)
     - Change-002: [1-line summary] (file)
     ...
     
     Source files:
     - fhir-repo/source/file1.html
     - fhir-repo/source/file2.html
     
     Validation: Build check shows BUILD_NEEDED=[true|false]
     Review ID(s): [comma-separated IDs from technical-corrections files]
     ```

3. **Write a separate commit-message file for each technical-corrections report**
    - For every processed `*-technical-corrections.md` file with patch-ready changes, create or refresh the sibling file `*-technical-corection-commit-message.md` in the same review directory.
    - Example: `review/async.html/async-technical-corrections.md` produces `review/async.html/async-technical-corection-commit-message.md`.
    - Do not add or modify a commit-message section in the source `*-technical-corrections.md` report.
    - Use only the report's `Patch-Ready Change Set` as the content source; do not summarize unrelated files or patches from another report.
    - Mirror every patch-ready change in the same documented order using this format:
       ```markdown
       Fix <page> technical corrections

       - <Change ID>: <proposed change summary>
          - File: `<Target file>`
          - Change: `<Current text>` -> `<Proposed text>`
          - Reason: <Rationale>
       - <Change ID>: <proposed change summary>
          - File: `<Target file>`
          - Change: `<Current text>` -> `<Proposed text>`
          - Reason: <Rationale>
       ```
    - If no patch was applied because of a context mismatch, mark that change as `Skipped` and retain its reason.
    - If the report has no patch-ready changes, do not create a commit-message file.
    - If the separate commit-message file already exists, replace its generated content so rerunning the skill does not duplicate content.

4. **Stage and commit** (if user approves)
   - Prompt: "Commit now? (Y/n/edit)"
   - If "edit": allow user to modify commit message
   - If yes: stage all modified source files and create commit

### Phase 3: Validate and Report

1. **Build validation** (enabled by default, `--no-validate` to skip; always quick check only)
   - Run: `./.github/skills/build-fhir/scripts/build-if-needed.sh --repo ./fhir-repo --mode check`
   - Capture result: `BUILD_NEEDED: [true|false]`
   - If BUILD_NEEDED: true, log "Rebuild recommended; run `build-fhir` skill to validate full output"
   - If BUILD_NEEDED: false, log "Build state current; no rebuild needed"

2. **Per-patch validation** (if technical-corrections file specifies validation)
   - Execute validation described in file (e.g., link checks, spelling scans)
   - Mark status per Change ID: passed/failed/deferred
   - Log results per patch

3. **Final report**
   - **Summary**: "Applied X/Y patches (Z skipped/failed)"
   - **Modified files**: List paths under `fhir-repo/source/`
   - **Report commit messages**: List each created or refreshed `*-technical-corection-commit-message.md` file
   - **Error details**: List skipped patches with reasons (context mismatch, file not found, etc.)
   - **Git status**: Branch name, commit hash (if committed)
   - **Validation**: Build check result, per-patch validation summary
   - **Next steps**: 
     - "Build validation recommended" (if BUILD_NEEDED: true)
     - "Commit prepared, ready to push" (if committed)
     - "Ready for PR submission" (if batch completed and build valid)

---

## Key Constraints

- **Source-only edits**: All patches must target files under `fhir-repo/source/`. Generated output files (`fhir-repo/publish/`) are read-only.
- **Exact context matching**: Patches require precise pre/post context to avoid unintended replacements in similar regions.
- **No cross-file dependencies**: Each patch is independent; ordering is left-to-right within a file, and files are processed in alphabetical order by default.
- **Confirmation required**: Batch mode requires one approval before applying any patches; interactive mode prompts per file or per patch.
- **Error collection**: Failed patches (context mismatch, file not found) do not halt the process. All errors are collected and reported together.
- **Build validation optional**: Default is quick check only (`build-if-needed`). User must explicitly request full build if needed.

---

## Execution Example: Batch Mode (Default)

```
User:
  "Apply technical corrections from the VOCAB workgroup"

Skill:
  1. Resolve VOCAB files: 8 files found
     - review/identifier-registry.html/identifier-registry-technical-corrections.md (1 patch)
     - review/terminologies.html/terminologies-technical-corrections.md (2 patches)
     - (6 more files)
  
  2. Display inventory:
     Found 3 patches across 2 files:
     - LNK-001: identifier-registry.html [link description]
     - SP-002: terminologies.html [spelling]
     - LNK-003: terminologies.html [link]
     
     Apply all patches? (Y/n/review) > y
  
  3. Check git:
     On main, working directory clean.
     Create working branch? (Y/n) > y
   Branch created: r6-sept-2026-ballot-tc-vocab
  
  4. Apply patches:
     - LNK-001: identifier-registry.html - ✓ applied at line 145
     - SP-002: terminologies.html - ✓ applied at line 289
     - LNK-003: terminologies.html - ✓ applied at line 312
  
  5. Build validation:
     BUILD_NEEDED: false (current)
  
  6. Commit:
     Generated commit message with 3 Change IDs.
     Commit now? (Y/n) > y
   ✓ Committed: r6-sept-2026-ballot-tc-vocab [hash]
  
  7. Final Report:
     Summary: 3/3 patches applied
     Modified files:
       - fhir-repo/source/identifier-registry.html
       - fhir-repo/source/terminologies.html
     Build status: Current (no rebuild needed)
   Branch: r6-sept-2026-ballot-tc-vocab
     Commit: [hash] "Apply technical corrections from VOCAB workgroup..."
     Next steps: Push and create PR referencing VOCAB tickets
```

## Execution Example: Interactive Mode

```
User:
  "Apply technical corrections --interactive"

Skill:
  1. File 1/2: review/identifier-registry.html/identifier-registry-technical-corrections.md
     Found 1 patch. Apply? (Y/n/review)
     > review
     
     LNK-001: Link description mismatch
       Current text: "Dose Limit Scope ValueSet"
       Proposed: "Comparison Operation ValueSet"
       File: identifier-registry.html, line 145
       Context: [5-line pre/post snippet]
     
     Apply this patch? (Y/n) > y
     ✓ Applied at line 145
  
  2. File 2/2: review/terminologies.html/terminologies-technical-corrections.md
     Found 2 patches. Apply? (Y/n/review)
     > y
     
     SP-002: spelling fix - ✓ applied at line 289
     LNK-003: link - ✓ applied at line 312
  
  3. Final report:
     Applied 3/3 patches
     Files modified: identifier-registry.html, terminologies.html
     Commit prepared. Push? (Y/n) > y
   ✓ Pushed to r6-sept-2026-ballot-tc-vocab
```

---

## Related Skills

- **review-technical-corrections**: Generate `*-technical-corrections.md` reports from FHIR pages
- **build-fhir**: Build and validate the FHIR specification
- **commit-in-repos**: Commit changes across fhir-repo and related forks

## Related Instructions

- **fhir-repo.instructions.md**: Enforce source-edit-only boundaries for fhir-repo changes
- **AGENTS.md**: Workgroup assignment conventions and repository rules

## Related Reference Data

- **technical-corrections-workgroup-mapping.md**: Master mapping of all 194 technical-corrections files to FHIR workgroups (use for workgroup code resolution)

---

## Configuration Notes

- Source directory: `fhir-repo/source/`
- Build validation script: `./.github/skills/build-fhir/scripts/build-if-needed.sh`
- Workgroup mapping file: `technical-corrections-workgroup-mapping.md` (15 workgroups, 194 files)
- Workgroup codes: PHX, FHIR, VOCAB, OO, PA, PC, CQI, CDS, ITS, RM, BRCA, BRR, DevComm, Structured Data, Security
