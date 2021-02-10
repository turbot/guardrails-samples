provider azurerm {
  version = "=2.0.0"
  features {}
  management_group_id = var.azure_management_group_id
  client_id           = var.azure_client_id
  environment         = "public"
  tenant_id           = var.azure_tenant_id
  client_secret       = var.azure_client_secret
}

# Create the Azure > Management Group resource in Turbot
resource "turbot_resource" "management_group_resource" {
  parent = var.parent_resource
  type   = "tmod:@turbot/azure#/resource/types/managementGroup"
  akas   = ["azure:///tenants/${var.azure_tenant_id}/microsoft.management/managementgroups/${var.azure_management_group_id}"]
  metadata = jsonencode({
    "azure" : {
      "tenantId" : "${var.azure_tenant_id}"
      "managementGroupId" : "${var.azure_management_group_id}"
    }
  })
  data = jsonencode({
    "id" : "/providers/Microsoft.Management/managementGroups/${var.azure_management_group_id}"
    "name" : "${var.azure_management_group_id}",
  })
}

# Set the credentials for the Management Group via Turbot policies

resource "turbot_policy_setting" "environment" {
  resource = turbot_resource.management_group_resource.id
  type     = "tmod:@turbot/azure#/policy/types/environment"
  value    = var.azure_environment_type
}

resource "turbot_policy_setting" "clientKey" {
  resource = turbot_resource.management_group_resource.id
  type     = "tmod:@turbot/azure#/policy/types/clientKey"
  value    = var.azure_client_secret
}

resource "turbot_policy_setting" "clientId" {
  resource = turbot_resource.management_group_resource.id
  type     = "tmod:@turbot/azure#/policy/types/clientId"
  value    = var.azure_client_id
}

resource "turbot_policy_setting" "tenantId" {
  resource = turbot_resource.management_group_resource.id
  type     = "tmod:@turbot/azure#/policy/types/tenantId"
  value    = var.azure_tenant_id
}
