## Merge-resolution rationale: FHIR-54000 and FHIR-51651

The agreed resolution of the conflicts in `SearchParameter.base` and `SearchParameter.target` combines the intent of both tickets:

- Retain `http://hl7.org/fhir/ValueSet/extended-resource-types` from this PR, implementing [FHIR-54000](https://jira.hl7.org/browse/FHIR-54000).
- Adopt the `extensible` binding strength from master, preserving support for logical-model types introduced under [FHIR-51651](https://jira.hl7.org/browse/FHIR-51651).
- Retain the `uri` datatype and master's logical-model definitions, binding description, copyright metadata, and removal of the old additional UI bindings.

### Why retain extended-resource-types?

Its membership is a superset of master's `version-independent-resource-types`:

| Included source | version-independent-resource-types | extended-resource-types |
| --- | --- | --- |
| `ValueSet/resource-types` | Yes | Yes |
| `CodeSystem/fhir-old-types` | Yes | Yes |
| `http://hl7.org/fhir/tools/CodeSystem/additional-resources` | No | Yes |

Keeping the larger ValueSet preserves all members of the upstream ValueSet while explicitly including registered additional resources, as requested by FHIR-54000. Its definition states that additional-resource membership is not version fixed and changes over time.

### Why adopt extensible?

Neither ValueSet explicitly includes arbitrary logical-model types. Retaining a required binding would restrict values to the selected ValueSet, excluding logical-model URIs outside it. An extensible binding is needed to preserve the flexibility introduced for FHIR-51651: values outside the ValueSet remain possible under the applicable extensible-binding rules and element constraints.

The upstream change was introduced in [commit b17a5b964a](https://github.com/HL7/fhir/commit/b17a5b964a0d8e1871bfd771c8f71d2a57ae3292). FHIR-51651's recorded resolution explicitly names both SearchParameter elements, although it does not explicitly prescribe the word `extensible`.

The combined result for both elements is therefore:

```xml
<strength value="extensible"/>
<description value="Either a resource or a data type, including logical model types."/>
<valueSet value="http://hl7.org/fhir/ValueSet/extended-resource-types"/>
```

This retains FHIR-54000's explicit additional-resource coverage without undoing FHIR-51651's logical-model support.
