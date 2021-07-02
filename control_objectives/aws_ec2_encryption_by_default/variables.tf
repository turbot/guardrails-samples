variable "smart_folder_title" {
  description = "Enter a title for the smart folder"
  type        = string
  default     = "AWS EC2 Encryption by Default"
}

variable "smart_folder_description" {
  description = "Enter a description for the smart folder"
  type        = string
  default     = "Automatic encryption by default of new Amazon EBS volumes and snapshots"
}

variable "smart_folder_parent_resource" {
  description = "Enter the resource ID or AKA for the parent of the smart folder"
  type        = string
  default     = "tmod:@turbot/turbot#/"
}