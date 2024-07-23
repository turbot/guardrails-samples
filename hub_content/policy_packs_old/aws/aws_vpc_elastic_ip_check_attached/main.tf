# VPC Elastic IP Check for Unattached

resource "turbot_smart_folder" "vpc_elastic_ip_unattached" {
  title         = var.smart_folder_title
  description   = "Create a smart folder to check for an unattached elastic IP"
  parent        = "tmod:@turbot/turbot#/"
}

# Setting Elastic IP Active. This checks to see if the elastic ip is active 
# based on AWS > VPC > Elastic IP > Active > * policies

# AWS > VPC > Elastic IP > Active
# https://turbot.com/v5/mods/turbot/aws-vpc-internet/inspect#/policy/types/elasticIpActive
resource "turbot_policy_setting" "vpc_elasticip_active" {
    resource = turbot_smart_folder.vpc_elastic_ip.id
    type = "tmod:@turbot/aws-vpc-internet#/policy/types/elasticIpActive"
    value = "Check: Active"
}

# Setting Elastic IP Active Policies. This policy sets any elastic ip to inactive and is 
# subject to the the policy AWS > VPC > Elastic IP > Active policy setting

# AWS > VPC > Elastic IP > Active > Attached
# https://turbot.com/v5/mods/turbot/aws-vpc-internet/inspect#/policy/types/elasticIpActiveAttached
resource "turbot_policy_setting" "vpc_elasticip_active_attached" {
    resource = turbot_smart_folder.vpc_elastic_ip.id
    type = "tmod:@turbot/aws-vpc-internet#/policy/types/elasticIpActiveAttached"
    value = "Force inactive if unattached"
}