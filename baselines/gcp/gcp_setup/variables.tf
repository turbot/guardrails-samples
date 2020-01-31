variable "smart_folder_title" {
  description = "Enter Smart folder name for importing the gcp account:"
  type        = string
}

variable "folder_parent" {
  type        = string
  default     = "tmod:@turbot/turbot#/"
}