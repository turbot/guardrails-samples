variable "smart_folder_title" {
  description = "Enter a title for the smart folder"
  type        = string
  default     = "Resource Details Tagging"
}

variable "smart_folder_description" {
  description = "Enter a description for the smart folder"
  type        = string
  default     = "Automating tags from CMDB resource details"
}

variable "smart_folder_parent_resource" {
  description = "Enter the resource ID or AKA for the parent of the smart folder"
  type        = string
  default     = "tmod:@turbot/turbot#/"
}
