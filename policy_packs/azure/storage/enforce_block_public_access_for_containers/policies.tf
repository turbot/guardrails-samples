# Azure > Storage > Container > Public Access Level
resource "turbot_policy_setting" "azure_storage_container_public_access_level" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-storage#/policy/types/containerPublicAccessLevel"
  value    = "Check: Private (No anonymous access)"
  # value    = "Enforce: Private (No anonymous access)"
}
