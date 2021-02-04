# Baseline Configuration

variable "enable_backup_vault_policies" {
  description = "Enabling will ensure encryption on Backup Vault Resources, by default this is disabled"
  default     = false
}

# None

# Optional Common Baseline Configuration

variable "turbot_profile" {
  description = "Enter profile matching your turbot cli credentials."
  default     = "default"
}

variable "smart_folder_name" {
  description = "Smart folder name for the baseline"
  type        = string
  default     = "AWS Check Encryption Policies"
}

variable "smart_folder_description" {
  description = "Enter a description for the smart folder"
  type        = string
  default     = "Defines sets of policies for the baseline AWS Check Encryption"
}

variable "smart_folder_parent_resource" {
  description = "Enter the resource ID or AKA for the parent of the smart folder"
  type        = string
  default     = "tmod:@turbot/turbot#/"
}
