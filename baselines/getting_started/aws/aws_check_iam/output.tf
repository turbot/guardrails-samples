output "enable_iam_user_access_key_active" {
  value = var.enable_iam_user_access_key_active
}

output "enable_iam_user_access_key_active_age" {
  value = var.enable_iam_user_access_key_active_age
}

output "enable_account_Password_PolicySettings" {
  value = var.enable_account_Password_PolicySettings
}

output "enable_account_Password_PolicySettings_RequireUppercaseCharacters" {
  value = var.enable_account_Password_PolicySettings_RequireUppercaseCharacters
}

output "enable_account_Password_PolicySettings_RequireLowercaseCharacters" {
  value = var.enable_account_Password_PolicySettings_RequireLowercaseCharacters
}

output "enable_account_Password_PolicySettings_RequireSymbols" {
  value = var.enable_account_Password_PolicySettings_RequireSymbols
}

output "enable_account_Password_PolicySettings_RequireNumbers" {
  value = var.enable_account_Password_PolicySettings_RequireNumbers
}

output "enable_account_Password_PolicySettings_MinimumLength" {
  value = var.enable_account_Password_PolicySettings_MinimumLength
}

output "enable_account_Password_PolicySettings_ReusePrevention" {
  value = var.enable_account_Password_PolicySettings_ReusePrevention
}

output "enable_account_Password_PolicySettings_MaxAge" {
  value = var.enable_account_Password_PolicySettings_MaxAge
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
