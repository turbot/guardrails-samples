# OCI > Storage > Bucket > Allowed > Region
resource "turbot_policy_setting" "oci_storage_bucket_allowed_region" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/oci-storage#/policy/types/bucketAllowedRegion"
  value    = "Check: Allowed region"
}

# OCI > Storage > Bucket > Allowed > Region > Regions
resource "turbot_policy_setting" "oci_storage_bucket_allowed_region_regions" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/oci-storage#/policy/types/bucketAllowedRegionRegions"
  # A list of OCI region names, e.g., us-ashburn-1. The '*' and '?' wildcards are supported.
  value = <<-EOT
    - "us-ashburn-1"
    - "us-phoenix-1"
    EOT
}
