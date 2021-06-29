variable "smart_folder_title" {
  description = "Enter a title for the smart folder"
  type        = string
  default     = "AWS WAF Security Pillar"
}

variable "smart_folder_description" {
  description = "Enter a description for the smart folder"
  type        = string
  default     = "Smart Folder to hold calc policies on the Security Pillar"
}

variable "smart_folder_parent_resource" {
  description = "Enter the resource ID or AKA for the parent of the smart folder"
  type        = string
  default     = "tmod:@turbot/turbot#/"
}

variable "turbot_profile" {
  description = "The name of the Turbot profile to use."
  type = string
}
