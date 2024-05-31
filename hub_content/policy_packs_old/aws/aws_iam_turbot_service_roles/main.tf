# Create smart folder for policies
resource "turbot_smart_folder" "turbot_service_roles" {
    title       = var.smart_folder_title
    description = "Policies to check if Configuration Recording role, EC2 default role, and Flow logging role exist in attached accounts." 
    parent      = "tmod:@turbot/turbot#/"
}

# AWS > Turbot > Service Roles
# Check if the below roles are configured
resource "turbot_policy_setting" "turbot_serviceroles_configured" {
    resource = turbot_smart_folder.turbot_service_roles.id
    type = "tmod:@turbot/aws#/policy/types/serviceRoles"
    value = "Check: Configured"
}

# Turbot Config Recorder Role
# AWS > Turbot > Service Roles > Configurtation Recording
resource "turbot_policy_setting" "turbot_cr_configured" {
    resource = turbot_smart_folder.turbot_service_roles.id
    type = "tmod:@turbot/aws#/policy/types/serviceRolesConfigurationRecording"
    value = "Enabled"
}


# Turbot Default EC2 Instance Role
# AWS > Turbot > Service Roles > Default EC2 Instance 
resource "turbot_policy_setting" "turbot_sr_defaultec2" {
    resource = turbot_smart_folder.turbot_service_roles.id
    type = "tmod:@turbot/aws#/policy/types/serviceRolesDefaultEc2Instance"
    value = "Enabled"
}

# Turbot Default VPC Flow Log Role
# AWS > Turbot > Service Roles > Flow Logging 
resource "turbot_policy_setting" "turbot_sr_flowlogs" {
    resource = turbot_smart_folder.turbot_service_roles.id
    type = "tmod:@turbot/aws#/policy/types/serviceRolesFlowLogging"
    value = "Enabled"
}
