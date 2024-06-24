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
  title       = "Enforce Encryption at Rest is Enabled for AWS EFS File Systems"
  description = "Ensure that all data stored within file systems is encrypted, protecting it from unauthorized access and potential data breaches."
  parent      = "tmod:@turbot/turbot#/"
}

# AWS > EFS > Enabled
resource "turbot_policy_setting" "aws_efs_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-efs#/policy/types/efsEnabled"
  value    = "Enabled"
}
