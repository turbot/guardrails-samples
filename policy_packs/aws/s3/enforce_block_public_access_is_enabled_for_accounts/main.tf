resource "turbot_policy_pack" "main" {
  title       = "Enforce Block Public Access Is Enabled for AWS S3 Accounts"
  description = "Prevent unintended exposure of sensitive data to the public internet for S3 accounts."
}
