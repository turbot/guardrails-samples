# Baseline Configuration

variable "aws_account_iam_stack" {
  type        = bool
  description = "AWS IAM stack policies for baseline"
  default     = true
}

variable "aws_account_iam_stack_tfversion" {
  type        = bool
  description = "AWS account IAM stack policies for baseline"
  default     = true
}

variable "aws_account_iam_stack_source" {
  type        = bool
  description = "AWS account IAM stack source policies for baseline"
  default     = true
}

variable "aws_iam_permissions_custom_levels_account" {
  type        = bool
  description = "AWS IAM permissions customer levels accounts policies for baseline"
  default     = true
}

# Smartfolder Configuration

variable "turbot_profile" {
  description = "Enter profile matching your turbot cli credentials."
}

variable "smart_folder_name" {
  description = "Smart folder name for the baseline"
  type        = string
  default     = "AWS Stack Example Policies"
}

variable "smart_folder_description" {
  description = "Enter a description for the smart folder"
  type        = string
  default     = "Defines sets of policies for the AWS Stack baseline"
}

variable "smart_folder_parent_resource" {
  description = "Enter the resource ID or AKA for the parent of the smart folder"
  type        = string
  default     = "tmod:@turbot/turbot#/"
}