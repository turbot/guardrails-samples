# VPC Elastic IP Check 

resource "turbot_smart_folder" "vpc_elastic_ip" {
  title         = var.smart_folder_title
  description   = "Create a smart folder to check the existence of an elastic IP"
  parent        = "tmod:@turbot/turbot#/"
}

# Setting Elastic IP Approved. This checks to see if the elastic ip is approved 
# based on AWS > VPC > Elastic IP > Approved > * policies

# AWS > VPC > Elastic IP > Approved

resource "turbot_policy_setting" "vpc_elasticip_approved" {
    resource = turbot_smart_folder.vpc_elastic_ip.id
    type = "tmod:@turbot/aws-vpc-internet#/policy/types/elasticIpApproved"
    value = "Check: Approved"
}

# Setting Elastic IP Approved Policies. This policy sets any elastic ip to Not approved and is 
# subject to the the policy AWS > VPC > Elastic IP > Approved policy setting

# AWS > VPC > Elastic IP > Approved > Usage

resource "turbot_policy_setting" "vpc_elasticip_approved_usage" {
    resource = turbot_smart_folder.vpc_elastic_ip.id
    type = "tmod:@turbot/aws-vpc-internet#/policy/types/elasticIpApprovedUsage"
    value = "Not approved"
}