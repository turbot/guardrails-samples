# AWS > Turbot > Service Roles
resource "turbot_policy_setting" "aws_turbot_service_roles" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/serviceRoles"
  value    = "Check: Configured"
  # value    = "Enforce: Configured"
}

# AWS > Turbot > Service Roles > Configurtation Recording
resource "turbot_policy_setting" "aws_turbot_service_roles_configuration_recording" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/serviceRolesConfigurationRecording"
  value    = "Enabled"
}

# AWS > Turbot > Service Roles > Default EC2 Instance
resource "turbot_policy_setting" "aws_turbot_service_role_default_ec2_instance" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/serviceRolesDefaultEc2Instance"
  value    = "Enabled"
}

# AWS > Turbot > Service Roles > Flow Logging
resource "turbot_policy_setting" "aws_turbot_service_role_flow_logging" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/serviceRolesFlowLogging"
  value    = "Enabled"
}

# AWS > Turbot > Service Roles > SSM Notifications
resource "turbot_policy_setting" "aws_turbot_service_role_ssm_notifications" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/serviceRolesSsmNotifications"
  value    = "Enabled"
}

# AWS > Turbot > Service Roles > Event Handlers [Global]
resource "turbot_policy_setting" "aws_turbot_service_role_event_handlers_global" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/serviceRolesEventHandlersGlobal"
  value    = "Enabled"
}
