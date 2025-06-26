# AWS > Secrets Manager > Secret > Approved
resource "turbot_policy_setting" "aws_secretsmanager_secret_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-secretsmanager#/policy/types/secretApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
}

# AWS > Secrets Manager > Secret > Approved > Custom
resource "turbot_policy_setting" "aws_secretsmanager_secret_approved_custom" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/aws-secretsmanager#/policy/types/secretApprovedCustom"
  template_input = <<-EOT
    - |
      {
        trustedOrgs: policy(uri: "tmod:@turbot/aws#/policy/types/trustedOrganizations")
        trustedAccounts: policy(uri: "tmod:@turbot/aws#/policy/types/trustedAccounts") 
        resource {
          policy: get(path:"ResourcePolicy")
        }
      }
    EOT
  template       = <<-EOT
    {%- set limited_to_org = "Skip" %}
    {%- set limited_to_org_reason = "No PrincipalOrgID Condition" %}
    {%- set approved_principal = true %}
    {%- for statement in $.resource.policy.Statement %}
      {%- if statement.Effect == "Allow" %}
        {%- if "Condition" in statement and "StringEquals" in statement.Condition and "aws:PrincipalOrgID" in statement.Condition.StringEquals %}
          {%- if limited_to_org in ["Skip", "Approved"] and statement.Condition.StringEquals["aws:PrincipalOrgID"] in $.trustedOrgs %}
              {%- set limited_to_org = "Approved" %}
            {%- set limited_to_org_reason = "Policy limited to trusted AWS Orgs." %}
          {%- else %}
            {%- set limited_to_org = "Not approved" %}
            {%- set limited_to_org_reason = "Resource allows untrusted organization access." %}
          {%- endif %}
        {%- endif %}
        {%- if limited_to_org not in ["Approved"] and "*" not in $.trustedAccounts %}
          {%- if "AWS" in statement.Principal and statement.Principal.AWS is string %}
            {%- set principals = [statement.Principal.AWS] %}
          {%- else %}
              {%- set principals = statement.Principal.AWS %}
          {%- endif %}
          {%- for principal in principals %}
            {%- if principal.split(':')[4] not in $.trustedAccounts %}
              {%- set approved_principal = false %}
              {%- endif %}
          {%- endfor %}
        {%- endif %}
      {%- endif %}
    {%- endfor %}
    - title: "Resource Policy Approved Orgs"
      result: "{{limited_to_org}}"
      message: "{{limited_to_org_reason}}"
    {%- if limited_to_org == "Approved" %}
    - title: "Resource Policy Approved Accts"
      result: "Skip"
      message: "AWS Org Policy in Effect"
    {%- elseif approved_principal %}
    - title: "Resource Policy Approved Accts"
      result: "Approved"
      message: "No unapproved accounts in the Resource Policy"
    {%- else %}
    - title: "Resource Policy Approved Accts"
      result: "Not approved"
      message: "Unapproved account in Resource Policy."
    {%- endif %}
    EOT
}