variable "smart_folder_title" {
    type        = string
    description = "Enter a title for the smart folder"
}

variable "access_logging_bucket" {
    type = string
    description = "Enter the S3 bucket to ship logs to"
}

variable "log_prefix" {
    type = string
    description = "Enter the prefix for access logs"
}