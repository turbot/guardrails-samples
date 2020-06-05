# Smart Folder Definition
resource "turbot_smart_folder" "aws_b3_bucket_approved_usage_approved_cross_account_replication" {
  title       = var.smart_folder_title
  description = var.smart_folder_description
  parent      = var.smart_folder_parent_resource
}

# AWS > S3 > Bucket > Approved
resource "turbot_policy_setting" "aws_b3_bucket_approved_approved_cross_account_replication" {
  resource = turbot_smart_folder.aws_b3_bucket_approved_usage_approved_cross_account_replication.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketApproved"
  value    = "Check: Approved"
}

# AWS > S3 > Bucket > Approved > Usage
resource "turbot_policy_setting" "aws_b3_bucket_approved_usage_approved_cross_account_replication" {
  resource       = turbot_smart_folder.aws_b3_bucket_approved_usage_approved_cross_account_replication.id
  type           = "tmod:@turbot/aws-s3#/policy/types/bucketApprovedUsage"
  template_input = <<EOT
  {
    resource {
      replicationRules: get(path:"Replication.Rules")
    }
  }
  EOT
  template       = <<EOT
  {#- Whitelist of accounts that are approved for replication -#}
  {%- set approvedAccounts = ["${join("\",\n      \"", var.approved_accounts)}"] -%}
  {%- set hasUnapprovedAccount = false -%}

  {%- for rule in $.resource.replicationRules -%}
    {%- if rule.Status == "Enabled" and rule.Destination.Account not in approvedAccounts -%}
      {%- set hasUnapprovedAccount = true -%}
    {%- endif -%}
  {%- endfor -%}

  {%- if not hasUnapprovedAccount -%}
    "Approved"
  {%- else -%}
    "Not approved"
  {%- endif -%}
  EOT
}

# Attach Smart Folder
resource "turbot_smart_folder_attachment" "aws_b3_bucket_approved_usage_approved_cross_account_replication" {
  resource     = var.target_resource
  smart_folder = turbot_smart_folder.aws_b3_bucket_approved_usage_approved_cross_account_replication.id
}
