provider azurerm {
  version = "=2.0.0"
  features {}
  subscription_id = var.azure_subscription_id
  client_id       = var.azure_client_id
  environment     = "public"
  tenant_id       = var.azure_tenant_id
  client_secret   = var.azure_client_secret
}

# Create the Azure > Subscription resource in Turbot
resource "turbot_resource" "subscription_resource" {
  parent = var.parent_resource
  type   = "tmod:@turbot/azure#/resource/types/subscription"
  metadata = jsonencode({
    "azure" : {
      "subscriptionId" : "${var.azure_subscription_id}",
      "tenantId" : "${data.azurerm_subscription.subscription_to_import.tenant_id}"
    }
  })
  data = jsonencode({
    "subscriptionId" : "${var.azure_subscription_id}"
  })
}

# Set the credentials for the subscription via Turbot policies
# Azure > Environment
resource "turbot_policy_setting" "environment" {
  resource = turbot_resource.subscription_resource.id
  type     = "tmod:@turbot/azure#/policy/types/environment"
  value    = var.azure_environment_type
}
# Azure > Client Key
resource "turbot_policy_setting" "clientKey" {
  resource = turbot_resource.subscription_resource.id
  type     = "tmod:@turbot/azure#/policy/types/clientKey"
  value    = var.azure_client_secret
}
# Azure > Client ID
resource "turbot_policy_setting" "clientId" {
  resource = turbot_resource.subscription_resource.id
  type     = "tmod:@turbot/azure#/policy/types/clientId"
  value    = var.azure_client_id
}
# Azure > Tenant ID
resource "turbot_policy_setting" "tenantId" {
  resource = turbot_resource.subscription_resource.id
  type     = "tmod:@turbot/azure#/policy/types/tenantId"
  value    = data.azurerm_subscription.subscription_to_import.tenant_id
}
