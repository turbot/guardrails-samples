# Azure > Storage > Container > Public Access Level
resource "turbot_policy_setting" "azure_storage_container_public_access_level" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-storage#/policy/types/containerPublicAccessLevel"
  note     = "Azure CIS v2.0.0 - Control: 5.1.3"
  value    = "Check: Private (No anonymous access)"
  # value    = "Enforce: Private (No anonymous access)"
}