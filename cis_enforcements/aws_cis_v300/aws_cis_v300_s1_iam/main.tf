terraform {
  required_providers {
    turbot = {
      source = "turbot/turbot"
    }
  }
}

provider "turbot" {
  profile = var.turbot_profile
}

variable "turbot_profile" {
  description = "Enter profile matching your turbot cli credentials."
}

# AWS CIS v3.0.0 - Section 1 - IAM - Smart Folder
resource "turbot_smart_folder" "aws_cis_v300_s1_iam" {
  parent      = "tmod:@turbot/turbot#/"
  title       = "AWS CIS v3.0.0 - Section 1 - IAM"
  description = "This section contains recommendations for configuring identity and access management related options."
}

# AWS > IAM > Enabled
resource "turbot_policy_setting" "aws_iam_enabled" {
  resource = turbot_smart_folder.aws_cis_v300_s1_iam.id
  type     = "tmod:@turbot/aws-iam#/policy/types/iamEnabled"
  value    = "Enabled"
}
