# List of trusted accounts for cross account access
# More Info: https://turbot.com/v5/docs/concepts/guardrails/public-access

trusted_accounts  = [
  "{{ $.account.Id }}", # Self - current AWS Account
  "287590803701", # Turbot SaaS US Prod
  "255798382450", # Turbot SaaS EU Account
]