# List of trusted accounts for cross account access
# More Info: https://turbot.com/v5/docs/concepts/guardrails/trusted-access
trusted_accounts = [
  "{{ $.account.Id }}", # Self - current AWS Account
  "111122223333",       # AWS account 111122223333
  "999988887777",       # AWS account 999988887777
]

# Uses the more complex calculated policy for the version control.
# See file, s3_versioning_policies.tf
use_simple_s3_bucket_versioning = false
