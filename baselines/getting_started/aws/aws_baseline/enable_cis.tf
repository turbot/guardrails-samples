# Enabled CIS Checks and setting the default attestation to 1 year

# AWS > CIS v1
resource "turbot_policy_setting" "enable_cis_checks" {
  resource = turbot_smart_folder.aws_baseline.id
  type     = "tmod:@turbot/aws-cisv1#/policy/types/cis"
  value    = "Check: Level 1 & Level 2 (Scored)"
              # Skip
              # Check: Level 1 (Scored)
              # Check: Level 1 (Scored & Not Scored)
              # Check: Level 1 & Level 2 (Scored)
              # Check: Level 1 & Level 2 (Scored & Not Scored)
}

resource "turbot_policy_setting" "aws_cis_max_attestation_period" {
  resource = turbot_smart_folder.aws_baseline.id
  type     = "tmod:@turbot/aws-cisv1#/policy/types/attestation"
  value    = "1 year"
              # Skip
              # 30 days
              # 60 days
              # 90 days
              # 1 year
              # 2 years
              # 3 years
}
