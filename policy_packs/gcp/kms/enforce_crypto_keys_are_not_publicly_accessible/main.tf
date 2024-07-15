resource "turbot_policy_pack" "main" {
  title       = "Enforce GCP KMS Cryptographic Keys Are Not Publicly Accessible"
  description = "Ensure crypto keys are only accessible to authorized users and services, thereby preventing potential data breaches and maintaining compliance."
  akas        = ["gcp_kms_enforce_crypto_keys_are_not_publicly_accessible"]
}
