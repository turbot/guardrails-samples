variable "smart_folder_title" {
  description = "Enter a title for the smart folder"
  type        = string
  default     = "AWS S3 Tags Ignoring Casing"
}

variable "smart_folder_description" {
  description = "Enter a description for the smart folder"
  type        = string
  default     = "Check for tags on an S3 bucket ignoring casing of the key and value"
}

variable "smart_folder_parent_resource" {
  description = "Enter the resource ID or AKA for the parent of the smart folder"
  type        = string
  default     = "tmod:@turbot/turbot#/"
}

variable "turbot_profile" {
  description = "Enter profile matching your turbot cli credentials."
}