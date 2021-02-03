# IAM users must rotate keys every 90 days
# Relates to AWS CIS 1.04 Ensure access keys are rotated every 90 days or less (Scored)


resource "turbot_policy_setting" "iam_user_access_key_active" {
  resource        = turbot_smart_folder.aws_iam.id
  type            = "tmod:@turbot/aws-iam#/policy/types/accessKeyActive"
  value           = "Check: Active"
}

resource "turbot_policy_setting" "iam_user_access_key_active_age" {
  resource        = turbot_smart_folder.aws_iam.id
  type            = "tmod:@turbot/aws-iam#/policy/types/accessKeyActiveAge"
  value           = "Force inactive if age > 90 days"
}