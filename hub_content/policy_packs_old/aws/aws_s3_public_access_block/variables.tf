variable "smart_folder_title" {
  description = "Enter a title for the smart folder"
  type        = string
  default     = "S3 Public Access Block"
}

variable "smart_folder_description" {
  description = "Enter a description for the smart folder"
  type        = string
  default     = "Automatically set AWS S3 Account and Bucket Level Public Access Block Settings"
}

variable "smart_folder_parent_resource" {
  description = "Enter the resource ID or AKA for the parent of the smart folder"
  type        = string
  default     = "tmod:@turbot/turbot#/"
}