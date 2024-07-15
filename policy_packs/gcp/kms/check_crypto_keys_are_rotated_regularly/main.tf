resource "turbot_policy_pack" "main" {
  title       = "Check If GCP KMS Crypto Keys Are Rotated Regularly"
  description = "Mitigate the risk of key compromise, ensuring that even if a key is exposed, its usage window is limited, thereby enhancing the overall security posture."
}
