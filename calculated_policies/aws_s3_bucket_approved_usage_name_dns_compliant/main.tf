resource "turbot_smart_folder" "aws_s3_bucket_approved_usage_name_dns_compliant" {
  title          = var.smart_folder_title
  description    = "Restrict AWS S3 Bucket Name to DNS Compliant"
  parent         = "tmod:@turbot/turbot#/"
}

resource "turbot_smart_folder_attachment" "aws_s3_bucket_approved_usage_name_dns_compliant" {
  resource     = var.target_resource
  smart_folder = turbot_smart_folder.aws_s3_bucket_approved_usage_name_dns_compliant.id
}

# AWS > S3 > Bucket > Approved
resource "turbot_policy_setting" "aws_s3_bucket_approved_local_ami" {
  resource = turbot_smart_folder.aws_s3_bucket_approved_usage_name_dns_compliant.id
  type = "tmod:@turbot/aws-s3#/policy/types/bucketApproved"
  value = "Check: Approved"
}

# AWS > S3 > Bucket > Approved > Usage
resource "turbot_policy_setting" "aws_s3_bucket_approved_usage_name_dns_compliant" {
  resource       = turbot_smart_folder.aws_s3_bucket_approved_usage_name_dns_compliant.id
  type           = "tmod:@turbot/aws-s3#/policy/types/bucketApprovedUsage"
  # GraphQL to pull function metadata
  template_input = <<EOT
  {
    resource {
      name: get(path: "Name")
    }
  }
  EOT
  # Nunjucks Template Nunjucks Comments are formatted: {# comment #}
  template       = <<EOT
  {# Defined at http://docs.aws.amazon.com/AmazonS3/latest/dev/BucketRestrictions.html #}
  {# Implemented based on http://stackoverflow.com/a/106223 #}
  {% set dnsNameRegExp = r/^(([a-z0-9]|[a-z0-9][a-z0-9-]*[a-z0-9])\\.)*([a-z0-9]|[a-z0-9][a-z0-9-]*[a-z0-9])$/g %}
  {% if $.resource.name | length >= 3 and
        $.resource.name | length <= 63 and
        dnsNameRegExp.test($.resource.name) %}
    Approved
  {% else %}
    Not approved
  {% endif %}
  EOT
}
