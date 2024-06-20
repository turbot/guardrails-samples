terraform {
  required_providers {
    turbot = {
      source = "turbot/turbot"
    }
  }
}

provider "turbot" {
}

# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Enforce Enable RBAC for Azure AKS Managed Clusters"
  description = "Ensure that only authorized users and applications can perform actions within clusters."
  parent      = "tmod:@turbot/turbot#/"
}

# Azure > AKS > Enabled
resource "turbot_policy_setting" "azure_aks_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/azure-aks#/policy/types/aksEnabled"
  value    = "Enabled"
}
