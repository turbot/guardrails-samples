# Smart Folder
resource "turbot_smart_folder" "azure_cis_v200_s2_microsoft_defender" {
  parent      = "tmod:@turbot/turbot#/"
  title       = "Azure CIS v2.0.0 - Section 2 - Microsoft Defender"
  description = "This section contains recommendations for configuring Azure Microsoft Defender features."
}

# Azure > Security Center > Enabled
resource "turbot_policy_setting" "azure_securitycenter_enabled" {
  resource = turbot_smart_folder.azure_cis_v200_s2_microsoft_defender.id
  type     = "tmod:@turbot/azure-securitycenter#/policy/types/securityCenterServiceEnabled"
  value    = "Enabled"
}
