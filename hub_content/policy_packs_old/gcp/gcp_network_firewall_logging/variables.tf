variable "smart_folder_title" {
  description = "Enter a title for the smart folder"
  type        = string
  default     = "GCP Firewall Logging"
}

variable "smart_folder_description" {
  description = "Enter a description for the smart folder"
  type        = string
  default     = "Automatically enable GCP Firewall Logging for each firewall rule"
}

variable "smart_folder_parent_resource" {
  description = "Enter the resource ID or AKA for the parent of the smart folder"
  type        = string
  default     = "tmod:@turbot/turbot#/"
}