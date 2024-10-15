# AWS > Athena > Workgroup > Approved
resource "turbot_policy_setting" "aws_athena_workgroup_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-athena#/policy/types/workgroupApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
}

# 29 Ensure that AWS Athena query results stored in Amazon S3 are encrypted at rest.
# AWS > Athena > Workgroup > Approved > Custom
resource "turbot_policy_setting" "aws_athena_workgroup_approved_custom" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/aws-athena#/policy/types/workgroupApprovedCustom"
  template_input = <<-EOT
    {
        workgroup {
          resultEncryptionConfig: get(path: "Configuration.ResultConfiguration.EncryptionConfiguration.EncryptionOption")
          workspaceMinimumEncryption: get(path: "Configuration.EnableMinimumEncryptionConfiguration")
        }
      }
    EOT
  template       = <<-EOT

    {%- set data = { 
      "title": "Encryption enabled",
      "result": "Not approved",
      "message": "No encryption options for this workgroup"
    } -%}

    {%- if $.workspace.workspaceMinimumEncryption -%} 
      {%- set data = { 
        "title": "Encryption enabled",
        "result": "Approved",
        "message": "Minimum encryption option set for workspace"
      } -%}

    {%- elif $.workspace.resultEncryptionConfig -%} 
      {%- set data = { 
        "title": "Encryption enabled",
        "result": "Approved",
        "message": "Result configuration set to: " + $.workspace.resultEncryptionConfig
      } -%}

    {%- endif -%}
    {{ data | json }}
    EOT
}
