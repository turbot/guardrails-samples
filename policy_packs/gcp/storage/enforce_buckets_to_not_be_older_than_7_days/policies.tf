# GCP > Storage > Bucket > Active
resource "turbot_policy_setting" "gcp_storage_bucket_active" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-storage#/policy/types/bucketActive"
  value    = "Check: Active"
  # value    = "Enforce: Delete inactive with 7 days warning"
}

# GCP > Storage > Bucket > Active > Age
resource "turbot_policy_setting" "gcp_storage_bucket_active_age" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-storage#/policy/types/bucketActiveAge"
  value    = "Force inactive if age > 7 days"
}
