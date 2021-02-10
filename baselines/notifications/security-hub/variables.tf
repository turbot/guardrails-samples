variable "aws_region" {
  description = "Configures which AWS region SecurityHub baseline resources are created"
  type        = string
}

variable "batch_size" {
  description = "Maximum notification batch size to process to SecurityHub findings"
  default     = "100"
}

variable "batch_window" {
  description = "Maximum notification batch waiting winding to collect notification in order to process to SecurityHub findings"
  default     = "30"
}

variable "turbot_profile" {
  description = "Turbot profile used to install policies for a workspace managed by the profile"
  type        = string
  default     = "default"
}

variable "aws_profile" {
  description = "AWS profile used to install the SecurityHub baseline on the account managed by the profile"
  type        = string
  default     = "default"
}

variable "smart_folder_name" {
  description = "Smart folder name for the baseline"
  type        = string
  default     = "SecurityHub Policies"
}

variable "smart_folder_description" {
  description = "Enter a description for the smart folder"
  type        = string
  default     = <<-DEFAULT
  Defines the sets of policies require to configure Turbot to push out notifications.
  These notifications will be transformed and persisted as SecurityHub findings.
  DEFAULT
}

variable "smart_folder_parent_resource" {
  description = "Enter the resource ID or AKA for the parent resource of the smart folder"
  type        = string
  default     = "tmod:@turbot/turbot#/"
}
