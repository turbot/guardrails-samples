# AWS > EC2 > AMI > Active
resource "turbot_policy_setting" "aws_ec2_ami_active" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/amiActive"
  value    = "Check: Active"
  # value    = "Enforce: Delete inactive with 14 days warning"
}

# AWS > EC2 > AMI > Active > Age
resource "turbot_policy_setting" "aws_ec2_ami_active_age" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/amiActiveAge"
  value    = "Force inactive if age > 14 days"
}

# AWS > EC2 > AMI > Tags
resource "turbot_policy_setting" "aws_ec2_ami_tags" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/amiTags"
  value    = "Check: Tags are correct"
  # value    = "Enforce: Set tags"
}

# AWS > EC2 > AMI > Tags > Template
resource "turbot_policy_setting" "aws_ec2_ami_tags_template" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/aws-ec2#/policy/types/amiTagsTemplate"
  template_input = <<-EOT
    -|
      {
        item: region {
          turbot {
            id
          }
        }
      }
    -|
      {
        controls(filter: "controlType:tmod:@turbot/aws-ec2#/control/types/amiActive resourceId:{{ $.item.turbot.id }}") {
          items {
            state
          }
        }
      }
    EOT
  template       = <<-EOT
    {%- if $.controls.items[0].state == "alarm" -%}
      - termination: "true"
    {%- else -%}
      []
    {%- endif -%}
  EOT
}
