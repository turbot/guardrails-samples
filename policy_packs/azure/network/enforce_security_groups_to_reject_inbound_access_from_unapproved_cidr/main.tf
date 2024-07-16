resource "turbot_policy_pack" "main" {
  title       = "Enforce Azure Network Security Groups to Reject Inbound Access from unapproved CIDRs"
  description = "Ensure that only trusted sources can communicate with your resources, thereby safeguarding sensitive data and applications."
  akas        = ["azure_network_enforce_security_groups_to_reject_inbound_access_from_unapproved_cidr"]
}
