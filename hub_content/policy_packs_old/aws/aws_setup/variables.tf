variable "smart_folder_title" {
  description = "Smart folder for importing the aws account:"
  type        = string
}

variable "aws_regions" {
  type        = string

  default     = <<EOT
  - us-east-1
  EOT
}

variable "setup_cloudtrail" {
  default     = true
}

variable "folder_parent" {
  type        = string
  default     = "tmod:@turbot/turbot#/"
}