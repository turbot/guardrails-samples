resource "turbot_smart_folder" "pack" {
  title       = "Enforce Block Public Access Is Enabled for AWS S3 Accounts"
  description = "Prevent unintended exposure of sensitive data to the public internet for S3 accounts."
  parent      = "tmod:@turbot/turbot#/"
}
