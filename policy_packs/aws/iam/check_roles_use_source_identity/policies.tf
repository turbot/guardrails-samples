
# AWS > IAM > Role > Approved
resource "turbot_policy_setting" "aws_iam_role_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/roleApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved"
  # value    = "Enforce: Delete unapproved if new"
  # value    = "Enforce: Quarantine unapproved"
}

# AWS > IAM > Role > Approved > Custom
resource "turbot_policy_setting" "aws_iam_role_approved_custom" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/aws-iam#/policy/types/roleApprovedCustom"
  template_input = <<-EOT
    {
      role {
        AssumeRolePolicyDocument
      }
    }
    EOT
  template       = <<-EOT
    {#- Set default values of custom approval conditions -#}
    {%- set assumeRoleApproved = "Not approved" -%}
    {%- set assumeRoleApprovedReason = "No AssumeRolewithSAML statement" -%}
    {%- set sourceIdentityApproved = "Not approved" -%}
    {%- set sourceIdentityApprovedReason = "No SetSourceIdentity statement" -%}
    {%- set uniqueStatementApproved = "Approved" -%}
    {%- set uniqueStatementApprovedReason = "AssumeRolewithSAML and SetSourceIdentity not present in same statement." -%}

    {%- for statement in $.role.AssumeRolePolicyDocument.Statement -%}
      {#- statement.Action can either be a string or array, these two statements converts either to an array: -#}
      {%- set action_string = statement.Action | string -%}
      {%- set actions = action_string.split(",") -%}
      {%- if "sts:AssumeRoleWithSAML" in actions -%}
        {%- set assumeRoleApproved = "Approved" -%}
      {%- set assumeRoleApprovedReason = "AssumeRolewithSAML statement exists" -%}
        {%- if (actions | length) > 1 -%}
          {%- set uniqueStatementApproved = "Not approved" -%}
          {%- set uniqueStatementApprovedReason = "Multiple actions present in AssumeRolewithSAML statement." -%}
        {%- endif -%}
      {%- endif -%}
      {%- if "sts:SetSourceIdentity" in actions -%}
        {%- set sourceIdentityApproved = "Approved" -%}
      {%- set sourceIdentityApprovedReason = "SetSourceIdentity statement exists" -%}
        {%- if (actions | length) > 1 -%}
          {%- set uniqueStatementApproved = "Not approved" -%}
          {%- set uniqueStatementApprovedReason = "Multiple actions present in SetSourceIdentity statement." -%}
        {%- endif -%}
      {%- endif -%}
    {% endfor -%}
    - title: "Assume Role Trust Statement"
      result: "{{assumeRoleApproved}}"
      message: "{{assumeRoleApprovedReason}}"
    - title: "Source Identity Trust Statement"
      result: "{{sourceIdentityApproved}}"
      message: "{{sourceIdentityApprovedReason}}"
    - title: "Unique Statement Contstraint"
      result: "{{uniqueStatementApproved}}"
      message: "{{uniqueStatementApprovedReason}}"
    EOT
}

