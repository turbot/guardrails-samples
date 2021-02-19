# Baseline Configuration

variable "enable_service_account_key_active_policies" {
  type        = bool
  description = "Enable the IAM user access key policies for baseline"
  default     = true
}

variable "enable_service_account_key_active_age_policies" {
  type        = bool
  description = "Enable the IAM user access key age policies for baseline"
  default     = true
}

variable "service_account_key_approved_policies" {
  type        = bool
  description = "Enable the IAM Service Account password policies for baseline"
  default     = false
}

variable "service_account_key_approved_usage_policies" {
  type        = bool
  description = "Enable the IAM Service Account Key approved policies for baseline"
  default     = false
}

variable "enable_service_account_policy_trusted_access_policies" {
  type        = bool
  description = "Enable the IAM Service Account Trusted Access policies for baseline"
  default     = true
}

variable "enable_service_account_policy_trusted_domains_policies" {
  type        = bool
  description = "Enable the IAM Service Account Trusted Domain policies for baseline"
  default     = false
}

# Optional Common Baseline Configuration

variable "turbot_profile" {
  description = "Enter profile matching your turbot cli credentials."
}

variable "smart_folder_name" {
  description = "Smart folder name for the baseline"
  type        = string
  default     = "GCP Check IAM Policies"
}

variable "smart_folder_description" {
  description = "Enter a description for the smart folder"
  type        = string
  default     = "Defines sets of policies for the GCP Check IAM baseline"
}

variable "smart_folder_parent_resource" {
  description = "Enter the resource ID or AKA for the parent of the smart folder"
  type        = string
  default     = "tmod:@turbot/turbot#/"
}
