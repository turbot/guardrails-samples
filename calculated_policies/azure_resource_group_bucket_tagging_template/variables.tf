variable "tag_key" {
  description = "Enter a key for the tag to be enforced"
  type        = string
}

variable "tag_default_value" {
  description = "Enter a default value for the tag to be enforced"
  type        = string
}

variable "smart_folder_title" {
  description = "Enter a title for the smart folder"
  type        = string
  default     = "Azure Resource Group Tags Template"
}

variable "smart_folder_description" {
  description = "Enter a description for the smart folder"
  type        = string
  default     = "Enforce tags defined on template"
}

variable "smart_folder_parent_resource" {
  description = "Enter the resource ID or AKA for the parent of the smart folder"
  type        = string
  default     = "tmod:@turbot/turbot#/"
}
