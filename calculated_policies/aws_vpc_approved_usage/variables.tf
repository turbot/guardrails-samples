variable "smart_folder_title" {
  description = "Enter a title for the smart folder"
  type        = string
}

variable "smart_folder_description" {
  description = "Enter a description for the smart folder"
  type        = string
  default     = "Restrict VPC that doesnt have transit gateway attachment as a descendant "
}

variable "smart_folder_parent_resource" {
  description = "Enter the resource ID or AKA for the parent of the smart folder"
  type        = string
  default     = "tmod:@turbot/turbot#/"
}
