# Service Account Keys must every 90 days

# GCP > IAM > Service Account Key > Active
# https://turbot.com/v5/mods/turbot/gcp-iam/inspect#/policy/types/serviceAccountKeyActive
resource "turbot_policy_setting" "service_account_key_active" {
  count    = var.enable_service_account_key_active_policies ? 1 : 0
  resource = turbot_smart_folder.gcp_iam.id
  type     = "tmod:@turbot/gcp-iam#/policy/types/serviceAccountKeyActive"
  value    = "Check: Active"
          # "Skip"
          # "Check: Active"
          # "Enforce: Delete inactive with 1 day warning"
          # "Enforce: Delete inactive with 3 days warning"
          # "Enforce: Delete inactive with 7 days warning"
          # "Enforce: Delete inactive with 14 days warning"
          # "Enforce: Delete inactive with 30 days warning"
          # "Enforce: Delete inactive with 60 days warning"
          # "Enforce: Delete inactive with 90 days warning"
          # "Enforce: Delete inactive with 180 days warning"
          # "Enforce: Delete inactive with 365 days warning"
}

# GCP > IAM > Service Account Key > Active > Age
# https://turbot.com/v5/mods/turbot/gcp-iam/inspect#/policy/types/serviceAccountKeyActiveAge
resource "turbot_policy_setting" "service_account_key_active_age" {
  count    = var.enable_service_account_key_active_age_policies ? 1 : 0
  resource = turbot_smart_folder.gcp_iam.id
  type     = "tmod:@turbot/gcp-iam#/policy/types/serviceAccountKeyActiveAge"
  value    = "Force inactive if age > 90 days"
          # "Skip"
          # "Force inactive if age > 1 day"
          # "Force inactive if age > 3 days"
          # "Force inactive if age > 7 days"
          # "Force inactive if age > 14 days"
          # "Force inactive if age > 30 days"
          # "Force inactive if age > 60 days"
          # "Force inactive if age > 90 days"
          # "Force inactive if age > 180 days"
          # "Force inactive if age > 365 days"
}

## GCP > IAM > Service Account Key > Approved
## https://turbot.com/v5/mods/turbot/gcp-iam/inspect#/policy/types/serviceAccountKeyApproved
# # Alternative is to mark Service Account Keys unapproved
# resource "turbot_policy_setting" "service_account_key_approved" {
#   count    = var.service_account_key_approved_policies ? 1 : 0
#   resource = turbot_smart_folder.gcp_iam.id
#   type     = "tmod:@turbot/gcp-iam#/policy/types/serviceAccountKeyApproved"
#   value    = "Check: Approved"
#           # "Skip"
#           # "Check: Approved"
#           # "Enforce: Delete unapproved if new"
# }

## GCP > IAM > Service Account Key > Approved > Usage
## https://turbot.com/v5/mods/turbot/gcp-iam/inspect#/policy/types/serviceAccountKeyApprovedUsage
# resource "turbot_policy_setting" "service_account_key_approved_usage" {
#   count    = var.service_account_key_approved_usage_policies ? 1 : 0
#   resource = turbot_smart_folder.gcp_iam.id
#   type     = "tmod:@turbot/gcp-iam#/policy/types/serviceAccountKeyApprovedUsage"
#   value    = "Not approved"
#           # "Not approved"
#           # "Approved"
#           # "Approved if GCP > IAM > Enabled"
# }