# IAM users must rotate keys every 90 days
# Relates to AWS CIS 1.04 Ensure access keys are rotated every 90 days or less (Scored)


# AWS > IAM > Access Key > Active
# https://turbot.com/v5/mods/turbot/aws-iam/inspect#/policy/types/accessKeyActive
resource "turbot_policy_setting" "iam_user_access_key_active" {
  count    = var.enable_iam_user_access_key_active ? 1 : 0
  resource = turbot_smart_folder.aws_iam.id
  type     = "tmod:@turbot/aws-iam#/policy/types/accessKeyActive"
  value    = "Check: Active"
}


# AWS > IAM > Access Key > Active > Age
# https://turbot.com/v5/mods/turbot/aws-iam/inspect#/policy/types/accessKeyActiveAge
resource "turbot_policy_setting" "iam_user_access_key_active_age" {
  count    = var.enable_iam_user_access_key_active_age ? 1 : 0
  resource = turbot_smart_folder.aws_iam.id
  type     = "tmod:@turbot/aws-iam#/policy/types/accessKeyActiveAge"
  value    = "Force inactive if age > 90 days"
}
