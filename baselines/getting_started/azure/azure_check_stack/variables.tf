# Baseline configuration

variable "azure_subscription_monitor_stack_policies" {
  type        = bool
  description = "Azure subscription monitor stack policies for baseline"
  default     = true
}

variable "azure_subscription_monitor_stack_tfversion_policies" {
  type        = bool
  description = "Azure subscription monitor stack TFversion policies for baseline"
  default     = true
}

variable "azure_subscription_monitor_stack_source_policies" {
  type        = bool
  description = "Azure subscription monitor stack source policies for baseline"
  default     = true
}

# Smartfolder configuration

variable "turbot_profile" {
  description = "Enter profile matching your turbot cli credentials."
}

variable "smart_folder_name" {
  description = "Smart folder name for the baseline"
  type        = string
  default     = "Azure Stack Example Policies"
}

variable "smart_folder_description" {
  description = "Enter a description for the smart folder"
  type        = string
  default     = "Defines sets of policies for the Azure Stack baseline"
}

variable "smart_folder_parent_resource" {
  description = "Enter the resource ID or AKA for the parent of the smart folder"
  type        = string
  default     = "tmod:@turbot/turbot#/"
} 