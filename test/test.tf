terraform {
  required_providers {
    turbot = {
      source = "turbot/turbot"
    }
  }
}

provider "turbot" {
  profile = "shaktiman"
}

resource "turbot_policy_pack" "main" {
  title       = "Enforce Key Rotation on AWS KMS Keys"
  description = "Ensuring that keys are rotated minimizes the risk of key compromise and limits the potential impact of a security breach."
  akas        = ["aws_kms_enforce_rotation_is_enabled_for_keys"]
}

resource "turbot_policy_setting" "aws_kms_key_rotation_enabled" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-kms#/policy/types/keyRotation"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}
