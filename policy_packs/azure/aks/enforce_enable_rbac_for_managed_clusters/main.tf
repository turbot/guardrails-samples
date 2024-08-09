resource "turbot_policy_pack" "main" {
  title       = "Enforce RBAC for Azure AKS Managed Clusters"
  description = "Ensure that only authorized users and applications can perform actions within clusters."
  akas        = ["azure_aks_enforce_enable_rbac_for_managed_clusters"]
}
