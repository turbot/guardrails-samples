# Enabled CIS Checks and setting the default attestation to 1 year

# Azure > CIS v1
# https://turbot.com/v5/mods/turbot/azure-cisv1/inspect#/policy/types/cis
resource "turbot_policy_setting" "enable_cis_checks" {
  resource    = turbot_smart_folder.azure_baseline.id
  type        = "tmod:@turbot/azure-cisv1#/policy/types/cis"
  value       = "Check: Level 1 & Level 2 (Scored)"
              # Skip
              # Check: Level 1 (Scored)
              # Check: Level 1 (Scored & Not Scored)
              # Check: Level 1 & Level 2 (Scored)
              # Check: Level 1 & Level 2 (Scored & Not Scored)
}

# Azure > CIS v1 > Maximum Attestation Duration
# https://turbot.com/v5/mods/turbot/azure-cisv1/inspect#/policy/types/attestation
resource "turbot_policy_setting" "azure_cis_max_attestation_period" {
  resource = turbot_smart_folder.azure_baseline.id
  type     = "tmod:@turbot/azure-cisv1#/policy/types/attestation"
  value    = "1 year"
              # Skip
              # 30 days
              # 60 days
              # 90 days
              # 1 year
              # 2 years
              # 3 years
}
