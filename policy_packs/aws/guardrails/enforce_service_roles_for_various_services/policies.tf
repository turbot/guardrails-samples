# AWS > Turbot > Service Roles
resource "turbot_policy_setting" "turbot_serviceroles_configured" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/serviceRoles"
  value    = "Check: Configured"
  # value    = "Enforce: Configured"
}

# AWS > Turbot > Service Roles > Configurtation Recording
resource "turbot_policy_setting" "turbot_cr_configured" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/serviceRolesConfigurationRecording"
  value    = "Enabled"
}

# AWS > Turbot > Service Roles > Default EC2 Instance
resource "turbot_policy_setting" "turbot_sr_defaultec2" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/serviceRolesDefaultEc2Instance"
  value    = "Enabled"
}

# AWS > Turbot > Service Roles > Flow Logging
resource "turbot_policy_setting" "turbot_sr_flowlogs" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/serviceRolesFlowLogging"
  value    = "Enabled"
}