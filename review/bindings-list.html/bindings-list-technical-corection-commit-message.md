Fix bindings-list technical corrections

- LNK-001: Skipped - correct the comparison-operation ValueSet label.
  - File: `fhir-repo/source/datatypes/valueset-comparison-operation.xml`
  - Change: `Dose Limit Scope ValueSet` -> `Comparison Operation ValueSet`
  - Reason: The bindings-list link targets the comparison-operation ValueSet but displays the dose-limit-scope label. The report's stated page target is generated from this ValueSet title, and changing it is a substantive terminology/specification change rather than a safe page-local technical correction.
