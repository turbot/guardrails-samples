variable "smart_folder_title" {
  description = "Enter a title for the smart folder"
  type        = string
  default     = "Amazon S3 Access Logging"
}

variable "smart_folder_description" {
  description = "Enter a description for the smart folder"
  type        = string
  default     = "Automatically enable server access logging on your S3 buckets."
}

variable "smart_folder_parent_resource" {
  description = "Enter the resource ID or AKA for the parent of the smart folder"
  type        = string
  default     = "tmod:@turbot/turbot#/"
}

/* # Enable if not using the Turbot defaults for log bucket and prefix
variable "access_logging_bucket" {
    type = string
    description = "Enter the S3 bucket to ship logs to"
}

variable "log_prefix" {
    type = string
    description = "Enter the prefix for access logs"
}
*/