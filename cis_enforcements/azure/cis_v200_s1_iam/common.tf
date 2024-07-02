# Smart Folder
resource "turbot_smart_folder" "azure_cis_v200_s1_iam" {
  parent      = "tmod:@turbot/turbot#/"
  title       = "Azure CIS v2.0.0 - Section 1 - Identity and Access Management"
  description = "This section contains recommendations for configuring Azure Identity and Access Management features."
}

# Azure > IAM > Enabled
resource "turbot_policy_setting" "azure_iam_enabled" {
  resource = turbot_smart_folder.azure_cis_v200_s1_iam.id
  type     = "tmod:@turbot/aws-iam#/policy/types/iamEnabled"
  value    = "Enabled"
}
