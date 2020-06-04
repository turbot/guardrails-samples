resource "turbot_smart_folder" "iam_password_settings" {
  title         = var.smart_folder_title
  description   = "Create a smart folder to apply the IAM Cross Account policy settings"
  parent        = "tmod:@turbot/turbot#/"
}

# Check if the IAM Account Password Policy is configured based on AWS > IAM > Account Password Policy > Configured > Configuration.
# AWS > IAM > Account Password Policy > Configured
resource "turbot_policy_setting" "iam_account_passwordpolicy_configured" {
    resource = turbot_smart_folder.iam_password_settings.id
    type = "tmod:@turbot/aws-iam#/policy/types/accountPasswordPolicySettings"
    value = "Check: Configured"
  
}

# Check if the IAM Account Password Policy is configured based on AWS > IAM > Account Password Policy > Settings > Allow users to change
# Refer to [Managing Password Policies](http://docs.aws.amazon.com/IAM/latest/UserGuide/Using_ManagingPasswordPolicies.html) in the AWS IAM Documentation.
# AWS > IAM > Account Password Policy > Settings > Allow Users to Change
resource "turbot_policy_setting" "iam_account_passwordpolicy_settings_allowchange" {
    resource = turbot_smart_folder.iam_password_settings.id
    type = "tmod:@turbot/aws-iam#/policy/types/accountPasswordPolicySettingsAllowUsersToChange"
    value = "Enabled"
  
}

# Check if the IAM Account Password Policy is configured based on AWS > IAM > Account Password Policy > Settings > Require Lowercase Characters
# Refer to [Managing Password Policies](http://docs.aws.amazon.com/IAM/latest/UserGuide/Using_ManagingPasswordPolicies.html) in the AWS IAM Documentation.
# AWS > IAM > Account Password Policy > Settings > Require Lowercase Characters
resource "turbot_policy_setting" "iam_account_passwordpolicy_settings_lowercase" {
    resource = turbot_smart_folder.iam_password_settings.id
    type = "tmod:@turbot/aws-iam#/policy/types/accountPasswordPolicySettingsRequireLowercaseCharacters"
    value = "Enabled"
  
}

# Check if the IAM Account Password Policy is configured based on AWS > IAM > Account Password Policy > Settings > Require Numbers
# Refer to [Managing Password Policies](http://docs.aws.amazon.com/IAM/latest/UserGuide/Using_ManagingPasswordPolicies.html) in the AWS IAM Documentation.
# AWS > IAM > Account Password Policy > Settings > Require Numbers
resource "turbot_policy_setting" "iam_account_passwordpolicy_settings_numbers" {
    resource = turbot_smart_folder.iam_password_settings.id
    type = "tmod:@turbot/aws-iam#/policy/types/accountPasswordPolicySettingsRequireNumbers"
    value = "Enabled"
  
}

# Check if the IAM Account Password Policy is configured based on AWS > IAM > Account Password Policy > Settings > Require Symbols
# Refer to [Managing Password Policies](http://docs.aws.amazon.com/IAM/latest/UserGuide/Using_ManagingPasswordPolicies.html) in the AWS IAM Documentation.
# AWS > IAM > Account Password Policy > Settings > Require Symbols
resource "turbot_policy_setting" "iam_account_passwordpolicy_settings_symbols" {
    resource = turbot_smart_folder.iam_password_settings.id
    type = "tmod:@turbot/aws-iam#/policy/types/accountPasswordPolicySettingsRequireSymbols"
    value = "Enabled"
  
}

# Check if the IAM Account Password Policy is configured based on AWS > IAM > Account Password Policy > Settings > Require Uppercase Characters
# Refer to [Managing Password Policies](http://docs.aws.amazon.com/IAM/latest/UserGuide/Using_ManagingPasswordPolicies.html) in the AWS IAM Documentation.
# AWS > IAM > Account Password Policy > Settings > Require Uppercase Characters
resource "turbot_policy_setting" "iam_account_passwordpolicy_settings_uppercase" {
    resource = turbot_smart_folder.iam_password_settings.id
    type = "tmod:@turbot/aws-iam#/policy/types/accountPasswordPolicySettingsRequireUppercaseCharacters"
    value = "Enabled"
  
}

# Check if the IAM Account Password Policy is configured based on AWS > IAM > Account Password Policy > Settings > Reuse Prevention
# Refer to [Managing Password Policies](http://docs.aws.amazon.com/IAM/latest/UserGuide/Using_ManagingPasswordPolicies.html) in the AWS IAM Documentation.
# AWS > IAM > Account Password Policy > Settings > Reuse Prevention
resource "turbot_policy_setting" "iam_account_passwordpolicy_settings_reuseprevention" {
    resource = turbot_smart_folder.iam_password_settings.id
    type = "tmod:@turbot/aws-iam#/policy/types/accountPasswordPolicySettingsReusePrevention"
    value = "5"
  
}


# Check if the IAM Account Password Policy is configured based on AWS > IAM > Account Password Policy > Settings > Max Age
# Refer to [Managing Password Policies](http://docs.aws.amazon.com/IAM/latest/UserGuide/Using_ManagingPasswordPolicies.html) in the AWS IAM Documentation.
# AWS > IAM > Account Password Policy > Settings > Max Ages
resource "turbot_policy_setting" "iam_account_passwordpolicy_settings_maxage" {
    resource = turbot_smart_folder.iam_password_settings.id
    type = "tmod:@turbot/aws-iam#/policy/types/accountPasswordPolicySettingsMaxAge"
    value = "90"
  
}

# Check if the IAM Account Password Policy is configured based on AWS > IAM > Account Password Policy > Settings > Minimum Length
# Refer to [Managing Password Policies](http://docs.aws.amazon.com/IAM/latest/UserGuide/Using_ManagingPasswordPolicies.html) in the AWS IAM Documentation.
# AWS > IAM > Account Password Policy > Settings > Minimum Length
resource "turbot_policy_setting" "iam_account_passwordpolicy_settings_minlength" {
    resource = turbot_smart_folder.iam_password_settings.id
    type = "tmod:@turbot/aws-iam#/policy/types/accountPasswordPolicySettingsMinimumLength"
    value = "8"
  
}

### Credential Expiration

# Check if the IAM Account Password Policy is configured based on AWS > IAM > Account Password Policy > Settings > Minimum Length
# Refer to [Managing Password Policies](http://docs.aws.amazon.com/IAM/latest/UserGuide/Using_ManagingPasswordPolicies.html) in the AWS IAM Documentation.
# AWS > IAM > Account Password Policy > Settings > Minimum Length
resource "turbot_policy_setting" "iam_account_passwordpolicy_hard_expiry" {
    resource = turbot_smart_folder.iam_password_settings.id
    type = "tmod:@turbot/aws-iam#/policy/types/accountPasswordPolicySettingsHardExpiry"
    value = "Enabled"
  
}