# GCP > IAM > Service Account Key > Active
resource "turbot_policy_setting" "gcp_iam_service_account_key_active" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-iam#/policy/types/serviceAccountKeyActive"
  value    = "Check: Active"
  # value    =  "Enforce: Delete inactive with 90 days warning"
}

# GCP > IAM > Service Account Key > Active > Age
resource "turbot_policy_setting" "gcp_iam_service_account_active_age" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-iam#/policy/types/serviceAccountKeyActiveAge"
  value    = "Force inactive if age > 90 days"
}
