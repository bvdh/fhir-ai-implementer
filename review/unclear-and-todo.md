# Unclear and TODO Findings

Scan scope: generated HTML under `fhir-repo/publish/` (10,867 HTML pages), scanned on 2026-08-14.

The sections below identify locations containing TODO markers, vague text, unanswered questions, incomplete examples, or unresolved rationale that should be addressed by the responsible workgroup. Repeated JSON/XML/TTL renderings of the same page content are represented once. Repeated identical rows within one page remain represented by an occurrence count and all observed source lines. Each table uses `Page` for the generated specification page, `Occurrences` for the number of matching instances, `Location(s)` for source line numbers, `Unclear or TODO text` for the detected wording, and `Assessment` for the reason it was included. Confidence is described in each section rather than shown as a table column.

## FHIR Infrastructure Work Group

The following FHIR Infrastructure locations contain high-confidence explicit TODO markers, missing references, unanswered design questions, vague approval criteria, or incomplete workflow guidance, plus two low-confidence standalone `TBD` placeholders. The table columns identify the page, occurrence count, source locations, detected wording, and why the item should be reviewed.

| Page | Occurrences | Location(s) | Unclear or TODO text | Assessment |
|---|---:|---|---|---|
| [resource.html](https://build.fhir.org/resource.html) | 1 | 248 | “HL7 publishes the list of approved resource at (somewhere?)” and “todo: this needs further work” | High-confidence unresolved destination and editorial placeholder. |
| [resource.html](https://build.fhir.org/resource.html) | 1 | 286 | “criteria TBD by FMG” | High-confidence finding: approval criteria are not stated. |
| [requirements.html](https://build.fhir.org/requirements.html) | 1 | 195 | “Is there a pattern that this resource does fit? Metadata? Artifact?” | High-confidence unresolved resource classification question. |
| [workflow-ad-hoc.html](https://build.fhir.org/workflow-ad-hoc.html) | 1 | 337 | “TODO: needs review and update” | High-confidence explicit unfinished editorial work. |
| [workflow-ad-hoc.html](https://build.fhir.org/workflow-ad-hoc.html) | 1 | 392 | “TODO: Needs review, update and more work” because there is limited experience using FHIR services for fulfillment | High-confidence section is explicitly incomplete. |
| [workflow-ad-hoc.html](https://build.fhir.org/workflow-ad-hoc.html) | 1 | 428 | “TODO: needs review and update. Possibly add options about using messaging and/or services instead of polling/subscription” | High-confidence open design question about supported workflow options. |
| [workflow-ad-hoc.html](https://build.fhir.org/workflow-ad-hoc.html) | 1 | 420 | “TBD” | Low-confidence standalone placeholder in workflow content; surrounding context should be reviewed. |
| [workflow-management.html](https://build.fhir.org/workflow-management.html) | 1 | 180 | “TODO: Discussion (or reference to one) on Polling and Subscription” | High-confidence missing discussion or reference. |
| [workflow-management.html](https://build.fhir.org/workflow-management.html) | 1 | 381 | “TODO: Still needs review and update” | High-confidence explicit unfinished editorial work. |
| [workflow-management.html](https://build.fhir.org/workflow-management.html) | 1 | 521 | “TODO: needs more details” | High-confidence missing detail. |
| [workflow-management.html](https://build.fhir.org/workflow-management.html) | 1 | 574 | “TODO: This scenario needs work” because there is limited experience using FHIR services for fulfillment | High-confidence scenario is explicitly incomplete. |
| [workflow-management.html](https://build.fhir.org/workflow-management.html) | 1 | 655 | “TODO: needs review and update. Possibly add options about using messaging and/or services instead of polling/subscription” | High-confidence open design question about supported workflow options. |
| [workflow-management.html](https://build.fhir.org/workflow-management.html) | 1 | 604 | “TBD” | Low-confidence standalone placeholder in workflow content; surrounding context should be reviewed. |
| [graphql.html](https://build.fhir.org/graphql.html) | 1 | 222 | Systems SHALL indicate GraphQL query support “(todo: how)” | High-confidence requirement lacks the mechanism or conformance detail. |
| [graphql.html](https://build.fhir.org/graphql.html) | 1 | 993 | “Todo: mutations for patch, batch, transaction?” | High-confidence unanswered scope question for GraphQL mutations. |
| [defining-extensions.html](https://build.fhir.org/defining-extensions.html) | 1 | 492 | “Todo: point to actual registry once it's up and running” | High-confidence registry reference is unfinished. |
| [defining-extensions.html](https://build.fhir.org/defining-extensions.html) | 1 | 496 | “Todo: Figure out how to manage ‘deprecating’ extensions and pointing at their new versions” | High-confidence unresolved extension lifecycle behavior. |
| [exchanging.html](https://build.fhir.org/exchanging.html) | 1 | 760 | “TODO - create ExampleScenarios showing each of the workflows” | High-confidence missing examples. |
| [capabilitystatement.html](https://build.fhir.org/capabilitystatement.html) | 1 | 274 | TODO block covering unknown-content handling, creation and ID behavior, and requirement wording | High-confidence multiple unresolved CapabilityStatement requirements in one editorial block. |
| [documents.html](https://build.fhir.org/documents.html) | 1 | 374 | “todo: title” | High-confidence unfinished title placeholder. |
| [comparison-v2.html](https://build.fhir.org/comparison-v2.html) | 1 | 280 | “Todo: Link” to the extension registry | High-confidence missing registry link. |
| [op-example-request.html](https://build.fhir.org/op-example-request.html) | 1 | 199 | “todo: work this over ... how should this be done?” for an `is-a` terminology filter | High-confidence unanswered implementation question in an operation example. |

## FHIR Infrastructure

The following location is assigned to FHIR Infrastructure in the page metadata without the “Work Group” suffix and contains one high-confidence standalone unfinished marker. The table columns identify the page, occurrence count, source line, detected wording, and assessment.

| Page | Occurrences | Location(s) | Unclear or TODO text | Assessment |
|---|---:|---|---|---|
| [fivews.html](https://build.fhir.org/fivews.html) | 1 | 651 | “Todo” | High-confidence standalone unfinished marker. |

## Implementable Technology Specifications Work Group

The following locations contain high-confidence unfinished verification work or an incomplete list of technology formats and references. The table columns identify the page, occurrence count, source line, detected wording, and assessment.

| Page | Occurrences | Location(s) | Unclear or TODO text | Assessment |
|---|---:|---|---|---|
| [rdf.html](https://build.fhir.org/rdf.html) | 1 | 270 | “TODO: Verify the ones below marked ‘VERIFY’” | High-confidence verification work is unfinished. |
| [xml.html](https://build.fhir.org/xml.html) | 1 | 502 | “Todo: Relax NG, RDF, eCore” | High-confidence unfinished scope or reference list. |

## Clinical Decision Support Work Group

The following locations contain high-confidence unresolved classification, example, and applicability questions, plus one low-confidence group of placeholder terminology references. The table columns identify the page, occurrence count, source line(s), detected wording, and assessment.

| Page | Occurrences | Location(s) | Unclear or TODO text | Assessment |
|---|---:|---|---|---|
| [artifactassessment.html](https://build.fhir.org/artifactassessment.html) | 1 | 184 | “TODO: Is there a pattern that this resource does fit? Metadata? Artifact?” | High-confidence unresolved resource classification question. |
| [riskassessment-example-population.html](https://build.fhir.org/riskassessment-example-population.html) | 1 | 136 | “Todo - e.g. probable number of infections...” | High-confidence incomplete example narrative. |
| [library-hiv-indicators.html](https://build.fhir.org/library-hiv-indicators.html) | 8 | 155-168 | `TBD` URLs for PMTCT HIV status, PMTCT ART status, HIV testing, viral load, ART medications, antenatal care, pregnancy, live birth, and breastfeeding concepts | Low-confidence placeholder terminology references; confirm whether these are intentionally illustrative or must be resolved. |
| [eventdefinition-definitions.html](https://build.fhir.org/eventdefinition-definitions.html) | 6 | 712, 911, 935, 963, 991, 1023 | “Does this apply?” | High-confidence six unresolved applicability questions on EventDefinition elements. |

## Orders and Observations Work Group

The following definition pages contain high-confidence statements that the reason an element is labelled a modifier is not known. Each rationale should be confirmed or replaced with an explicit explanation. The table columns identify the page, occurrence count, source line, detected wording, and assessment.

| Page | Occurrences | Location(s) | Unclear or TODO text | Assessment |
|---|---:|---|---|---|
| [observationdefinition-definitions.html](https://build.fhir.org/observationdefinition-definitions.html) | 1 | 405 | “Not known why this is labelled a modifier” | High-confidence modifier rationale is unresolved. |
| [specimendefinition-definitions.html](https://build.fhir.org/specimendefinition-definitions.html) | 1 | 423 | “Not known why this is labelled a modifier” | High-confidence modifier rationale is unresolved. |
| [subscriptionstatus-definitions.html](https://build.fhir.org/subscriptionstatus-definitions.html) | 1 | 251 | “Not known why this is labelled a modifier” | High-confidence modifier rationale is unresolved. |

## Pharmacy Work Group

The following mapping contains one low-confidence `TBD` value whose intended status should be confirmed and either resolved or explicitly documented as intentional. The table columns identify the page, occurrence count, source line, detected wording, and assessment.

| Page | Occurrences | Location(s) | Unclear or TODO text | Assessment |
|---|---:|---|---|---|
| [medicationstatement-mappings.html](https://build.fhir.org/medicationstatement-mappings.html) | 1 | 354 | `TBD` | Low-confidence unresolved mapping value; surrounding mapping context should determine whether it is intentional. |

## Terminology Infrastructure Work Group

The following ConceptMap example contains 22 low-confidence mapping-detail placeholders. These should be reviewed to determine whether the example is intentionally partial or whether detailed mappings are expected. The table columns identify the page, occurrence count, source lines, detected wording, and assessment.

| Page | Occurrences | Location(s) | Unclear or TODO text | Assessment |
|---|---:|---|---|---|
| [conceptmap-example-specimen-type.html](https://build.fhir.org/conceptmap-example-specimen-type.html) | 22 | 197, 206, 482, 500, 692, 794, 911, 956, 965, 992, 1022, 1082, 1103, 1253, 1526, 1685, 1790, 1799, 1919, 1955, 2117, 2126 | “TBD in detail” | Low-confidence twenty-two mapping-detail placeholders in the example ConceptMap. |

## Scan Notes

- High confidence means the page contains an explicit TODO, an unanswered question, an unresolved rationale, or a visibly incomplete statement.
- Low confidence means the page contains a `TBD` placeholder in a code, mapping, or example context that may be intentional.
- The scan excluded ordinary definitions of the `unknown` status that say a system is “not sure” of a status; those are intended semantics, not editorial uncertainty.
- Generated JSON, XML, and TTL display pages were not counted as separate occurrences when they repeated the same source content.
