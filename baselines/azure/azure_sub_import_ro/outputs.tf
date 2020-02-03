#### Get the subscription info

data "azurerm_subscription" "subscription_to_import" {
  subscription_id = "${var.azure_subscription_id}"
}

output "subscription_display_name" {
  value           = "${data.azurerm_subscription.subscription_to_import.display_name}"
}

output "tenant_id" {
  value           = "${data.azurerm_subscription.subscription_to_import.tenant_id}"
}