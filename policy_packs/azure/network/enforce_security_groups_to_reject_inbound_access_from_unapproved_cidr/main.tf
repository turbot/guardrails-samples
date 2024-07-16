resource "turbot_policy_pack" "main" {
  title       = "Enforce Azure Network Security Groups to Reject Inbound Access from unapproved CIDR"
  description = "Ensure that network traffic is only allowed from trusted IP ranges."
  akas        = ["azure_network_enforce_security_groups_to_reject_inbound_access_from_unapproved_cidr"]
}
