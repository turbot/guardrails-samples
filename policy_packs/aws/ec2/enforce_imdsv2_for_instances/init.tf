terraform {
  required_providers {
    turbot = {
      source = "turbot/turbot"
    }
  }
}

provider "turbot" {
}

resource "turbot_smart_folder" "pack" {
  title       = "Enforce IMDSv2 on AWS EC2 Instances"
  description = "Mitigate the risk of unauthorized metadata exposure through vulnerabilities like Server-Side Request Forgery (SSRF)."
  parent      = "tmod:@turbot/turbot#/"
}

# AWS > EC2 > Enabled
resource "turbot_policy_setting" "aws_ec2_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/ec2Enabled"
  value    = "Enabled"
}
