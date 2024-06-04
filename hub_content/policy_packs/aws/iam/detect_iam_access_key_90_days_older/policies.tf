# AWS > IAM > Access Key > Active
resource "turbot_policy_setting" "aws_iam_access_key_active" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-iam#/policy/types/accessKeyActive"
  value    = "Check: Active"
  # value    =  "Enforce: Delete inactive with 1 day warning"
  # value    =  "Enforce: Delete inactive with 3 days warning"
  # value    =  "Enforce: Delete inactive with 7 days warning"
  # value    =  "Enforce: Delete inactive with 14 days warning"
  # value    =  "Enforce: Delete inactive with 30 days warning"
  # value    =  "Enforce: Delete inactive with 60 days warning"
  # value    =  "Enforce: Delete inactive with 90 days warning"
  # value    =  "Enforce: Delete inactive with 180 days warning"
  # value    =  "Enforce: Delete inactive with 365 days warning"
  # value    =  "Enforce: Deactivate inactive with 1 day warning"
  # value    =  "Enforce: Deactivate inactive with 3 days warning"
  # value    =  "Enforce: Deactivate inactive with 7 days warning"
  # value    =  "Enforce: Deactivate inactive with 14 days warning"
  # value    =  "Enforce: Deactivate inactive with 30 days warning"
  # value    =  "Enforce: Deactivate inactive with 60 days warning"
  # value    =  "Enforce: Deactivate inactive with 90 days warning"
  # value    =  "Enforce: Deactivate inactive with 180 days warning"
  # value    =  "Enforce: Deactivate inactive with 365 days warning"
}

# AWS > IAM > Access Key > Active > Age
resource "turbot_policy_setting" "aws_iam_access_key_active_age" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-iam#/policy/types/accessKeyActiveAge"
  value    = "Force inactive if age > 90 days"
}
