resource "turbot_policy_pack" "main" {
  title       = "Enforce GCP Network Firewall Restrict Unauthorized Egress Access"
  description = "Ensure that firewall restricts unauthorized egress access to prevent data exfiltration and limiting the ability of compromised instances to communicate with unauthorized external networks."
  akas        = ["gcp_network_enforce_firewall_restricts_unauthorized_egress_access"]
}
