resource "turbot_policy_pack" "main" {
  title       = "Enforce Azure Network Security Groups to Reject All Ingress, RDP and SSH Inbound Access"
  description = "Ensure remote administrative access is blocked unless explicitly allowed, reducing the risk of malicious attacks and enhancing overall security posture."
  akas        = ["azure_network_enforce_security_groups_to_reject_all_rdp_ssh_inbound_access"]
}
