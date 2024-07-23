variable "smart_folder_title" {
  description = "Enter a title for the smart folder"
  type        = string
  default     = "GCP Compute Instance Block Project-wide SSH Keys"
}

variable "smart_folder_description" {
  description = "Enter a description for the smart folder"
  type        = string
  default     = "Block project-wide SSH keys from accessing your GCP Compute Instances"
}

variable "smart_folder_parent_resource" {
  description = "Enter the resource ID or AKA for the parent of the smart folder"
  type        = string
  default     = "tmod:@turbot/turbot#/"
}