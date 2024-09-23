# Create Smart Folder
resource "turbot_policy_pack" "gcp_enabled_baseline_pack" {
  parent = "tmod:@turbot/turbot#/"
  title  = "GCP Enabled Baseline Policies"
}

# Enable Service
# Loop through var.service_status and set enable policies
resource "turbot_policy_setting" "gcp_enable" {
  for_each = var.enabled_policy_map
  resource = turbot_policy_pack.gcp_enabled_baseline_pack.id
  type     = "tmod:@turbot/${each.key}#/policy/types/${each.value}"
  value    = "Enabled"
}

resource "turbot_policy_setting" "gcp_api_enable" {
  count    = length(var.service_status)
  resource = turbot_policy_pack.gcp_enabled_baseline_pack.id
  type     = "tmod:@turbot/${element(keys(var.service_status), count.index)}#/policy/types/${lookup(var.api_policy_map, "${element(keys(var.service_status), count.index)}")}"
  value    = "Enforce: ${lookup(var.service_status, "${element(keys(var.service_status), count.index)}")}"
}

# Here the "resource" is the AKA of the [Base Folder](../../guardrails/folder_hierarchy/) to which you want to attached the Policy Pack. 
# The base folder is created as part of script from [Base Folder](../../guardrails/folder_hierarchy/)
# The resource should be created first.
resource "turbot_policy_pack_attachment" "gcp_enable_attachment" {
  resource    = "base_folder"
  policy_pack = turbot_policy_pack.gcp_enabled_baseline_pack.id
}
