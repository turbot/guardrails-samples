terraform {
  required_providers {
    turbot = {
      source = "turbot/turbot"
    }
  }
}

provider "turbot" {
}

# TODO: What should the resource name, title and description be?
resource "turbot_smart_folder" "pack" {
  title       = "AWS Policy Pack"
  description = "Policy pack containing AWS policy settings."
  parent      = "tmod:@turbot/turbot#/"
}

# AWS > EC2 > Enabled
resource "turbot_policy_setting" "aws_ec2_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/ec2Enabled"
  value    = "Enabled"
}
