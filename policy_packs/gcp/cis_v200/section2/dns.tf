# GCP > DNS > DNS Policy > Logging
resource "turbot_policy_setting" "gcp_dns_dns_policy_logging" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-dns#/policy/types/dnsPolicyLogging"
  note     = "GCP CIS v2.0.0 - Control: 2.12"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}
