# Baseline Configuration

variable "provider_status" {
  description = "Choose the subset of providers that should be configured. Possible values for each service are: [\"Skip\", \"Check: Not Registered\", \"Check: Registered\", \"Enforce: Not Registered\", \"Enforce: Registered\"]"
  type        = map
}

variable "provider_registration_map" {
  description = "A map of all the registered policies currently exposed by Turbot"
  type        = map
}

variable "enabled_policy_map" {
  description = "Enter the list of services that you would like to Enable"
  type        = map
}

# Optional Common Baseline Configuration

variable "turbot_profile" {
  description = "Enter profile matching your turbot cli credentials."
  default     = "default"
}

variable "smart_folder_name" {
  description = "Smart folder name for the baseline"
  type        = string
  default     = "Azure Baseline Policies"
}

variable "smart_folder_description" {
  description = "Enter a description for the smart folder"
  type        = string
  default     = "Defines sets of policies for the Azure baseline"
}

variable "smart_folder_parent_resource" {
  description = "Enter the resource ID or AKA for the parent of the smart folder"
  type        = string
  default     = "tmod:@turbot/turbot#/"
}
