variable "target_resource" {
  description = "Enter a target_resource to attach the smart folder and apply its policies."
  type        = string
}

variable "smart_folder_title" {
  description = "Folder to import the Azure Subscription:"
  type        = string
}

# Defaults to the Turbot Resource level using the AKA which identifies the Turbot level.
variable "folder_parent" {
  type    = string
  default = "tmod:@turbot/turbot#/"
}
