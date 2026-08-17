# Unclear and TODO Findings

Scan scope: generated HTML under `fhir-repo/publish/` (10,867 HTML pages), scanned on 2026-08-14.

The sections below identify locations containing TODO markers, vague text, unanswered questions, incomplete examples, or unresolved rationale that should be addressed by the responsible workgroup. Repeated JSON/XML/TTL renderings of the same page content are represented once. Each page is presented in a four-row table: summary, workgroup, findings, and current description.

## Findings by Page

Each page appears once. Findings from different work groups are kept together so that a responsible group can review the complete set of issues for the page.

### artifactassessment.html
| Field | Details |
|---|---|
| Summary | Unclear and TBD in file artifactassessment.html |
| Workgroup | Clinical Decision Support |
| Related Jira ticket | [FHIR-58460](https://jira.hl7.org/browse/FHIR-58460) |
| Findings | [artifactassessment.html](https://build.fhir.org/artifactassessment.html)<br>1 occurrence at line 184: “TODO: Is there a pattern that this resource does fit? Metadata? Artifact?” |
| Current description | High-confidence unresolved resource classification question. |

### capabilitystatement.html
| Field | Details |
|---|---|
| Summary | Unclear and TBD in file capabilitystatement.html |
| Workgroup | FHIR Infrastructure |
| Related Jira ticket | [FHIR-58461](https://jira.hl7.org/browse/FHIR-58461) |
| Findings | [capabilitystatement.html](https://build.fhir.org/capabilitystatement.html)<br>1 occurrence at line 274: TODO block covering unknown-content handling, creation and ID behavior, and requirement wording. |
| Current description | High-confidence set of unresolved CapabilityStatement requirements in one editorial block. |

### comparison-v2.html
| Field | Details |
|---|---|
| Summary | Unclear and TBD in file comparison-v2.html |
| Workgroup | FHIR Infrastructure |
| Related Jira ticket | [FHIR-58462](https://jira.hl7.org/browse/FHIR-58462) |
| Findings | [comparison-v2.html](https://build.fhir.org/comparison-v2.html)<br>1 occurrence at line 280: “Todo: Link” to the extension registry. |
| Current description | High-confidence missing registry link. |

### conceptmap-example-specimen-type.html
| Field | Details |
|---|---|
| Summary | Unclear and TBD in file conceptmap-example-specimen-type.html |
| Workgroup | Terminology Infrastructure |
| Related Jira ticket | [FHIR-58463](https://jira.hl7.org/browse/FHIR-58463) |
| Findings | [conceptmap-example-specimen-type.html](https://build.fhir.org/conceptmap-example-specimen-type.html)<br>22 occurrences at lines 197, 206, 482, 500, 692, 794, 911, 956, 965, 992, 1022, 1082, 1103, 1253, 1526, 1685, 1790, 1799, 1919, 1955, 2117, and 2126: “TBD in detail”. |
| Current description | Low-confidence mapping-detail placeholders in the example ConceptMap. |

### defining-extensions.html
| Field | Details |
|---|---|
| Summary | Unclear and TBD in file defining-extensions.html |
| Workgroup | FHIR Infrastructure |
| Related Jira ticket | [FHIR-58464](https://jira.hl7.org/browse/FHIR-58464) |
| Findings | [defining-extensions.html](https://build.fhir.org/defining-extensions.html)<br>2 occurrences at lines 492 and 496: “Todo: point to actual registry once it's up and running”; “Todo: Figure out how to manage ‘deprecating’ extensions and pointing at their new versions”. |
| Current description | High-confidence unfinished registry reference and unresolved extension lifecycle behavior. |

### documents.html
| Field | Details |
|---|---|
| Summary | Unclear and TBD in file documents.html |
| Workgroup | FHIR Infrastructure |
| Related Jira ticket | [FHIR-58476](https://jira.hl7.org/browse/FHIR-58476) |
| Findings | [documents.html](https://build.fhir.org/documents.html)<br>1 occurrence at line 374: “todo: title”. |
| Current description | High-confidence unfinished title placeholder. |

### eventdefinition-definitions.html
| Field | Details |
|---|---|
| Summary | Unclear and TBD in file eventdefinition-definitions.html |
| Workgroup | Clinical Decision Support |
| Related Jira ticket | [FHIR-58466](https://jira.hl7.org/browse/FHIR-58466) |
| Findings | [eventdefinition-definitions.html](https://build.fhir.org/eventdefinition-definitions.html)<br>6 occurrences at lines 712, 911, 935, 963, 991, and 1023: “Does this apply?” |
| Current description | High-confidence unresolved applicability questions on EventDefinition elements. |

### exchanging.html
| Field | Details |
|---|---|
| Summary | Unclear and TBD in file exchanging.html |
| Workgroup | FHIR Infrastructure |
| Related Jira ticket | [FHIR-58468](https://jira.hl7.org/browse/FHIR-58468) |
| Findings | [exchanging.html](https://build.fhir.org/exchanging.html)<br>1 occurrence at line 760: “TODO - create ExampleScenarios showing each of the workflows”. |
| Current description | High-confidence missing examples. |

### fivews.html
| Field | Details |
|---|---|
| Summary | Unclear and TBD in file fivews.html |
| Workgroup | FHIR Infrastructure |
| Related Jira ticket | [FHIR-58475](https://jira.hl7.org/browse/FHIR-58475) |
| Findings | [fivews.html](https://build.fhir.org/fivews.html)<br>1 occurrence at line 651: “Todo”. |
| Current description | High-confidence standalone unfinished marker. |

### graphql.html
| Field | Details |
|---|---|
| Summary | Unclear and TBD in file graphql.html |
| Workgroup | FHIR Infrastructure |
| Related Jira ticket | [FHIR-58469](https://jira.hl7.org/browse/FHIR-58469) |
| Findings | [graphql.html](https://build.fhir.org/graphql.html)<br>2 occurrences at lines 222 and 993: systems SHALL indicate GraphQL query support “(todo: how)”; “Todo: mutations for patch, batch, transaction?”. |
| Current description | High-confidence missing conformance detail and unanswered mutation scope question. |

### library-hiv-indicators.html
| Field | Details |
|---|---|
| Summary | Unclear and TBD in file library-hiv-indicators.html |
| Workgroup | Clinical Decision Support |
| Related Jira ticket | [FHIR-58470](https://jira.hl7.org/browse/FHIR-58470) |
| Findings | [library-hiv-indicators.html](https://build.fhir.org/library-hiv-indicators.html)<br>8 occurrences at lines 155-168: `TBD` URLs for PMTCT HIV status, PMTCT ART status, HIV testing, viral load, ART medications, antenatal care, pregnancy, live birth, and breastfeeding concepts. |
| Current description | Low-confidence placeholder terminology references; confirm whether they are intentionally illustrative or must be resolved. |

### medicationstatement-mappings.html
| Field | Details |
|---|---|
| Summary | Unclear and TBD in file medicationstatement-mappings.html |
| Workgroup | Pharmacy |
| Related Jira ticket | [FHIR-58471](https://jira.hl7.org/browse/FHIR-58471) |
| Findings | [medicationstatement-mappings.html](https://build.fhir.org/medicationstatement-mappings.html)<br>1 occurrence at line 354: `TBD`. |
| Current description | Low-confidence unresolved mapping value; surrounding mapping context should determine whether it is intentional. |

### observationdefinition-definitions.html
| Field | Details |
|---|---|
| Summary | Unclear and TBD in file observationdefinition-definitions.html |
| Workgroup | Orders and Observations |
| Related Jira ticket | [FHIR-58472](https://jira.hl7.org/browse/FHIR-58472) |
| Findings | [observationdefinition-definitions.html](https://build.fhir.org/observationdefinition-definitions.html)<br>1 occurrence at line 405: “Not known why this is labelled a modifier”. |
| Current description | High-confidence unresolved modifier rationale. |

### op-example-request.html
| Field | Details |
|---|---|
| Summary | Unclear and TBD in file op-example-request.html |
| Workgroup | FHIR Infrastructure |
| Related Jira ticket | [FHIR-58473](https://jira.hl7.org/browse/FHIR-58473) |
| Findings | [op-example-request.html](https://build.fhir.org/op-example-request.html)<br>1 occurrence at line 199: “todo: work this over ... how should this be done?” for an `is-a` terminology filter. |
| Current description | High-confidence unanswered implementation question in an operation example. |

### rdf.html
| Field | Details |
|---|---|
| Summary | Unclear and TBD in file rdf.html |
| Workgroup | Implementable Technology Specifications |
| Related Jira ticket | [FHIR-58474](https://jira.hl7.org/browse/FHIR-58474) |
| Findings | [rdf.html](https://build.fhir.org/rdf.html)<br>1 occurrence at line 270: “TODO: Verify the ones below marked ‘VERIFY’”. |
| Current description | High-confidence unfinished verification work. |

### requirements.html
| Field | Details |
|---|---|
| Summary | Unclear and TBD in file requirements.html |
| Workgroup | FHIR Infrastructure |
| Related Jira ticket | No matching Jira ticket found. |
| Findings | [requirements.html](https://build.fhir.org/requirements.html)<br>1 occurrence at line 195: “Is there a pattern that this resource does fit? Metadata? Artifact?” |
| Current description | High-confidence unresolved resource classification question. |

### resource.html
| Field | Details |
|---|---|
| Summary | Unclear and TBD in file resource.html |
| Workgroup | FHIR Infrastructure |
| Related Jira ticket | No matching Jira ticket found. |
| Findings | [resource.html](https://build.fhir.org/resource.html)<br>2 occurrences at lines 248 and 286: “HL7 publishes the list of approved resource at (somewhere?)” and “todo: this needs further work”; “criteria TBD by FMG”. |
| Current description | High-confidence unresolved destination, editorial placeholder, and unstated approval criteria. |

### riskassessment-example-population.html
| Field | Details |
|---|---|
| Summary | Unclear and TBD in file riskassessment-example-population.html |
| Workgroup | Clinical Decision Support |
| Related Jira ticket | [FHIR-58477](https://jira.hl7.org/browse/FHIR-58477) |
| Findings | [riskassessment-example-population.html](https://build.fhir.org/riskassessment-example-population.html)<br>1 occurrence at line 136: “Todo - e.g. probable number of infections...”. |
| Current description | High-confidence incomplete example narrative. |

### specimendefinition-definitions.html
| Field | Details |
|---|---|
| Summary | Unclear and TBD in file specimendefinitions-definitions.html |
| Workgroup | Orders and Observations |
| Related Jira ticket | [FHIR-58478](https://jira.hl7.org/browse/FHIR-58478) |
| Findings | [specimendefinitions-definitions.html](https://build.fhir.org/specimendefinitions-definitions.html)<br>1 occurrence at line 423: “Not known why this is labelled a modifier”. |
| Current description | High-confidence unresolved modifier rationale. |

### subscriptionstatus-definitions.html
| Field | Details |
|---|---|
| Summary | Unclear and TBD in file subscriptionstatus-definitions.html |
| Workgroup | Orders and Observations |
| Related Jira ticket | [FHIR-58479](https://jira.hl7.org/browse/FHIR-58479) |
| Findings | [subscriptionstatus-definitions.html](https://build.fhir.org/subscriptionstatus-definitions.html)<br>1 occurrence at line 251: “Not known why this is labelled a modifier”. |
| Current description | High-confidence unresolved modifier rationale. |

### workflow-ad-hoc.html
| Field | Details |
|---|---|
| Summary | Unclear and TBD in file workflow-ad-hoc.html |
| Workgroup | FHIR Infrastructure |
| Related Jira ticket | [FHIR-58481](https://jira.hl7.org/browse/FHIR-58481) |
| Findings | [workflow-ad-hoc.html](https://build.fhir.org/workflow-ad-hoc.html)<br>4 occurrences at lines 337, 392, 420, and 428: “TODO: needs review and update”; “TODO: Needs review, update and more work” because there is limited experience using FHIR services for fulfillment; “TBD”; and “TODO: needs review and update. Possibly add options about using messaging and/or services instead of polling/subscription”. |
| Current description | Three high-confidence unfinished or open design findings and one low-confidence standalone placeholder. |

### workflow-management.html
| Field | Details |
|---|---|
| Summary | Unclear and TBD in file workflow-management.html |
| Workgroup | FHIR Infrastructure |
| Related Jira ticket | [FHIR-58482](https://jira.hl7.org/browse/FHIR-58482) |
| Findings | [workflow-management.html](https://build.fhir.org/workflow-management.html)<br>6 occurrences at lines 180, 381, 521, 574, 604, and 655: “TODO: Discussion (or reference to one) on Polling and Subscription”; “TODO: Still needs review and update”; “TODO: needs more details”; “TODO: This scenario needs work” because there is limited experience using FHIR services for fulfillment; “TBD”; and “TODO: needs review and update. Possibly add options about using messaging and/or services instead of polling/subscription”. |
| Current description | Four high-confidence unfinished or open design findings and one low-confidence standalone placeholder. |

### xml.html
| Field | Details |
|---|---|
| Summary | Unclear and TBD in file xml.html |
| Workgroup | Implementable Technology Specifications |
| Related Jira ticket | No matching Jira ticket found. |
| Findings | [xml.html](https://build.fhir.org/xml.html)<br>1 occurrence at line 502: “Todo: Relax NG, RDF, eCore”. |
| Current description | High-confidence unfinished scope or reference list. |

## Scan Notes

- High confidence means the page contains an explicit TODO, an unanswered question, an unresolved rationale, or a visibly incomplete statement.
- Low confidence means the page contains a `TBD` placeholder in a code, mapping, or example context that may be intentional.
- The scan excluded ordinary definitions of the `unknown` status that say a system is “not sure” of a status; those are intended semantics, not editorial uncertainty.
- Generated JSON, XML, and TTL display pages were not counted as separate occurrences when they repeated the same source content.
