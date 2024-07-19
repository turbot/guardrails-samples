# GCP > Network > Firewall > Logging
resource "turbot_policy_setting" "gcp_network_firewall_logging_enabled" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-network#/policy/types/firewallLogging"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}
