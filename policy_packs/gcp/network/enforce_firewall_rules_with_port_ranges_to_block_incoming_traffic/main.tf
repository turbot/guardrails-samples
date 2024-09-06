resource "turbot_policy_pack" "main" {
  title       = "Enforce GCP VPC Network Firewall Rules with Port Ranges to Block Incoming Traffic"
  description = "Ensure that only necessary and specific ports are open for inbound traffic, minimizing the risk of unauthorized access and potential attacks."
  akas        = ["gcp_network_enforce_firewall_rules_with_port_ranges_to_block_incoming_traffic"]
}
