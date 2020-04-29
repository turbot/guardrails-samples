provider azuread {
  version = "~> 0.7"
}

# Create the Azure AD App and Service Principal for Turbot to use, and set a password
resource "azuread_application" "turbot_azure_ad_app" {
  name = var.azure_app_name
}

resource "azuread_service_principal" "turbot_azure_ad_app_sp" {
  application_id = azuread_application.turbot_azure_ad_app.application_id
}

resource "azuread_service_principal_password" "turbot_azure_ad_app_sp_password" {
  service_principal_id = azuread_service_principal.turbot_azure_ad_app_sp.id
  value                = var.azure_app_password
  end_date             = var.azure_app_password_expiration
}

provider azurerm {
  version = "=2.0.0"
  features {}
  subscription_id = var.azure_subscription_id
}

# Grant "owner" to the service principal for turbot
resource "azurerm_role_assignment" "turbot_azuread_role_assignment" {
  scope                = "/subscriptions/${var.azure_subscription_id}"
  role_definition_name = "Owner"
  principal_id         = azuread_service_principal.turbot_azure_ad_app_sp.id
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

resource "turbot_policy_setting" "clientKey" {
  resource = turbot_resource.subscription_resource.id
  type     = "tmod:@turbot/azure#/policy/types/clientKey"
  value    = var.azure_app_password
}

resource "turbot_policy_setting" "clientId" {
  resource = turbot_resource.subscription_resource.id
  type     = "tmod:@turbot/azure#/policy/types/clientId"
  value    = azuread_application.turbot_azure_ad_app.application_id
}

resource "turbot_policy_setting" "tenantId" {
  resource = turbot_resource.subscription_resource.id
  type     = "tmod:@turbot/azure#/policy/types/tenantId"
  value    = data.azurerm_subscription.subscription_to_import.tenant_id
}
