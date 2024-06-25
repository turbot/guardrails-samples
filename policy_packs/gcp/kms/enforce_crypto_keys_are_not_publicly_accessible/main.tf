resource "turbot_smart_folder" "pack" {
  title       = "Enforce GCP KMS Cryptographic Keys Are Not Publicly Accessible"
  description = "Ensure crypto keys are only accessible to authorized users and services, thereby preventing potential data breaches and maintaining compliance."
  parent      = "tmod:@turbot/turbot#/"
}
