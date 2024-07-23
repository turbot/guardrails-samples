# GCP > IAM > Service Account Key > Approved
# https://turbot.com/v5/mods/turbot/gcp-iam/inspect#/policy/types/serviceAccountKeyApproved
# Alternative is to mark Service Account Keys unapproved
resource "turbot_policy_setting" "service_account_key_approved" {
  count    = var.enable_service_account_key_approved_policies ? 1 : 0
  resource = turbot_smart_folder.gcp_iam.id
  type     = "tmod:@turbot/gcp-iam#/policy/types/serviceAccountKeyApproved"
  value    = "Check: Approved"
  # "Skip"
  # "Check: Approved"
  # "Enforce: Delete unapproved if new"
}

## GCP > IAM > Service Account Key > Approved > Usage
## https://turbot.com/v5/mods/turbot/gcp-iam/inspect#/policy/types/serviceAccountKeyApprovedUsage
resource "turbot_policy_setting" "service_account_key_approved_usage" {
  count    = var.enable_service_account_key_approved_policies ? 1 : 0
  resource = turbot_smart_folder.gcp_iam.id
  type     = "tmod:@turbot/gcp-iam#/policy/types/serviceAccountKeyApprovedUsage"
  value    = "Not approved"
  # "Not approved"
  # "Approved"
  # "Approved if GCP > IAM > Enabled"
}
