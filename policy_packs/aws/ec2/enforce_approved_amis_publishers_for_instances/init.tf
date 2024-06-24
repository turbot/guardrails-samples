terraform {
  required_providers {
    turbot = {
      source = "turbot/turbot"
    }
  }
}

provider "turbot" {
}

# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Enforce AWS EC2 Instances to Use Approved AMIs and/or Publisher Accounts"
  description = "Ensure that only trusted, validated images are used, reducing the risk of security vulnerabilities and ensuring compliance with organizational policies and security standards."
  parent      = "tmod:@turbot/turbot#/"
}

# AWS > EC2 > Enabled
resource "turbot_policy_setting" "aws_ec2_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/ec2Enabled"
  value    = "Enabled"
}
