variable "smart_folder_title" {
  type        = "string"
  default     = "Calc Policy - Copy ECS tags to S3 bucket"
  description = "Enter a title for the smart folder"
}

variable "smart_folder_parent" {
  type        = "string"
  default     = "tmod:@turbot/turbot#/"
  description = "Enter the ID or AKA of the smart folder's parent resource"
}
