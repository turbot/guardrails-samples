# Azure > Resource Group > Stack
resource "turbot_policy_setting" "azure_resource_group_stack" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure#/policy/types/resourceGroupStack"
  note     = "Azure CIS v2.0.0 - Controls: 5.3.1"
  value    = "Check: Configured"
  # value    = "Enforce: Configured"
}

# Azure > Resource Group > Stack > Source
resource "turbot_policy_setting" "azure_resource_group_stack_source" {
  resource       = turbot_smart_folder.main.id
  type           = "tmod:@turbot/azure#/policy/types/resourceGroupStackSource"
  note           = "Azure CIS v2.0.0 - Controls: 5.3.1"
  template_input = <<-EOT
    {
      resourceGroup  {
        metadata
      }
    }
    EOT
  template       = <<-EOT
    |
    provider "azurerm" {
      features {}
    }

    resource "azurerm_log_analytics_workspace" "workspace_5_3_1" {
      name                = "workspace-test"
      location            = {{ $.resourceGroup.metadata.azure.regionName }}
      resource_group_name = {{ $.resourceGroup.metadata.azure.resourceGroupName }}
      sku                 = "PerGB2018"
      retention_in_days   = 30
    }

    resource "azurerm_application_insights" "application_insight_5_3_1" {
      name                = "application_insight_5_3_1_name"
      location            = {{ $.resourceGroup.metadata.azure.regionName }}
      resource_group_name = {{ $.resourceGroup.metadata.azure.resourceGroupName }}
      application_type    = "web"
      workspace_id        = azurerm_log_analytics_workspace.workspace_5_3_1.id
    }
    EOT
}

# Azure > Resource Group > Stack > Terraform Version
resource "turbot_policy_setting" "azure_resource_group_stack_terraform_version" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure#/policy/types/resourceGroupStackTerraformVersion"
  note     = "Azure CIS v2.0.0 - Controls: 5.3.1"
  value    = "0.15.*"
}
