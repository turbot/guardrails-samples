# AWS > IAM > Account Password Policy > Settings
resource "turbot_policy_setting" "aws_iam_account_password_policy_settings" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/accountPasswordPolicySettings"
  value    = "Check: Configured"
  # value    = "Enforce: Configured"
}

# AWS > IAM > Account Password Policy > Settings > Allow Users to Change
resource "turbot_policy_setting" "aws_iam_account_password_policy_settings_allow_users_to_change" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/accountPasswordPolicySettingsAllowUsersToChange"
  value    = "Enabled"
}

# AWS > IAM > Account Password Policy > Settings > Hard Expiry
resource "turbot_policy_setting" "aws_iam_account_password_policy_settings_hard_expiry" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/accountPasswordPolicySettingsHardExpiry"
  value    = "Enabled"
}

# AWS > IAM > Account Password Policy > Settings > Max Age
resource "turbot_policy_setting" "iam_account_password_policy_settings_max_age" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/accountPasswordPolicySettingsMaxAge"
  # Permitted values are between 1 and 1095
  value    = 90 
}

# AWS > IAM > Account Password Policy > Settings > Minimum Length
resource "turbot_policy_setting" "iam_account_password_policy_settings_minimum_length" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/accountPasswordPolicySettingsMinimumLength"
  # Permitted values are between 6 and 128
  value    = 14
}

# AWS > IAM > Account Password Policy > Settings > Reuse Prevention
resource "turbot_policy_setting" "iam_account_password_policy_settings_reuse_prevention" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/accountPasswordPolicySettingsReusePrevention"
  # Permitted values are between 1 and 24
  value    = 5
}

# AWS > IAM > Account Password Policy > Settings > Require Lowercase Characters
resource "turbot_policy_setting" "iam_account_password_policy_settings_lowercase_characters" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/accountPasswordPolicySettingsRequireLowercaseCharacters"
  value    = "Enabled"
}

# AWS > IAM > Account Password Policy > Settings > Require Numbers
resource "turbot_policy_setting" "iam_account_password_policy_settings_require_numbers" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/accountPasswordPolicySettingsRequireNumbers"
  value    = "Enabled"
}

# AWS > IAM > Account Password Policy > Settings > Require Symbols
resource "turbot_policy_setting" "iam_account_password_policy_settings_require_symbols" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/accountPasswordPolicySettingsRequireSymbols"
  value    = "Enabled"
}

# AWS > IAM > Account Password Policy > Settings > Require Uppercase Characters
resource "turbot_policy_setting" "iam_account_password_policy_settings_require_uppercase_characters" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/accountPasswordPolicySettingsRequireUppercaseCharacters"
  value    = "Enabled"
}

