
# AWS > IAM > Access Key > Active
resource "turbot_policy_setting" "aws_iam_access_key_active" {
  resource = turbot_smart_folder.aws_cis_v300_s1_iam.id
  type     = "tmod:@turbot/aws-iam#/policy/types/accessKeyActive"
  value    = "Check: Active"
  # value    = "Enforce: Deactivate inactive with 14 days warning"
  note     = "AWS CIS v3.0.0 - Controls: 1.12 & 1.14"
}

# AWS > IAM > Access Key > Active > Last Modified
resource "turbot_policy_setting" "aws_iam_access_key_active_last_modified" {
  resource = turbot_smart_folder.aws_cis_v300_s1_iam.id
  type     = "tmod:@turbot/aws-iam#/policy/types/accessKeyActiveLastModified"
  value    = "Force active if last modified <= 7 days"
  note     = "Prevent's newly created access keys from being deleted for not having been used recently."
}

# AWS > IAM > Access Key > Active > Recently Used
resource "turbot_policy_setting" "aws_iam_access_key_active_recently_used" {
  resource = turbot_smart_folder.aws_cis_v300_s1_iam.id
  type     = "tmod:@turbot/aws-iam#/policy/types/accessKeyActiveRecentlyUsed"
  value    = "Force active if recently used <= 30 days"
  note     = "AWS CIS v3.0.0 - Controls: 1.12"
}

## TODO - Need AWS > IAM > Access Key > Approved
## 1.13 Ensure there is only one active access key available for any single

# AWS > IAM > Access Key > Active > Age
resource "turbot_policy_setting" "aws_iam_access_key_active_age" {
  resource = turbot_smart_folder.aws_cis_v300_s1_iam.id
  type     = "tmod:@turbot/aws-iam#/policy/types/accessKeyActiveAge"
  value    = "Force inactive if age > 90 days"
  note     = "AWS CIS v3.0.0 - Controls: 1.14"
}


