# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Enforce GCP Storage no publicly accessible buckets"
  description = "Enforce that no GCP Storage buckets within your GCP account are publicly accessible"
  parent      = "tmod:@turbot/turbot#/"
}

# GCP > Storage > Enabled
resource "turbot_policy_setting" "gcp_storage_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/gcp-storage#/policy/types/storageEnabled"
  value    = "Enabled"
}
