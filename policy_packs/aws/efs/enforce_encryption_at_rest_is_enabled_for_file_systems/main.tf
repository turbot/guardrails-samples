resource "turbot_smart_folder" "main" {
  title       = "Enforce Encryption at Rest is Enabled for AWS EFS File Systems"
  description = "Ensure that all data stored within file systems is encrypted, protecting it from unauthorized access and potential data breaches."
  parent      = "tmod:@turbot/turbot#/"
}
