locals {
  yaml_string = <<-EOT
    Cost_Center:
      incorrectKeys:
        - /.*cost.*cent.*/gi
      replacementValue: undefined
    EOT
}

# Turbot > File
resource "turbot_file" "aws_tag_transform_rules" {
  parent  = "tmod:@turbot/turbot#/"
  title   = "AWS Tag Transform Rules"
  akas    = ["aws_tag_transform_rules"]
  content = jsonencode(yamldecode(local.yaml_string))
}

# AWS > S3 > Bucket > Tags
resource "turbot_policy_setting" "aws_s3_bucket_tags" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketTags"
  value    = "Check: Tags are correct"
  # value    = "Enforce: Set tags"
}

# AWS > S3 > Bucket > Tags > Template
resource "turbot_policy_setting" "aws_s3_bucket_tags_template" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/aws-s3#/policy/types/bucketTagsTemplate"
  template_input = <<-EOT
    {
      rules: resource(id:"aws_tag_transform_rules") {
        data
      }
      resource {
        turbot {
          tags
        }
      }
    }
    EOT
  template       = <<-EOT
    {%- set tags_map = $.resource.turbot.tags -%}
    {%- set rules = $.rules.data -%}

    {% for key,value in transformMap(tags_map, rules) -%}
    - "{{key}}": "{{value}}"
    {% endfor -%}

    EOT
}
