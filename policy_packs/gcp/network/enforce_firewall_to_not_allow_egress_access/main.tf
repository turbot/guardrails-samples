resource "turbot_policy_pack" "main" {
  title       = "Enforce GCP Network Firewall to Block All Egress Access"
  description = "Ensure that no outbound traffic is permitted, preventing data exfiltration and unauthorized communication with external systems."
  akas        = ["gcp_network_enforce_firewall_to_not_allow_egress_access"]
}
