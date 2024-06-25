resource "turbot_smart_folder" "pack" {
  title       = "Check If GCP KMS Crypto Keys Are Rotated Regularly"
  description = "Mitigate the risk of key compromise, ensuring that even if a key is exposed, its usage window is limited, thereby enhancing the overall security posture."
  parent      = "tmod:@turbot/turbot#/"
}
