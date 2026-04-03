Search the repository to find the correct Guardrails policy type URI for: $ARGUMENTS

1. Search all `policies.tf` and `main.tf` files across `policy_packs/` for `tmod:@turbot/` URIs matching the user's query (service name, resource type, or keyword).

2. Present results grouped by provider and service, showing:
   - The `tmod:` URI
   - The policy setting value options (Check/Enforce variants)
   - Which policy pack uses it (with path)

3. If the search term is ambiguous, show all close matches and ask the user to clarify.

This is useful when creating or modifying policy packs and you need the exact `tmod:` policy type URI.
