# AWS > EFS > FileSystem > Approved
resource "turbot_policy_setting" "aws_efs_file_system_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-efs#/policy/types/fileSystemApproved"
  note     = "AWS CIS v3.0.0 - Control: 2.4.1"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
}

# AWS > EFS > FileSystem > Approved > Encryption at Rest
resource "turbot_policy_setting" "aws_efs_file_system_encryption_at_rest" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-efs#/policy/types/fileSystemEncryptionAtRest"
  note     = "AWS CIS v3.0.0 - Control: 2.4.1"
  value    = "AWS managed key or higher"
}

# AWS > EFS > Mount Target > Approved
resource "turbot_policy_setting" "aws_efs_mount_target_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-efs#/policy/types/mountTargetApproved"
  note     = "AWS CIS v3.0.0 - Control: 2.4.1"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved"
  # value    = "Enforce: Delete unapproved if new"
}

# AWS > EFS > Mount Target > Approved > Custom
resource "turbot_policy_setting" "aws_efs_mount_target_approved_custom" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/aws-efs#/policy/types/mountTargetApprovedCustom"
  note           = "AWS CIS v3.0.0 - Control: 2.4.1"
  template_input = <<-EOT
    {
      mountTarget {
        parent {
          encrypted: get(path:"Encrypted")
        }
      }
    }
    EOT
  template       = <<-EOT
    {%- if $.mountTarget.parent.encrypted -%}

      {%- set data = {
          "title": "EFS Filesystem Encryption",
          "result": "Approved",
          "message": "Filesystem is encrypted"
      } -%}

    {%- else -%}

      {%- set data = {
          "title": "EFS Filesystem Encryption",
          "result": "Not approved",
          "message": "Filesystem is not encrypted"
      } -%}

    {%- endif -%}
    {{ data | json }}
  EOT
}
