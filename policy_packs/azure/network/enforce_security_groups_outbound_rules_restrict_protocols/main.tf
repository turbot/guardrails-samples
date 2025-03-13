resource "turbot_policy_pack" "main" {
  title       = "Azure Network Enforce Security Groups Outbound Rules Restrict Protocols"
  description = "Enforce that Azure Network Security Group outbound rules do not allow all protocols."
  akas        = ["azure_network_enforce_security_groups_outbound_rules_restrict_protocols"]
}
