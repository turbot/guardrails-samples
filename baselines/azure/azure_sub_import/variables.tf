variable "azure_subscription_id" {
    description     = "Enter the Azure Subscription ID that you wish to import: "
    type            = string
}

variable "parent_resource" {
    description     = "Enter the Turbot Resource ID for the folder into which to import the subscription:"
    type            = string
}

variable "azure_app_password" {
    description     = "Enter an Azure AD app password:"
    type            = string
}

variable "azure_app_password_expiration" {
    description     = "Enter an expiration date for the Azure AD app password:"
    type            = string
}

variable "azure_app_name" {
    description     = "Enter the Azure AD app name:"
    type            = string
}

variable "azure_environment_type" {
    description     = "Enter the Azure subscription environment type ('Global Cloud' or 'US Government'):"
    type            = string
}