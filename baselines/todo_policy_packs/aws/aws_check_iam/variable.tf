
# Baseline Configuration
variable "trusted_accounts" {
  type    = list(string)
  default = []
}

variable "enable_iam_user_access_key_active" {
  type        = bool
  description = "Enable the IAM user access key policies for baseline"
  default     = true
}

variable "enable_iam_user_access_key_active_age" {
  type        = bool
  description = "Enable the IAM user access key age policies for baseline"
  default     = true
}

variable "enable_account_password_policysettings" {
  type        = bool
  description = "Enable the IAM user account password policies for baseline"
  default     = true
}

variable "enable_account_password_policysettings_require_uppercasecharacters" {
  type        = bool
  description = "Enable the IAM user account password uppercase character policies for baseline"
  default     = true
}

variable "enable_account_password_policysettings_require_lowercasecharacters" {
  type        = bool
  description = "Enable the IAM user account password lowercase character policies for baseline"
  default     = true
}

variable "enable_account_password_policysettings_requiresymbols" {
  type        = bool
  description = "Enable the IAM user account password symbol setting policies for baseline"
  default     = true
}

variable "enable_account_password_policysettings_requireNumbers" {
  type        = bool
  description = "Enable the IAM user account password number setting policies for baseline"
  default     = true
}

variable "enable_account_password_policysettings_minimumLength" {
  type        = bool
  description = "Enable the IAM user account password number setting policies for baseline"
  default     = true
}

variable "enable_account_password_policysettings_reuseprevention" {
  type        = bool
  description = "Enable the IAM user account password reuse setting policies for baseline"
  default     = true
}

variable "enable_account_password_policysettings_maxage" {
  type        = bool
  description = "Enable the IAM user account password maximum age setting policies for baseline"
  default     = true
}

variable "enable_iam_policy_approved" {
  type        = bool
  description = "Enable the IAM approved policies for baseline"
  default     = true
}

variable "enable_iam_policy_approved_statements" {
  type        = bool
  description = "Enable the IAM approved statement policies for baseline"
  default     = true
}

variable "enable_iam_group_inline_policy_approved" {
  type        = bool
  description = "Enable the IAM group inline policies for baseline"
  default     = true
}

variable "enable_iam_group_inline_policy_approved_admin_access" {
  type        = bool
  description = "Enable the IAM group inline admin access policies for baseline"
  default     = true
}

variable "enable_aws_iam_group_policy_attachement_approved" {
  type        = bool
  description = "Enable the IAM group attachment policies for baseline"
  default     = true
}

variable "enable_aws_iam_group_policy_attachement_rules" {
  type        = bool
  description = "Enable the IAM group attachment rules policies for baseline"
  default     = true
}

variable "enable_iam_role_inline_policy_approved" {
  type        = bool
  description = "Enable the IAM role inline policies for baseline"
  default     = true
}

variable "enable_iam_role_inline_policy_approved_admin_access" {
  type        = bool
  description = "Enable the IAM approved statement policies for baseline"
  default     = true
}

variable "enable_iam_role_policy_attachement_approved" {
  type        = bool
  description = "Enable the IAM role policy attachment for baseline"
  default     = true
}

variable "enable_iam_role_policy_attachement_rules" {
  type        = bool
  description = "Enable the IAM role policy attachment rules for baseline"
  default     = true
}

variable "enable_iam_role_policy_trusted_access" {
  type        = bool
  description = "Enable the IAM role policy trusted access for baseline"
  default     = false
}

variable "enable_iam_role_trusted_accounts" {
  type        = bool
  description = "Enable the IAM role policy trusted account for baseline"
  default     = false
}

variable "enable_iam_user_inline_policy_approved" {
  type        = bool
  description = "Enable the IAM user inline policy for baseline"
  default     = true
}

variable "enable_iam_user_inline_policy_approved_admin_access" {
  type        = bool
  description = "Enable the IAM user inline policy admin access for baseline"
  default     = true
}

variable "enable_iam_user_mfa_approved" {
  type        = bool
  description = "Enable the IAM user mfa approved policy for baseline"
  default     = true
}

variable "enable_iam_user_mfa_approved_usage" {
  type        = bool
  description = "Enable the IAM user mfa approved usage policy for baseline"
  default     = true
}

variable "enable_aws_iam_user_policy_attachement_approved" {
  type        = bool
  description = "Enable the IAM user approved policy attachment for baseline"
  default     = true
}

variable "enable_aws_iam_user_policy_attachement_rules" {
  type        = bool
  description = "Enable the IAM user policy attachment for baseline"
  default     = true
}

# Optional Common Baseline Configuration

variable "turbot_profile" {
  description = "Enter profile matching your turbot cli credentials."
}

variable "smart_folder_name" {
  description = "Smart folder name for the baseline"
  type        = string
  default     = "AWS Check IAM Policies"
}

variable "smart_folder_description" {
  description = "Enter a description for the smart folder"
  type        = string
  default     = "Defines sets of policies for the AWS check S3 baseline"
}

variable "smart_folder_parent_resource" {
  description = "Enter the resource ID or AKA for the parent of the smart folder"
  type        = string
  default     = "tmod:@turbot/turbot#/"
}
