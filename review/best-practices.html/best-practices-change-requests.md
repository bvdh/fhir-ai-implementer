# Non-Technical FHIR Review Report

## Metadata
- Review ID: best-practices-2026-08-14
- Date: 2026-08-14
- Mode: page
- Target input: `fhir-repo/publish/best-practices.html`
- Resolved output page: `fhir-repo/publish/best-practices.html`
- Status: ready

## Build Evidence
- Build check command: ./.github/skills/build-fhir/scripts/build-if-needed.sh --repo ./fhir-repo --mode check
- Build check result: `BUILD_NEEDED: no`
- Notes: Freshness gate passed; no rebuild was required.

## Inputs Used
- Source files:
  - `fhir-repo/source/best-practices.html`
  - Source definitions contributing the generated best-practice table entries were reviewed through the rendered output.
- Output files:
  - `fhir-repo/publish/best-practices.html`

## Agent Input Payload
- target_input: fhir-repo/publish/best-practices.html
- resolved_output_page: /home/nly98977/SwArchives/bvdh/fhir-ai-implementer/fhir-repo/publish/best-practices.html
- source_context_hint: fhir-repo/source/**

## Rule 1 Findings: Normative Language on Informative Pages

- **Finding R1-001**
  - Rule ID: rule1
  - Severity: warning
  - Confidence: high
  - Location: Best Practices table, DomainResource `dom-6` and Appointment `app-6` rows
  - Evidence snippet: `A resource should have narrative for robust management`; `an appointment may have ...`; `the originating appointment should have ...`
  - Rationale: The page is marked Informative, but these recommendation statements use normative terms. Informative prose should avoid MUST, SHALL, SHOULD, and MAY terminology.
  - Suggested rewrite: Use descriptive wording such as `A resource commonly includes narrative for robust management` and `An appointment can have ...; the originating appointment typically has ...`.

- **Finding R1-002**
  - Rule ID: rule1
  - Severity: warning
  - Confidence: high
  - Location: Best Practices table, CodeSystem `csd-7` row
  - Evidence snippet: `caseSensitive SHOULD be provided`
  - Rationale: Uppercase SHOULD is explicit normative language on an Informative page.
  - Suggested rewrite: `Providing caseSensitive helps avoid unsafe interpretation of codes`.

- **Finding R1-003**
  - Rule ID: rule1
  - Severity: warning
  - Confidence: high
  - Location: Best Practices table, ConceptMap `cmd-12`, `cmd-1`, and `cmd-13` rows
  - Evidence snippet: `there SHOULD be some comments, unless the status is 'draft'`
  - Rationale: The three ConceptMap recommendations use uppercase SHOULD in their indexed rule text.
  - Suggested rewrite: Replace with descriptive language, for example `comments explain why ... when the status is not 'draft'`.

- **Finding R1-004**
  - Rule ID: rule1
  - Severity: warning
  - Confidence: high
  - Location: Best Practices table, Questionnaire `que-19`, `que-20`, and `que-21` rows
  - Evidence snippet: `both code and system should be present`
  - Rationale: The repeated recommendation uses normative `should` language on an Informative page.
  - Suggested rewrite: `Both code and system are typically present when using codings`.

- **Finding R1-005**
  - Rule ID: rule1
  - Severity: warning
  - Confidence: high
  - Location: Best Practices table, StructureDefinition `sdf-26` row
  - Evidence snippet: `should not have mustSupport = true`; `mustSupport should always be determined`
  - Rationale: The indexed recommendation contains two normative `should` terms.
  - Suggested rewrite: `The root element of a profile generally does not have mustSupport = true. The element referencing a type determines mustSupport in context.`

## Rule 2 Findings: Normative Language in note/summary/comment Fields
- None. The target is a narrative index page; its table cells are best-practice rule text, not FHIR resource note, summary, or comment fields.

## Rule 3 Findings: Regulatory Expressions vs Description
- None. No regulatory expression requiring same-page alignment was identified.

## Rule 4 Findings: FHIRPath Expressions vs Description
- None. No FHIRPath expression is present on the page.

## Rule 5 Findings: Contradictions on Page
- None. The introductory prose and indexed best-practice entries do not make mutually exclusive claims.

## Rule 6 Findings: subject Field Requires patient and/or subject Search Parameter
- None. Rule 6 is not triggered: this page does not define a FHIR resource `subject` element.
  - subject context: No resource element definition or subject field appears in the page content.
  - search parameters observed: No resource-specific search-parameter inventory is applicable; the page only links to the general Search Parameters registry.

## Cross-Rule Synthesis
- Five grouped Rule 1 findings cover normative wording in the indexed DomainResource, Appointment, CodeSystem, ConceptMap, Questionnaire, and StructureDefinition best-practice rows. Rules 2 through 6 found no additional issues.

## Blocking Issues
- None.
