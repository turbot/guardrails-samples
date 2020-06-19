variable "cross_resource_tag_key" {
  description = "Enter the tag key which should match between S3 Bucket and CMK"
  type        = string
}

variable "target_resource" {
  description = "Enter the resource ID or AKA for the resource to apply the calculated policy"
  type        = string
}

variable "smart_folder_title" {
  description = "Enter a title for the smart folder"
  type        = string
  default     = "AWS S3 - Encryption at Rest Customer Managed Key - Match tags on Bucket and CMK"
}

variable "smart_folder_description" {
  description = "Enter a description for the smart folder"
  type        = string
  default     = "Match tags on S3 Bucket and CMK"
}

variable "smart_folder_parent_resource" {
  description = "Enter the resource ID or AKA for the parent of the smart folder"
  type        = string
  default     = "tmod:@turbot/turbot#/"
}
