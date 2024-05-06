
# AWS > IAM > Access Key > Active
resource "turbot_policy_setting" "aws_iam_access_key_active" {
  note     = <<-EOT
    AWS CIS v3.0.0 - Section 1 - IAM: |
      1.12 Ensure credentials unused for 45 days or greater are disabled. |
      1.14 Ensure access keys are rotated every 90 days or less.
    EOT
  resource = turbot_smart_folder.aws_cis_v300_s1_iam.id
  type     = "tmod:@turbot/aws-iam#/policy/types/accessKeyActive"
  value    = "Check: Active"
  # value    = "Enforce: Deactivate inactive with 14 days warning"
}

# AWS > IAM > Access Key > Active > Last Modified
resource "turbot_policy_setting" "aws_iam_access_key_active_last_modified" {
  note     = "Prevent's newly created access keys from being deleted for not having been used recently."
  resource = turbot_smart_folder.aws_cis_v300_s1_iam.id
  type     = "tmod:@turbot/aws-iam#/policy/types/accessKeyActiveLastModified"
  value    = "Force active if last modified <= 7 days"
}

# AWS > IAM > Access Key > Active > Recently Used
resource "turbot_policy_setting" "aws_iam_access_key_active_recently_used" {
  note     = <<-EOT
    AWS CIS v3.0.0 - Section 1 - IAM: |
      1.12 Ensure credentials unused for 45 days or greater are disabled |
      When combined with the 14 day warning on the Access Key Active control this == 45 days
    EOT
  resource = turbot_smart_folder.aws_cis_v300_s1_iam.id
  type     = "tmod:@turbot/aws-iam#/policy/types/accessKeyActiveRecentlyUsed"
  value    = "Force active if recently used <= 30 days"
}

## TODO - Need AWS > IAM > Access Key > Approved
## 1.13 Ensure there is only one active access key available for any single

# AWS > IAM > Access Key > Active > Age
resource "turbot_policy_setting" "aws_iam_access_key_active_age" {
  note     = <<-EOT
    AWS CIS v3.0.0 - Section 1 - IAM: |
      1.14 Ensure access keys are rotated every 90 days or less
    EOT
  resource = turbot_smart_folder.aws_cis_v300_s1_iam.id
  type     = "tmod:@turbot/aws-iam#/policy/types/accessKeyActiveAge"
  value    = "Force inactive if age > 90 days"
}


