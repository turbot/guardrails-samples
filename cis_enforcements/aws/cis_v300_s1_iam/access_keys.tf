# AWS > IAM > Access Key > Active
resource "turbot_policy_setting" "aws_iam_access_key_active" {
  resource = turbot_smart_folder.aws_cis_v300_s1_iam.id
  type     = "tmod:@turbot/aws-iam#/policy/types/accessKeyActive"
  value    = "Check: Active"
  note     = "AWS CIS v3.0.0 - Controls: 1.12 & 1.14"
  # value    = "Enforce: Deactivate inactive with 14 days warning"
}

# AWS > IAM > Access Key > Active > Last Modified
resource "turbot_policy_setting" "aws_iam_access_key_active_last_modified" {
  resource = turbot_smart_folder.aws_cis_v300_s1_iam.id
  type     = "tmod:@turbot/aws-iam#/policy/types/accessKeyActiveLastModified"
  note     = "Prevents newly created access keys from being deleted for not having been used recently."
  value    = "Force active if last modified <= 7 days"
}

# AWS > IAM > Access Key > Active > Recently Used
resource "turbot_policy_setting" "aws_iam_access_key_active_recently_used" {
  resource = turbot_smart_folder.aws_cis_v300_s1_iam.id
  type     = "tmod:@turbot/aws-iam#/policy/types/accessKeyActiveRecentlyUsed"
  note     = "AWS CIS v3.0.0 - Controls: 1.12"
  value    = "Force active if recently used <= 30 days"
}

# TODO - Need AWS > IAM > Access Key > Approved
# 1.13 Ensure there is only one active access key available for any single

# AWS > IAM > Access Key > Active > Age
resource "turbot_policy_setting" "aws_iam_access_key_active_age" {
  resource = turbot_smart_folder.aws_cis_v300_s1_iam.id
  type     = "tmod:@turbot/aws-iam#/policy/types/accessKeyActiveAge"
  note     = "AWS CIS v3.0.0 - Controls: 1.14"
  value    = "Force inactive if age > 90 days"
}


