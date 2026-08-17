# Normative Text on Informative Pages

Checked all 134 HTML pages in `fhir-repo/source` whose page-level Standards Status is `Informative`.

**Result:** 15 informative pages contain 44 uppercase normative-term occurrences (`MUST`, `SHALL`, `SHOULD`, or `MAY`).

| Page | Occurrences |
|---|---:|
| [administration-module.html](../fhir-repo/source/administration-module.html) | 4 |
| [documentation.html](../fhir-repo/source/documentation.html) | 2 |
| [ehr-fm.html](../fhir-repo/source/ehr-fm.html) | 1 |
| [elementdefinition-examples.html](../fhir-repo/source/elementdefinition-examples.html) | 1 |
| [exchanging.html](../fhir-repo/source/exchanging.html) | 2 |
| [extensibility-examples.html](../fhir-repo/source/extensibility-examples.html) | 2 |
| [help.html](../fhir-repo/source/help.html) | 17 |
| [history.html](../fhir-repo/source/history.html) | 4 |
| [languages.html](../fhir-repo/source/languages.html) | 1 |
| [profiling-examples.html](../fhir-repo/source/profiling-examples.html) | 1 |
| [safety.html](../fhir-repo/source/safety.html) | 4 |
| [services.html](../fhir-repo/source/services.html) | 1 |
| [terminologies-binding-examples.html](../fhir-repo/source/terminologies-binding-examples.html) | 2 |
| [updates.html](../fhir-repo/source/updates.html) | 1 |
| [validation.html](../fhir-repo/source/validation.html) | 1 |

## Detailed Findings

Each section below describes the issue and lists the uppercase normative terms found in the page's normalized rendered text.

### [administration-module.html](../fhir-repo/source/administration-module.html)

**Issue:** Normative text on informative page.

| Section number | Text snippet |
|---|---|
| 8.0.3.1 | Systems **MAY** use `.identifier` on the Patient, RelatedPerson, Practitioner or Person resources for user identities. |
| 8.0.3.1 | When using a Person resource, this identifier **MAY** be duplicated to the other related resources. |
| 8.0.3.1 | User identities **MAY** be handled completely outside of FHIR and not represented on FHIR resources at all. |
| 8.0.3.1 | The FHIR SMART App Launch specification **MAY** refer to a FHIR Patient, RelatedPerson, Practitioner, PractitionerRole or Person resource instance. |

### [documentation.html](../fhir-repo/source/documentation.html)

**Issue:** Normative text on informative page.

| Section number | Text snippet |
|---|---|
| 2.1.0 | Documentation describes what Implementations **SHALL** or **SHOULD** do. |
| 2.1.0 | Documentation describes what Implementations **SHALL** or **SHOULD** do. |

### [ehr-fm.html](../fhir-repo/source/ehr-fm.html)

**Issue:** Normative text on informative page.

| Section number | Text snippet |
|---|---|
| 7.8 | All conformant FHIR RESTful implementations **SHALL** be able to use TLS. |

### [elementdefinition-examples.html](../fhir-repo/source/elementdefinition-examples.html)

**Issue:** Normative text on informative page.

| Section number | Text snippet |
|---|---|
| 2.1.30.6.1.1.3 | Any code element present **SHALL** have at least one coding with at least that system. |

### [exchanging.html](../fhir-repo/source/exchanging.html)

**Issue:** Normative text on informative page.

| Section number | Text snippet |
|---|---|
| 3.1.0.1 | Implementation guides **SHOULD** provide an explanation of the considerations that drove the selection. |
| 3.1.0.1 | Implementation guides **SHOULD** provide an explanation of the considerations, whether drawn from this document or otherwise. |

### [extensibility-examples.html](../fhir-repo/source/extensibility-examples.html)

**Issue:** Normative text on informative page.

| Section number | Text snippet |
|---|---|
| 2.1.5.2.1.2 | Systems **SHALL** conform to the policies as indicated. |
| 2.1.5.2.1.2 | URI is a literal reference to agreement text; Systems **SHALL** conform to the policies as indicated. |

### [help.html](../fhir-repo/source/help.html)

**Issue:** Normative text on informative page.

| Section number | Text snippet |
|---|---|
| 2.1.24.3 | FHIR uses the conformance verbs **SHALL**, **SHOULD**, and **MAY** as defined in RFC 2119. |
| 2.1.24.3 | The correct verb for an absolute requirement is **SHALL**. |
| 2.1.24.3 | The terminology does not recognize **MUST**; use **SHALL** for a mandatory aspect. |
| 2.1.24.3 | The correct verb form for a recommendation is **SHOULD**. |
| 2.1.24.3 | The correct verb form for an option is **MAY**. |
| 2.1.24.3 | The negatives are **SHALL NOT** and **SHOULD NOT**. |
| 2.1.24.3 | The conformance verb **MAY** is used to indicate a possibility. |
| 2.1.24.3 | The conformance verb **MAY** is used to indicate a possibility. |
| 2.1.24.3 | The RIM **MAY** contain additional classes cloned from RIM classes. |
| 2.1.24.3 | **SHALL** is the conformance verb used to indicate a requirement. |
| 2.1.24.3 | **SHALL** is used to indicate a requirement. |
| 2.1.24.3 | **SHOULD** is the conformance verb used to indicate a recommendation. |
| 2.1.24.3 | **SHOULD** is the conformance verb used to indicate a recommendation. |
| 2.1.24.3 | **MAY** is the conformance verb used to indicate a possibility. |
| 2.1.24.3 | **SHALL** is the conformance verb used to indicate a requirement. |
| 2.1.24.3 | **SHOULD** is the conformance verb used to indicate a recommendation. |
| 2.1.24.3 | **MAY** is the conformance verb used to indicate a possibility. |

### [history.html](../fhir-repo/source/history.html)

**Issue:** Normative text on informative page.

| Section number | Text snippet |
|---|---|
| 2.1.11 | The introduction of new **SHALL** and **SHOULD** conformance statements is described. |
| 2.1.11 | The new **SHALL** statements are believed to be clarifications. |
| 2.1.11 | Implementers should review the pages carefully, including the new **SHOULD** requirement. |
| 2.1.11 | The new **SHOULD** requirement concerns clients and timezones. |

### [languages.html](../fhir-repo/source/languages.html)

**Issue:** Normative text on informative page.

| Section number | Text snippet |
|---|---|
| 7.12.2 | The choice of locale from the Accept-Language headers **MAY** change the syntax of resource narrative. |

### [profiling-examples.html](../fhir-repo/source/profiling-examples.html)

**Issue:** Normative text on informative page.

| Section number | Text snippet |
|---|---|
| 5.1.1.2 | The invariant states that there **SHALL** be a discriminator or description. |

### [safety.html](../fhir-repo/source/safety.html)

**Issue:** Normative text on informative page.

| Section number | Text snippet |
|---|---|
| 7.7.8 | Systems **SHOULD** check the narrative status. |
| 7.7.8 | If the status is `additional`, narrative **SHOULD** always be available. |
| 7.7.8 | If extensions are not rendered, the narrative **SHOULD** be available. |
| 7.7.8 | If core elements are not rendered, the narrative **SHOULD** be available. |

### [services.html](../fhir-repo/source/services.html)

**Issue:** Normative text on informative page.

| Section number | Text snippet |
|---|---|
| 3.6.4 | Services that exchange resources **MAY** choose to support describing and changing descriptions of service. |

### [terminologies-binding-examples.html](../fhir-repo/source/terminologies-binding-examples.html)

**Issue:** Normative text on informative page.

| Section number | Text snippet |
|---|---|
| 4.2.4.2 | The code 233607000 for Pneumococcal pneumonia **SHALL** be used instead. |
| 4.2.4.4 | Implementers **SHOULD NOT** assume that the codes are production ready. |

### [updates.html](../fhir-repo/source/updates.html)

**Issue:** Normative text on informative page.

| Section number | Text snippet |
|---|---|
| 7.11.7 | The server **SHOULD** either echo back a copy of what was stored and include an ETag. |

### [validation.html](../fhir-repo/source/validation.html)

**Issue:** Normative text on informative page.

| Section number | Text snippet |
|---|---|
| 7.2 | All the clinically important content in the data **SHALL** be in the narrative. |

