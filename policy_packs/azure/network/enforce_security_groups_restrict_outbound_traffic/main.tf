resource "turbot_policy_pack" "main" {
  title       = "Azure Network Enforce Security Groups Restrict Outbound Traffic"
  description = "Enforce that Azure Network Security Groups restrict outbound traffic to all ports."
  akas        = ["azure_network_enforce_security_groups_restrict_outbound_traffic"]
}
