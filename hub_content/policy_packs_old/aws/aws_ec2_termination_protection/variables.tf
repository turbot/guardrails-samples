variable "smart_folder_title" {
  description = "Enter a title for the smart folder"
  type        = string
  default     = "EC2 Instance Termination Protection"
}

variable "smart_folder_description" {
  description = "Enter a description for the smart folder"
  type        = string
  default     = "Protect your Amazon EC2 Instances from accidental termination"
}

variable "smart_folder_parent_resource" {
  description = "Enter the resource ID or AKA for the parent of the smart folder"
  type        = string
  default     = "tmod:@turbot/turbot#/"
}