output "enable_iam_user_access_key_active" {
  value = var.enable_iam_user_access_key_active
}

output "enable_iam_user_access_key_active_age" {
  value = var.enable_iam_user_access_key_active_age
}

output "enable_account_password_policysettings" {
  value = var.enable_account_password_policysettings
}

output "enable_account_password_policysettings_require_uppercasecharacters" {
  value = var.enable_account_password_policysettings_require_uppercasecharacters
}

output "enable_account_password_policysettings_require_lowercasecharacters" {
  value = var.enable_account_password_policysettings_require_lowercasecharacters
}

output "enable_account_password_policysettings_requiresymbols" {
  value = var.enable_account_password_policysettings_requiresymbols
}

output "enable_account_password_policysettings_requireNumbers" {
  value = var.enable_account_password_policysettings_requireNumbers
}

output "enable_account_password_policysettings_minimumLength" {
  value = var.enable_account_password_policysettings_minimumLength
}

output "enable_account_password_policysettings_reuseprevention" {
  value = var.enable_account_password_policysettings_reuseprevention
}

output "enable_account_password_policysettings_maxage" {
  value = var.enable_account_password_policysettings_maxage
}

output "enable_iam_policy_approved" {
  value = var.enable_iam_policy_approved
}

output "enable_iam_policy_approved_statements" {
  value = var.enable_iam_policy_approved_statements
}

output "enable_iam_group_inline_policy_approved" {
  value = var.enable_iam_group_inline_policy_approved
}

output "enable_iam_group_inline_policy_approved_admin_access" {
  value = var.enable_iam_group_inline_policy_approved_admin_access
}

output "enable_aws_iam_group_policy_attachement_approved" {
  value = var.enable_aws_iam_group_policy_attachement_approved
}

output "enable_aws_iam_group_policy_attachement_rules" {
  value = var.enable_aws_iam_group_policy_attachement_rules
}

output "enable_iam_role_inline_policy_approved" {
  value = var.enable_iam_role_inline_policy_approved
}

output "enable_iam_role_inline_policy_approved_admin_access" {
  value = var.enable_iam_role_inline_policy_approved_admin_access
}

output "enable_iam_role_policy_attachement_approved" {
  value = var.enable_iam_role_policy_attachement_approved
}

output "enable_iam_role_policy_attachement_rules" {
  value = var.enable_iam_role_policy_attachement_rules
}

output "enable_iam_role_policy_trusted_access" {
  value = var.enable_iam_role_policy_trusted_access
}

output "enable_iam_role_trusted_accounts" {
  value = var.enable_iam_role_trusted_accounts
}

output "enable_iam_user_inline_policy_approved" {
  value = var.enable_iam_user_inline_policy_approved
}

output "enable_iam_user_inline_policy_approved_admin_access" {
  value = var.enable_iam_user_inline_policy_approved_admin_access
}

output "enable_iam_user_mfa_approved" {
  value = var.enable_iam_user_mfa_approved
}

output "enable_iam_user_mfa_approved_usage" {
  value = var.enable_iam_user_mfa_approved_usage
}

output "enable_aws_iam_user_policy_attachement_approved" {
  value = var.enable_aws_iam_user_policy_attachement_approved
}

output "enable_aws_iam_user_policy_attachement_rules" {
  value = var.enable_aws_iam_user_policy_attachement_rules
}


# Turbot profile and smart folder

output "turbot_profile" {
  value = var.turbot_profile
}

output "smart_folder_name" {
  value = var.smart_folder_name
}

output "smart_folder_description" {
  value = var.smart_folder_description
}

output "smart_folder_parent_resource" {
  value = var.smart_folder_parent_resource
}
