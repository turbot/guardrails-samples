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
  title       = "Detect MFA is Enabled for AWS IAM Root Accounts"
  description = "Prevent potential security breaches and enhance overall account security by requiring a second form of verification."
  parent      = "tmod:@turbot/turbot#/"
}

# AWS > IAM > Enabled
resource "turbot_policy_setting" "aws_iam_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-iam#/policy/types/iamEnabled"
  value    = "Enabled"
}
