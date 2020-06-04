variable "target_resource" {
  description = "Enter the resource ID or AKA for the resource to apply the calculated policy"
  type        = string
}

variable "smart_folder_title" {
  description = "Enter a title for the smart folder"
  type        = string
  default     = "AWS S3 - Approved Usage - Name DNS Compliant"
}

variable "smart_folder_description" {
  description = "Enter a description for the smart folder"
  type        = string
  default     = "Restrict AWS S3 Bucket names to DNS Compliant names"
}

variable "smart_folder_parent_resource" {
  description = "Enter the resource ID or AKA for the parent of the smart folder"
  type        = string
  default     = "tmod:@turbot/turbot#/"
}
