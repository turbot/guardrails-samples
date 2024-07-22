# AWS > S3 > Bucket > Approved
resource "turbot_policy_setting" "aws_s3_bucket_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new and empty"
}

# AWS > S3 > Bucket > Approved > Custom
resource "turbot_policy_setting" "aws_s3_bucket_approved_custom" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/aws-s3#/policy/types/bucketApprovedCustom"
  template_input = <<-EOT
    {
      resource {
        name: get(path: "Name")
      }
    }
  EOT
  template       = <<-EOT
    {#- Defined at http://docs.aws.amazon.com/AmazonS3/latest/dev/BucketRestrictions.html -#}
    {#- Implemented based on http://stackoverflow.com/a/106223 -#}
    {%- set dnsNameRegExp = r/^(([a-z0-9]|[a-z0-9][a-z0-9-]*[a-z0-9])\\.)*([a-z0-9]|[a-z0-9][a-z0-9-]*[a-z0-9])$/g -%}

    {%- if $.resource.name == null -%}

      {%- set data = {
          "title": "Bucket",
          "result": "Skip",
          "message": "Bucket data is not available yet"
      } -%}

    {%- elif $.resource.name | length >= 3 and $.resource.name | length <= 63 and dnsNameRegExp.test($.resource.name) -%}

      {%- set data = {
          "title": "DNS Compliance",
          "result": "Approved",
          "message": "Bucket name is DNS compliant"
      } -%}

    {%- else -%}

      {%- set data = {
          "title": "DNS Compliance",
          "result": "Not approved",
          "message": "Bucket name is not DNS compliant"
      } -%}

    {%- endif -%}

    {{ data | json }}
  EOT
}
