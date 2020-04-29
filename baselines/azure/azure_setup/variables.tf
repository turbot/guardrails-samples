variable "smart_folder_title" {
  description = "Folder to import the Azure Subscription:"
  type        = string
}

# It is the turbot id of turbot folder or resource.
# The Admin and Owner grants will be activated at this level
variable "folder_parent" {
  type    = string
  default = "tmod:@turbot/turbot#/"
}

variable "target_resource" {
  description = "Enter a target_resource to attach the smart folder and apply its policies."
  type        = string
}
