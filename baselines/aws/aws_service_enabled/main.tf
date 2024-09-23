# Create Baselines Policy Pack
resource "turbot_policy_pack" "aws_enabled_baseline_pack" {
  parent = "tmod:@turbot/turbot#/"
  title  = "AWS Enabled Baseline Policies"
}

# Enable all AWS Services
# Loop through var.service_status and set enable policies
resource "turbot_policy_setting" "aws_enable" {
  for_each = var.enabled_policy_map
  resource = turbot_policy_pack.aws_enabled_baseline_pack.id
  type     = "tmod:@turbot/${each.key}#/policy/types/${each.value}"
  value    = "Enabled"
}

# Here the "resource" is the AKA of the [Base Folder](../../guardrails/folder_hierarchy/) to which you want to attached the Policy Pack. 
# The base folder is created as part of script from [Base Folder](../../guardrails/folder_hierarchy/)
# The resource should be created first.
resource "turbot_policy_pack_attachment" "aws_enable_attachment" {
  resource    = "base_folder"
  policy_pack = turbot_policy_pack.aws_enabled_baseline_pack.id
}
