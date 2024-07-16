resource "turbot_policy_pack" "main" {
  title       = "Enforce Encryption in Transit for Azure Storage Accounts"
  description = "Ensure that sensitive information remains confidential and secure while being transferred between clients and storage services, mitigating risks of data breaches and enhancing overall security compliance."
  akas        = ["azure_storage_enforce_encryption_in_transit_for_storage_accounts"]
}
