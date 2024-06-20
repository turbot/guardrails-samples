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
  title       = "Enforce AWS DMS Replication Instances to Restrict Public Access"
  description = "Mitigate the risk of unauthorized access, potential data breaches, and ensures compliance with security best practices and regulatory requirements."
  parent      = "tmod:@turbot/turbot#/"
}

# AWS > DMS > Enabled
resource "turbot_policy_setting" "aws_dms_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-dms#/policy/types/dmsEnabled"
  value    = "Enabled"
}
