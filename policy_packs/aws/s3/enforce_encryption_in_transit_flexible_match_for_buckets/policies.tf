# AWS > S3 > Bucket > Encryption in Transit
# Uses a calculated policy to flexibly match effective encryption-in-transit
# statements that use Principal variants like {"AWS": "*"} or {"AWS": ["*"]}
# which are functionally identical to "*" in AWS IAM but fail strict comparison.
resource "turbot_policy_setting" "aws_s3_bucket_encryption_in_transit" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/aws-s3#/policy/types/encryptionInTransit"
  template_input = <<-EOT
    {
      bucket {
        Name
        Policy: get(path: "Policy")
        turbot {
          custom {
            aws {
              partition
            }
          }
        }
      }
    }
  EOT
  template       = <<-EOT
    {%- set found = false -%}
    {%- set bucketName = $.bucket.Name -%}
    {%- set partition = $.bucket.turbot.custom.aws.partition -%}
    {%- set expectedBucketArn = "arn:" + partition + ":s3:::" + bucketName -%}
    {%- set expectedObjectArn = expectedBucketArn + "/*" -%}
    {%- if $.bucket.Policy.Statement -%}
      {%- for stmt in $.bucket.Policy.Statement -%}
        {%- if not found -%}
          {%- if stmt.Effect == "Deny"
              and stmt.Action == "s3:*"
              and stmt.Condition.Bool["aws:SecureTransport"] == "false" -%}
            {# Check Principal is effectively "everyone" #}
            {%- set principalOk = false -%}
            {%- if stmt.Principal == "*" -%}
              {%- set principalOk = true -%}
            {%- elif stmt.Principal.AWS == "*" -%}
              {%- set principalOk = true -%}
            {%- elif stmt.Principal.AWS is iterable
                and stmt.Principal.AWS | length == 1
                and stmt.Principal.AWS[0] == "*" -%}
              {%- set principalOk = true -%}
            {%- endif -%}
            {%- if principalOk -%}
              {# Check Resource covers both bucket and objects #}
              {%- set hasBucket = false -%}
              {%- set hasObjects = false -%}
              {%- if stmt.Resource is iterable and stmt.Resource is not string -%}
                {%- for r in stmt.Resource -%}
                  {%- if r == expectedBucketArn -%}
                    {%- set hasBucket = true -%}
                  {%- endif -%}
                  {%- if r == expectedObjectArn -%}
                    {%- set hasObjects = true -%}
                  {%- endif -%}
                {%- endfor -%}
              {%- endif -%}
              {%- if hasBucket and hasObjects -%}
                {%- set found = true -%}
              {%- endif -%}
            {%- endif -%}
          {%- endif -%}
        {%- endif -%}
      {%- endfor -%}
    {%- endif -%}
    {%- if found -%}
    "Skip"
    {%- else -%}
    "${var.enforcement_level}"
    {%- endif -%}
  EOT
}
