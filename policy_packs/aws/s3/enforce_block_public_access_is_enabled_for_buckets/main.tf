resource "turbot_smart_folder" "pack" {
  title       = "Enforce Block Public Access Is Enabled for AWS S3 Buckets"
  description = "Prevent unintended exposure of sensitive data to the public internet for S3 buckets."
  parent      = "tmod:@turbot/turbot#/"
}
