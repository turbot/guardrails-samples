# Smart Folder Definition
resource "turbot_smart_folder" "aws_b3_bucket_approved_usage_approved_acl_cross_account_access" {
  title       = var.smart_folder_title
  description = var.smart_folder_description
  parent      = var.smart_folder_parent_resource
}

# AWS > S3 > Bucket > Approved
resource "turbot_policy_setting" "aws_b3_bucket_approved_approved_acl_cross_account_access" {
  resource = turbot_smart_folder.aws_b3_bucket_approved_usage_approved_acl_cross_account_access.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketApproved"
  value    = "Check: Approved"
}

# AWS > S3 > Bucket > Approved > Usage
resource "turbot_policy_setting" "aws_b3_bucket_approved_usage_approved_acl_cross_account_access" {
  resource       = turbot_smart_folder.aws_b3_bucket_approved_usage_approved_acl_cross_account_access.id
  type           = "tmod:@turbot/aws-s3#/policy/types/bucketApprovedUsage"
  template_input = <<EOT
  {
    resource {
      onwerId: get(path:"Acl.Owner.ID")
      aclGrants: get(path:"Acl.Grants")
    }
  }
  EOT
  template       = <<EOT
  {#- Whitelist of accounts that are approved for access through ACL in Canonical user ID form -#}
  {#- Read more about Canonical user IDs: https://docs.aws.amazon.com/general/latest/gr/acct-identifiers.html -#}
  {%- set approvedAccounts = ["${join("\",\n      \"", var.approved_accounts)}"] -%}
  {%- set hasUnapprovedAccount = false -%}

  {%- for aclGrant in $.resource.aclGrants -%}
    {%- if aclGrant.Grantee.Type == "CanonicalUser" and aclGrant.Grantee.ID != $.resource.onwerId and aclGrant.Grantee.ID not in approvedAccounts -%}
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
resource "turbot_smart_folder_attachment" "aws_b3_bucket_approved_usage_approved_acl_cross_account_access" {
  resource     = var.target_resource
  smart_folder = turbot_smart_folder.aws_b3_bucket_approved_usage_approved_acl_cross_account_access.id
}
