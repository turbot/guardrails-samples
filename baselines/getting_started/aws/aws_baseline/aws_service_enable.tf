# Enable all AWS Services within the Variables file
# More Info: https://turbot.com/v5/docs/integrations/aws/services

variable "enabled_policy_map" {
  description = "Enter the list of services that you would like to Enable"
  type        = map
}

#Loop through var.service_status and set enable policies
resource "turbot_policy_setting" "aws_enable" {
  for_each = var.enabled_policy_map
  resource = turbot_smart_folder.aws_baseline.id
  type     = "tmod:@turbot/${each.key}#/policy/types/${each.value}"
  value    = "Enabled"
}
