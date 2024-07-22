# Azure > CIS v2.0
resource "turbot_policy_setting" "azure_cis_v200" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-cisv2-0#/policy/types/cis"
  value    = "Check: All CIS Benchmarks except attestations"
  # value    = "Check: All CIS Benchmarks"
}

# Azure > CIS v2.0 > Maximum Attestation Duration
# resource "turbot_policy_setting" "azure_cis_v200_attestation" {
#   resource = turbot_smart_folder.main.id
#   type     = "tmod:@turbot/azure-cisv2-0#/policy/types/attestation"
#   # value    = "90 days"
#   value    = "1 year"
#   # value    = "2 years"
# }
