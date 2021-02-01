# List of trusted accounts for cross account access
# More Info: https://turbot.com/v5/docs/concepts/guardrails/trusted-access
trusted_accounts = [
  "{{ $.account.Id }}", # Self - current AWS Account
  "287590803701",       # Turbot SaaS US Prod
  "255798382450",       # Turbot SaaS EU Account
]

# Uses the more complex calculated policy for the version control.
# See file, s3_versioning_policies.tf
use_simple_s3_bucket_versioning = false
