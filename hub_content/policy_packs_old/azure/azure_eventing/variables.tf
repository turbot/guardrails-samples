variable "target_resource" {
  description = "Enter the resource ID or AKA for the resource to apply the calculated policy"
  type        = string
}

variable "enable_poller" {
  description = <<EOF
  Setting to `true` will configure that the Event Poller to handle event routing.
  Setting to `false` will configure that the Event Handler to handle event routing.
  EOF
  type        = bool
}

variable "smart_folder_title" {
  description = "Enter a title for the smart folder"
  type        = string
  default     = "Azure - Event Router"
}

variable "smart_folder_description" {
  description = "Enter a description for the smart folder"
  type        = string
  default     = "Contains the policy settings to configure the Azure Event Router"
}

# Defaults to the Turbot Resource level using the AKA which identifies the Turbot level.
variable "smart_folder_parent_resource" {
  description = "Enter the resource ID or AKA for the parent of the smart folder"
  type        = string
  default     = "tmod:@turbot/turbot#/"
}
