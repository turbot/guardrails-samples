## IAM Account Password Policy CIS Controls

#Enforces CIS 1.05 to 1.10 Account Password Policy Setting Conditions below
# https://turbot.com/v5/mods/turbot/aws-iam/inspect#/policy/types/accountPasswordPolicySettings
resource "turbot_policy_setting" "account_Password_PolicySettings"{
  count     = var.enable_account_Password_PolicySettings ? 1 : 0
  resource = turbot_smart_folder.aws_iam.id
  type = "tmod:@turbot/aws-iam#/policy/types/accountPasswordPolicySettings"
  value = "Check: Configured"
}

#1.05 Ensure IAM password policy requires at least one uppercase letter (Scored)
# https://turbot.com/v5/mods/turbot/aws-iam/inspect#/policy/types/accountPasswordPolicySettingsRequireUppercaseCharacters
resource "turbot_policy_setting" "account_Password_PolicySettings_RequireUppercaseCharacters"{
  count     = var.enable_account_Password_PolicySettings_RequireUppercaseCharacters ? 1 : 0
  resource = turbot_smart_folder.aws_iam.id
  type = "tmod:@turbot/aws-iam#/policy/types/accountPasswordPolicySettingsRequireUppercaseCharacters"
  value = "Enabled"
}

#1.06 Ensure IAM password policy require at least one lowercase letter (Scored)
# https://turbot.com/v5/mods/turbot/aws-iam/inspect#/policy/types/accountPasswordPolicySettingsRequireLowercaseCharacters
resource "turbot_policy_setting" "account_Password_PolicySettings_RequireLowercaseCharacters"{
  count     = var.enable_account_Password_PolicySettings_RequireLowercaseCharacters ? 1 : 0
  resource = turbot_smart_folder.aws_iam.id
  type = "tmod:@turbot/aws-iam#/policy/types/accountPasswordPolicySettingsRequireLowercaseCharacters"
  value = "Enabled"
}

#1.07 Ensure IAM password policy require at least one symbol (Scored)
# https://turbot.com/v5/mods/turbot/aws-iam/inspect#/policy/types/accountPasswordPolicySettingsRequireSymbols
resource "turbot_policy_setting" "account_Password_PolicySettings_RequireSymbols"{
  count     = var.enable_account_Password_PolicySettings_RequireSymbols ? 1 : 0
  resource = turbot_smart_folder.aws_iam.id
  type = "tmod:@turbot/aws-iam#/policy/types/accountPasswordPolicySettingsRequireSymbols"
  value = "Enabled"
}

#1.08 Ensure IAM password policy require at least one number (Scored)
# https://turbot.com/v5/mods/turbot/aws-iam/inspect#/policy/types/accountPasswordPolicySettingsRequireNumbers
resource "turbot_policy_setting" "account_Password_PolicySettings_RequireNumbers"{
  count     = var.enable_account_Password_PolicySettings_RequireNumbers ? 1 : 0
  resource = turbot_smart_folder.aws_iam.id
  type = "tmod:@turbot/aws-iam#/policy/types/accountPasswordPolicySettingsRequireNumbers"
  value = "Enabled"
}

#1.09 Ensure IAM password policy requires minimum length of 14 or greater (Scored)
# https://turbot.com/v5/mods/turbot/aws-iam/inspect#/policy/types/accountPasswordPolicySettingsMinimumLength
resource "turbot_policy_setting" "account_Password_PolicySettings_MinimumLength"{
  count     = var.enable_account_Password_PolicySettings_MinimumLength ? 1 : 0
  resource = turbot_smart_folder.aws_iam.id
  type = "tmod:@turbot/aws-iam#/policy/types/accountPasswordPolicySettingsMinimumLength"
  value = "14"
}

#1.10 Ensure IAM password policy prevents password reuse (Scored)
# https://turbot.com/v5/mods/turbot/aws-iam/inspect#/policy/types/accountPasswordPolicySettingsReusePrevention
resource "turbot_policy_setting" "account_Password_PolicySettings_ReusePrevention"{
  count     = var.enable_account_Password_PolicySettings_ReusePrevention ? 1 : 0
  resource = turbot_smart_folder.aws_iam.id
  type = "tmod:@turbot/aws-iam#/policy/types/accountPasswordPolicySettingsReusePrevention"
  value = "24"
}

#1.11 Ensure IAM password policy expires passwords within 90 days or less (Scored)
# https://turbot.com/v5/mods/turbot/aws-iam/inspect#/policy/types/accountPasswordPolicySettingsMaxAge
resource "turbot_policy_setting" "account_Password_PolicySettings_MaxAge"{
  count     = var.enable_account_Password_PolicySettings_MaxAge ? 1 : 0
  resource = turbot_smart_folder.aws_iam.id
  type = "tmod:@turbot/aws-iam#/policy/types/accountPasswordPolicySettingsMaxAge"
  value = "90"
}