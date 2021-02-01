# AWS Check S3 Policies focuses on an example of a deeper baseline for a specific service
# Some of these policies overlap with other baselines.  
# With the setup of each baseline in each Smart Folder, there is no conflict on the policy settings

variable "turbot_profile" {
  description = "Enter profile matching your turbot cli credentials."
  default     = "default"
}

variable "trusted_accounts" {
  type    = list(string)
  default = []
}

variable "smart_folder_name" {
  type    = string
  default = "AWS Check S3 Policies"
}

variable "enable_rds" {
  type        = string
  description = "Do you have RDS"
}


