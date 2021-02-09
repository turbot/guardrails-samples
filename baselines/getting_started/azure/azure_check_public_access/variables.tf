# Baseline Configuration
variable "enable_application_gateway_approved_policies" {
  type        = bool
  description = "Enable the Application Gateway approved policies for baseline"
  default     = true
}

variable "enable_network_security_group_ingress_rules_approved_policies" {
  type        = bool
  description = "Enable the Azure Network Security Group Ingress approved policies for baseline"
  default     = true
}

variable "enable_network_security_group_ingress_rules_approved_rules_policies" {
  type        = bool
  description = "Enable the Azure Network Security Group Ingress Rule approved policies for baseline"
  default     = true
}

variable "enable_network_public_ip_address_approved_usage_policies" {
  type        = bool
  description = "Enable the Azure Network Public IP Address approved usage policies for baseline"
  default     = true
}

variable "enable_storage_account_public_access_policies" {
  type        = bool
  description = "Enable the Azure Storage Account Public Access policies for baseline"
  default     = true
}

variable "enable_azure_storage_container_public_access_policies" {
  type        = bool
  description = "Enable the Azure Storage Container Public Access policies for baseline"
  default     = true
}

# Optional Common Baseline Configuration

variable "turbot_profile" {
  description = "Enter profile matching your turbot cli credentials."
  default     = "default"
}

variable "smart_folder_name" {
  description = "Smart folder name for the baseline"
  type        = string
  default     = "Azure Check Public Access Policies"
}

variable "smart_folder_description" {
  description = "Enter a description for the smart folder"
  type        = string
  default     = "Defines sets of policies for the Azure Public Access checks"
}

variable "smart_folder_parent_resource" {
  description = "Enter the resource ID or AKA for the parent of the smart folder"
  type        = string
  default     = "tmod:@turbot/turbot#/"
}
