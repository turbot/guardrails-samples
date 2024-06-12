# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Enforce Enable RBAC for Azure AKS Managed Clusters"
  description = "Delete Azure AKS managed clusters that do not have role-based access control enabled."
  parent      = "tmod:@turbot/turbot#/"
}

# Azure > AKS > Enabled
resource "turbot_policy_setting" "azure_aks_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/azure-aks#/policy/types/aksEnabled"
  value    = "Enabled"
}
