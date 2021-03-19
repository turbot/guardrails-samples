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