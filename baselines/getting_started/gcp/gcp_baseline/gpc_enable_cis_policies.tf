# Enabled CIS Checks and setting the default attestation to 1 year

# GCP > CIS v1
# https://turbot.com/v5/mods/turbot/gcp-cisv1/inspect#/policy/types/cis
resource "turbot_policy_setting" "enable_cis_checks" {
  resource = turbot_smart_folder.gcp_baseline.id
  type     = "tmod:@turbot/gcp-cisv1#/policy/types/cis"
  value    = "Check: Level 1 & Level 2 (Scored)"
}

# GCP > CIS v1 > Maximum Attestation Duration
# https://turbot.com/v5/mods/turbot/gcp-cisv1/inspect#/policy/types/attestation
resource "turbot_policy_setting" "gcp_cis_max_attestation_period" {
  resource = turbot_smart_folder.gcp_baseline.id
  type     = "tmod:@turbot/gcp-cisv1#/policy/types/attestation"
  value    = "1 year"
}
