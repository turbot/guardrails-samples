variable "resource_tags" {
  description = "Map of the list of resources that need to be tagged. please update in terraform.tfvars:"
  type        = map
}

variable "policy_map" {
  description = "This is a map of Turbot policy types to service names. You probably should not modify this:"
  type        = map
}

variable "smart_folder_title" {
    type        = string
    default     = "AWS KMS Policy Rules"
}

variable "smart_folder_description" {
    description = "Enter a description for the smart folder"
    type        = string
    default     = "Restrict permissions on KMS Key policies"
}

variable "smart_folder_parent_resource" {
    description = "Enter the resource ID or AKA for the parent of the smart folder"
    type        = string
    default     = "tmod:@turbot/turbot#"
}

variable "turbot_profile" {
    description = "Enter profile matching your turbot cli credentials."
}