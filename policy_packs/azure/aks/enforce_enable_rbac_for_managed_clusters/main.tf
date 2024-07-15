resource "turbot_policy_pack" "main" {
  title       = "Enforce Enable RBAC for Azure AKS Managed Clusters"
  description = "Ensure that only authorized users and applications can perform actions within clusters."
  parent      = "tmod:@turbot/turbot#/"
}
