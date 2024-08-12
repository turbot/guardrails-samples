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
