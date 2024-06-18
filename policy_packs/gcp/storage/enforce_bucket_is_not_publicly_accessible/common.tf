# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Enforce GCP Storage Buckets Are Not Publicly Accessible"
  description = "Ensure that GCP storage buckets are not publicly accessible."
  parent      = "tmod:@turbot/turbot#/"
}

# GCP > Storage > Enabled
resource "turbot_policy_setting" "gcp_storage_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/gcp-storage#/policy/types/storageEnabled"
  value    = "Enabled"
}
