# Jira Comment Draft: FHIR-46202 Regex Decision

For FHIR-46202, I implemented the code primitive regex as:

`^[^\s]+( [^\s]+)*$`

instead of:

`^[^\s]+(\s[^\s]+)*$`

Reason for deviation:
- The datatype prose says: "no whitespace other than single spaces in the contents".
- Using `\s` allows non-space whitespace characters (for example tabs and line breaks), which is broader than the prose requirement.
- Using a literal space in the separator enforces exactly one internal space between non-whitespace tokens, while still enforcing:
  - at least one character,
  - no leading/trailing whitespace,
  - no repeated internal spaces.

This keeps the regex behavior aligned with the normative wording for `code`.
