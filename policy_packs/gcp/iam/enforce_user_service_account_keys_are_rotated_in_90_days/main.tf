resource "turbot_smart_folder" "main" {
  title       = "Enforce GCP IAM User-Managed Service Account Keys Are Rotated Every 90 Days"
  description = "Regular key rotation ensures that any potentially exposed or compromised keys are rendered obsolete."
  parent      = "tmod:@turbot/turbot#/"
}
