provider azurerm {
  version = "=2.0.0"
  features {}
  active_directory_id = var.azure_active_directory_id
  client_id           = var.azure_client_id
  environment         = "public"
  tenant_id           = var.azure_tenant_id
  client_secret       = var.azure_client_secret
}

# Create the Azure > Active Directory resource in Turbot
resource "turbot_resource" "active_directory_resource" {
  parent = var.parent_resource
  type   = "tmod:@turbot/azure-activedirectory#/resource/types/directory"
  akas   = ["azure:///directory/${var.azure_active_directory_id}"]
  metadata = jsonencode({
    "azure" : {
      "tenantId" : "${var.azure_tenant_id}"
    }
  })
  data = jsonencode({
    "id" : "${var.azure_active_directory_id}"
    "tenantId": "${var.azure_tenant_id}"
  })
}

# Set the credentials for the Active Directory via Turbot policies

resource "turbot_policy_setting" "environment" {
  resource = turbot_resource.active_directory_resource.id
  type     = "tmod:@turbot/azure#/policy/types/environment"
  value    = var.azure_environment_type
}

resource "turbot_policy_setting" "clientKey" {
  resource = turbot_resource.active_directory_resource.id
  type     = "tmod:@turbot/azure#/policy/types/clientKey"
  value    = var.azure_client_secret
}

resource "turbot_policy_setting" "clientId" {
  resource = turbot_resource.active_directory_resource.id
  type     = "tmod:@turbot/azure#/policy/types/clientId"
  value    = var.azure_client_id
}

resource "turbot_policy_setting" "tenantId" {
  resource = turbot_resource.active_directory_resource.id
  type     = "tmod:@turbot/azure#/policy/types/tenantId"
  value    = var.azure_tenant_id
}
