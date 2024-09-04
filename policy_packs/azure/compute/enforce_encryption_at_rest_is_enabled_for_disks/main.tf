resource "turbot_policy_pack" "main" {
  title       = "Enforce Encryption at Rest is Enabled for Azure Compute Disks"
  description = "Ensures that data remains confidential and secure, even if the physical storage media is compromised."
  akas        = ["azure_compute_enforce_encryption_at_rest_is_enabled_for_disks"]
}
