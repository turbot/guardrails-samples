resource "turbot_smart_folder" "main" {
  title       = "Enforce Encryption in Transit Is Enabled for AWS S3 Buckets"
  description = "Encrypt data during transmission, safeguarding it from interception and unauthorized access."
  parent      = "tmod:@turbot/turbot#/"
}
