variable "target_resource" {
  description = "Enter the resource ID or AKA for the resource to apply the calculated policy"
  type        = string
}

variable "smart_folder_title" {
  description = "Enter a title for the smart folder"
  type        = string
  default     = "AWS S3 - Approved Usage - Associate CloudFront"
}

variable "smart_folder_description" {
  description = "Enter a description for the smart folder"
  type        = string
  default     = <<EOF
  Buckets configured as a static hosting website must have an associated CloudFront distribution configured to encrypt
  data during transit.
  EOF
}

variable "smart_folder_parent_resource" {
  description = "Enter the resource ID or AKA for the parent of the smart folder"
  type        = string
  default     = "tmod:@turbot/turbot#/"
}
