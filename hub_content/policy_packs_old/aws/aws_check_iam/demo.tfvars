# See file, role_trust_policy.tf
trusted_accounts = [
  "{{ $.account.Id }}", # Self - current AWS Account
  "287590803701",       # Turbot SaaS US Prod
  "255798382450",       # Turbot SaaS EU Account
  "525041748188",	    #Turbot SaaS Dev Account
]

# See file, role_trust_policy.tf
enable_iam_role_policy_trusted_access = false
enable_iam_role_trusted_accounts = false
