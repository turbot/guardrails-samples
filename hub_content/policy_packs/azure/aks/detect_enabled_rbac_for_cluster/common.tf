# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Detect enabled RBAC AKS clusters"
  description = "Detect AKS clusters that are enabled"
  parent      = "tmod:@turbot/turbot#/"
}

# Azure > AKS > Enabled
resource "turbot_policy_setting" "azure_aks_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/azure-aks#/policy/types/aksEnabled"
  value    = "Enabled"
}
