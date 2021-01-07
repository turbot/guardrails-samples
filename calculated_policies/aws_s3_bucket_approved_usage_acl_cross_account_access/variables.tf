variable "approved_accounts" {
  type        = list(string)
  description = "Enter a list of approved AWS account for S3 Bucket ACL cross-account access in Canonical user ID form"
}

variable "target_resource" {
  description = "Enter the resource ID or AKA for the resource to apply the calculated policy"
  type        = string
}

variable "smart_folder_title" {
  description = "Enter a title for the smart folder"
  type        = string
  default     = "S3 Bucket ACL Cross-Account Access"
}

variable "smart_folder_description" {
  description = "Enter a description for the smart folder"
  type        = string
  default     = "Restrict AWS S3 Bucket ACL cross-account access to approved accounts"
}

variable "smart_folder_parent_resource" {
  description = "Enter the resource ID or AKA for the parent of the smart folder"
  type        = string
  default     = "tmod:@turbot/turbot#/"
}
