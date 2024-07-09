variable "azure_subscription_id" {
  description = "Enter the Azure Subscription ID that you wish to import: "
  type        = string
}

variable "parent_resource" {
  description = "Enter the Turbot Resource ID for the folder into which to import the subscription:"
  type        = string
}

variable "azure_environment_type" {
  description = "Enter the Azure subscription environment type ('Global Cloud' or 'US Government'):"
  type        = string
}

variable "azure_client_id" {
  description = "Enter the Azure Client ID: "
  type        = string
}

variable "azure_tenant_id" {
  description = "Enter the Azure Tenant ID: "
  type        = string
}

variable "azure_client_secret" {
  description = "Enter the Azure Client Secret Key: "
  type        = string
}
