# Smart Folder Definition
resource "turbot_smart_folder" "aws_s3_bucket_encryption_at_rest_customer_managed_key_tags_match" {
  title       = var.smart_folder_title
  description = var.smart_folder_description
  parent      = var.smart_folder_parent_resource
}

# AWS > S3 > Bucket > Encryption at Rest
resource "turbot_policy_setting" "aws_s3_bucket_encryption_at_rest_tags_match" {
  resource = turbot_smart_folder.aws_s3_bucket_encryption_at_rest_customer_managed_key_tags_match.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketEncryptionAtRest"
  value    = "Check: Encryption at Rest > Customer Managed Key"
}

# AWS > S3 > Bucket > Encryption at Rest > Customer Managed Key
resource "turbot_policy_setting" "aws_s3_bucket_encryption_at_rest_customer_managed_key_tags_match" {
  resource = turbot_smart_folder.aws_s3_bucket_encryption_at_rest_customer_managed_key_tags_match.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketEncryptionAtRestCustomerManagedKey"
  # GraphQL to pull function metadata
  template_input = <<EOT
  - |
    {
      item: resource {
        encryptionRules: get(path: "Encryption.ServerSideEncryptionConfiguration.Rules")
      }
    }
  - |
    {%- set encryptionRule = {} -%}
    {%- for rule in $.item.encryptionRules -%}
      {%- if rule.ApplyServerSideEncryptionByDefault -%}
        {%- set encryptionRule = rule -%}
      {%- endif -%}
    {%- endfor -%}
    {
      bucket: resource {
        tags
      }
      {%- if encryptionRule.ApplyServerSideEncryptionByDefault.KMSMasterKeyID -%}
      kmsKey: resource (id: "{{ encryptionRule.ApplyServerSideEncryptionByDefault.KMSMasterKeyID }}") {
        tags
      }
      {%- endif -%}
    }
  EOT
  # Nunjucks Template Nunjucks Comments are formatted: {# comment #}
  template = <<EOT
  {%- if $.kmsKey.tags['${var.cross_resource_tag_key}']
        and $.bucket.tags['${var.cross_resource_tag_key}']
        and $.kmsKey.tags['${var.cross_resource_tag_key}'] == $.bucket.tags['${var.cross_resource_tag_key}'] -%}
    Approved
  {%- else -%}
    Not approved
  {%- endif -%}
  EOT
}

# Attach Smart Folder
resource "turbot_smart_folder_attachment" "aws_s3_bucket_encryption_at_rest_customer_managed_key_tags_match" {
  resource     = var.target_resource
  smart_folder = turbot_smart_folder.aws_s3_bucket_encryption_at_rest_customer_managed_key_tags_match.id
}
