variable "smart_folder_title" {
  description = "Enter a title for the smart folder"
  type        = string
  default     = "Resource Owner Tags"
}

variable "smart_folder_description" {
  description = "Enter a description for the smart folder"
  type        = string
  default     = "Quick and transparent visibility to who created a resource and when it was created"
}

variable "smart_folder_parent_resource" {
  description = "Enter the resource ID or AKA for the parent of the smart folder"
  type        = string
  default     = "tmod:@turbot/turbot#/"
}
