# AWS > CIS v3.0
resource "turbot_policy_setting" "aws_cis_v300" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-cisv3-0#/policy/types/cis"
  value    = "Check: All CIS Benchmarks except attestations"
  # value    = "Check: All CIS Benchmarks"
}

# AWS > CIS v3.0 > Maximum Attestation Duration
# resource "turbot_policy_setting" "aws_cis_v300_attestation" {
#   resource = turbot_smart_folder.main.id
#   type     = "tmod:@turbot/aws-cisv3-0#/policy/types/attestation"
#   # value    = "90 days"
#   value    = "1 year"
#   # value    = "2 years"
# }
