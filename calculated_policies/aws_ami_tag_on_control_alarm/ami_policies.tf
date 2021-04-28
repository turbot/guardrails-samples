# AWS > EC2 > AMI > Tags > Template
# Note that if there are no existing tags on the AMI AND itm is within the 14 day window,
# this policy will not evaluate correctly. 
# Note that AWS > EC2 > AMI > Age control state change will trigger a recalculation of the
# tagging policy.
resource "turbot_policy_setting" "ami_tagging" {
  resource      = turbot_smart_folder.aws_ami_tag.id
  type        = "tmod:@turbot/aws-ec2#/policy/types/amiTagsTemplate"
  template_input = <<EOF
- |
  {
    ami {
      turbot {
        id
      }
    }
  }
- |
  {
    controls(filter: "controlType:tmod:@turbot/aws-ec2#/control/types/amiActive resourceId:{{$.ami.turbot.id}}") {
      items {
        state
      }
    }
  }
  EOF
  template      = <<EOF
{%- if $.controls.items[0].state == "alarm" %}
- termination: "true"
{%- else -%}
[]
{%- endif -%}
  EOF
}


# AWS > EC2 > AMI > Tags
resource "turbot_policy_setting" "aws_ec2_ami_tags" {
  resource = turbot_smart_folder.aws_ami_tag.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/amiTags"
  value    = "Check: Tags are correct"
}

# AWS > EC2 > AMI > Active > Age
resource "turbot_policy_setting" "aws_ec2_ami_active_age" {
  resource = turbot_smart_folder.aws_ami_tag.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/amiActiveAge"
  value    = "Force inactive if age > 14 days"
}

# AWS > EC2 > AMI > Active
resource "turbot_policy_setting" "aws_ec2_ami_active" {
  resource = turbot_smart_folder.aws_ami_tag.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/amiActive"
  value    = "Check: Active"
}