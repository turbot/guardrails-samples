variable "smart_folder_title" {
  description = "Enter a title for the smart folder."
  type        = string
  default     = "EC2 AMI and Snapshot Cross Account Access"
}

variable "smart_folder_description" {
  description = "Enter a description for the smart folder"
  type        = string
  default     = "Checks AMI and Snapshots for cross account access. Approved if the account ID exists in the Turbot File."
}

variable "smart_folder_parent_resource" {
  description = "Enter the resource ID or AKA for the parent of the smart folder."
  type        = string
  default     = "tmod:@turbot/turbot#/"
}

variable "turbot_file_name" {
  description = "Enter a name for the generated Turbot File."
  type        = string
  default     = "Approved Accounts"
}

variable "turbot_file_description" {
  description = "Enter a description for the generated Turbot File."
  type        = string
  default     = "Turbot File containing a list of accounts approved for cross account AMI and Snapshot access"
}

variable "turbot_file_aka" {
  description = "Enter an aka for the Turbot File."
  type        = string
  default     = "list_accounts"
}