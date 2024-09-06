# GCP > Network > Subnetwork > Flow Log
resource "turbot_policy_setting" "gcp_network_subnetwork_flow_log" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-network#/policy/types/subnetworkFlowLog"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}
