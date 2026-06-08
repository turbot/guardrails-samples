# Azure > AI Foundry > Account > Encryption at Rest
resource "turbot_policy_setting" "azure_aifoundry_account_encryption_at_rest" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-aifoundry#/policy/types/accountEncryptionAtRest"
  value    = "Check: Customer managed key"
  # value    = "Check: Microsoft managed key"
  # value    = "Enforce: Customer managed key"
  # value    = "Enforce: Microsoft managed key"
}

# Azure > AI Foundry > Account > Encryption at Rest > Customer Managed Key
#
# The customer managed key requires an environment-specific Key Vault key URL. The key must
# already exist in CMDB as an `Azure > Key Vault > Key` resource. Uncomment and set this to
# enable enforcement against a specific key.
#
# resource "turbot_policy_setting" "azure_aifoundry_account_encryption_at_rest_customer_managed_key" {
#   resource = turbot_policy_pack.main.id
#   type     = "tmod:@turbot/azure-aifoundry#/policy/types/accountEncryptionAtRestCustomerManagedKey"
#   value    = "https://my-key-vault.vault.azure.net/keys/my-key"
# }
