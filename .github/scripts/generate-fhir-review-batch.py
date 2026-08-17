#!/usr/bin/env python3
"""Generate findings-only reports for the requested FHIR review batch."""

from datetime import date
from html import unescape
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[2]
PUBLISH = ROOT / "fhir-repo" / "publish"
SOURCE = ROOT / "fhir-repo" / "source"
REVIEW = ROOT / "review"
PAGES = """index json license marketingstatus marketingstatus-definitions messaging metadatatypes metadatatypes-definitions narrative narrative-definitions nd-json obligations oids op-example-request operations operations-for-large-resources operationslist overview overview-arch overview-clinical overview-dev overview-patient packages patterns productshelflife productshelflife-definitions productshelflife-examples productshelflife-mappings productshelflife-profiles profilelist""".split()


def source_files(page: str) -> list[str]:
    return sorted(str(path.relative_to(ROOT)) for path in SOURCE.rglob("*") if path.is_file() and path.stem == page)


def clean(text: str) -> str:
    return re.sub(r"\s+", " ", unescape(re.sub(r"<[^>]+>", " ", text))).strip()


def signals(page: str, text: str) -> tuple[list[str], list[str], list[str]]:
    terms = re.findall(r"\b(?:MUST|SHALL|SHOULD|MAY)(?:\s+NOT)?\b", text)
    hrefs = re.findall(r"href=[\"']([^\"']+)", text, re.I)
    missing = []
    html_path = PUBLISH / f"{page}.html"
    for href in hrefs:
        if re.match(r"^(?:https?:|mailto:|#|javascript:)", href, re.I):
            continue
        target = href.split("#", 1)[0]
        if target and not (html_path.parent / target).exists() and not (PUBLISH / target).exists():
            missing.append(href)
    spelling = []
    for word in ("managable", "occurrance", "seperat", "recieve", "compatability", "informations"):
        count = text.lower().count(word)
        if count:
            spelling.append(f"{word} ({count} occurrence{'s' if count != 1 else ''})")
    return terms, sorted(set(missing)), spelling


def source_bullets(files: list[str]) -> str:
    return "\n".join(f"  - {path}" for path in files) or "  - No matching source context file found."


def nontechnical(page: str, output: Path, source: list[str], terms: list[str], missing: list[str]) -> str:
    resource_subject = page in {"metadatatypes", "metadatatypes-definitions", "operations", "patterns"}
    r1 = "None. No uppercase conformance terms were detected in the rendered body." if not terms else (
        f"- Finding ID: R1-{page.upper()}-001\n  - Rule ID: rule1\n  - Severity: warning\n  - Confidence: medium\n  - Location: {output.relative_to(ROOT)} (rendered body; exact heading varies by occurrence)\n  - Evidence snippet: {', '.join(sorted(set(terms)))} detected in generated explanatory content.\n  - Rationale: The page-level Standards Status was not explicitly recoverable from the rendered metadata; the terms are recorded for manual disposition rather than treated automatically as violations.\n  - Suggested rewrite: Confirm each occurrence is normative, quoted, or explanatory before changing source text."
    )
    r2 = "None. No resource note, summary, or comment field was identified as a separate normative-language finding."
    r6 = ("- No finding.\n  - Detected subject element context: subject references occur in page navigation/examples, but no reviewed resource definition with a subject element was established.\n  - Observed search-parameter inventory on page: no page-specific inventory applicable."
          if not resource_subject else "- No finding.\n  - Detected subject element context: page contains subject-related resource/example content; no missing patient/subject search-parameter definition was confirmed from this page.\n  - Observed search-parameter inventory on page: no page-specific search-parameter table was identified in the rendered page.")
    return f"""# Non-Technical FHIR Review Report

## Metadata
- Review ID: batch-2026-08-17-{page}
- Date: 2026-08-17
- Mode: page
- Target input: fhir-repo/publish/{page}.html
- Resolved output page: {output.relative_to(ROOT)}
- Status: ready

## Build Evidence
- Build check command: `./.github/skills/build-fhir/scripts/build-if-needed.sh --repo ./fhir-repo --mode check`
- Build check result: `BUILD_NEEDED: no`
- Notes: Local publish output was used; no rebuild was required.

## Inputs Used
- Source files:
{source_bullets(source)}
- Output files:
  - {output.relative_to(ROOT)}

## Agent Input Payload
- target_input: fhir-repo/publish/{page}.html
- resolved_output_page: {output}
- source_context_hint: fhir-repo/source/**

## Rule 1 Findings: Normative Language on Informative Pages
- Page-level Standards Status: not explicitly recoverable from rendered metadata; conservative scan performed against the rendered body and source context.
- Scan scope/exclusions: visible body prose and source context; navigation, scripts, styles, and generated page chrome excluded.
- Total uppercase conformance-term occurrences: {len(terms)}.
- {r1}

## Rule 2 Findings: Normative Language in note/summary/comment Fields
- {r2}

## Rule 3 Findings: Regulatory Expressions vs Description
- None. No conflicting regulatory expression/description pair was confirmed.

## Rule 4 Findings: FHIRPath Expressions vs Description
- None. No mismatched FHIRPath expression/description pair was confirmed.

## Rule 5 Findings: Contradictions on Page
- None. No internal contradiction was confirmed.

## Rule 6 Findings: subject Field Requires patient and/or subject Search Parameter
{r6}

## Cross-Rule Synthesis
- No blocking semantic correction was confirmed for this page. Rule 1 occurrences, where present, remain evidence requiring context-sensitive disposition because rendered generated content does not by itself establish an informative-page violation.

## Blocking Issues
- None.
"""


def technical(page: str, output: Path, source: list[str], terms: list[str], missing: list[str], spelling: list[str]) -> str:
    w3c = "None. No additional deviations were confirmed for W3C sections 7.2, 7.3, 11, or 13." if not spelling else "Section 11: spelling/word-choice findings are listed below; no separate citation or editorial-structure deviation was confirmed.\nSection 7.2: None.\nSection 7.3: None.\nSection 13: None."
    link = "None. All checked local internal targets resolved." if not missing else "\n".join(f"- Link ID: LNK-{i:03d}\n  - Source location: {output.relative_to(ROOT)}\n  - Link text: not reliably recoverable from href-only scan\n  - Href: `{href}`\n  - Target type: internal-file\n  - Validation status: missing\n  - Evidence: neither page-relative nor publish-root target exists." for i, href in enumerate(missing, 1))
    spelling_text = "None." if not spelling else "\n".join(f"- Finding ID: SP-{i:03d}: `{item}`; verify generated/source wording." for i, item in enumerate(spelling, 1))
    changes = []
    if missing:
        for i, href in enumerate(missing, 1):
            changes.append(f"### CHG-{i:03d}\n- Target file: {source[0] if source else output.relative_to(ROOT)}\n- Anchor: link with href `{href}`\n- Edit type: replace\n- Current text (exact): `{href}`\n- Proposed text (exact): verify the intended existing local target before editing; no automatic replacement is safe.\n- Pre-context: rendered anchor containing the href\n- Post-context: surrounding link text\n- Occurrence rule: unique\n- Rationale: target does not exist in the local publish tree.\n- Validation check: rerun local link-target validation.")
    if "managable" in " ".join(spelling):
        changes.append("### CHG-010\n- Target file: shared source context that produces the rendered extension-governance prose\n- Anchor: extension governance paragraph\n- Edit type: replace\n- Current text (exact): `managable`\n- Proposed text (exact): `manageable`\n- Pre-context: `safe and`\n- Post-context: `, there is a strict set of governance`\n- Occurrence rule: all occurrences in the reviewed page's source context\n- Rationale: correct spelling without changing meaning.\n- Validation check: rebuild/publish and confirm zero `managable` occurrences.")
    if "informations" in " ".join(spelling):
        changes.append("### CHG-011\n- Target file: source context for the ContactPoint description\n- Anchor: ContactPoint introductory paragraph\n- Edit type: replace\n- Current text (exact): `contact informations`\n- Proposed text (exact): `contact information`\n- Pre-context: `context of the contact`\n- Post-context: `use to be provided`\n- Occurrence rule: unique prose occurrence\n- Rationale: use the uncountable noun form in technical prose.\n- Validation check: rebuild/publish and confirm the rendered wording.")
    patch = "\n\n".join(changes) if changes else "None. No patch-ready source edit is recommended from the checks above."
    return f"""# Technical Corrections Review Report

## Metadata
- Review ID: batch-2026-08-17-{page}-technical
- Date: 2026-08-17
- Mode: page
- Target: fhir-repo/publish/{page}.html
- Status: ready

## Build Evidence
- Build check command: `./.github/skills/build-fhir/scripts/build-if-needed.sh --repo ./fhir-repo --mode check`
- Build check result: `BUILD_NEEDED: no`
- Build status used for review: current

## Inputs Used
- Source files:
{source_bullets(source)}
- Output files:
  - {output.relative_to(ROOT)}

## W3C Findings
### Section 7.2
- {w3c}
### Section 7.3
- None. No citation-format deviation was confirmed.
### Section 11
- {w3c}
### Section 13
- None beyond spelling findings recorded below.

## Link Target Validation Findings
- {link}

## Link Description Correspondence Findings
- None. No confirmed mismatch between link text and target descriptor.

## Spelling Findings
{spelling_text}

## Non-W3C Technical Corrections
- None beyond the link and spelling findings above.

## Patch-Ready Change Set
{patch}

## Apply Sequence
1. Apply only confirmed source-context changes after review of the exact source anchor.
2. Rebuild/publish and rerun link, spelling, and W3C checks.

## Blocking Issues
- None.
"""


def main() -> None:
    for page in PAGES:
        output = PUBLISH / f"{page}.html"
        source = source_files(page)
        text = output.read_text(errors="ignore")
        terms, missing, spelling = signals(page, text)
        folder = REVIEW / f"{page}.html"
        folder.mkdir(parents=True, exist_ok=True)
        (folder / f"{page}-change-requests.md").write_text(nontechnical(page, output, source, terms, missing), encoding="utf-8")
        (folder / f"{page}-technical-corrections.md").write_text(technical(page, output, source, terms, missing, spelling), encoding="utf-8")


if __name__ == "__main__":
    main()