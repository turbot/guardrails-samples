# VPC Default VPC Check

resource "turbot_smart_folder" "vpc_default_vpc" {
  title         = var.smart_folder_title
  description   = "Create a smart folder to apply the s3 policy settings"
  parent        = "tmod:@turbot/turbot#/"
}

# Setting policy to see if default VPC exists
# AWS > VPC > Default VPC > Approved

resource "turbot_policy_setting" "vpc_default_vpc_approved" {
    resource = turbot_smart_folder.vpc_default_vpc.id
    type = "tmod:@turbot/aws-vpc-core#/policy/types/defaultVpcApproved"
    value = "Check: Approved"
}

# Setting policy to see if default VPC exists
# AWS > VPC > Default VPC > Approved > Usage

resource "turbot_policy_setting" "vpc_default_vpc_approved_usage" {
    resource = turbot_smart_folder.vpc_default_vpc.id
    type = "tmod:@turbot/aws-vpc-core#/policy/types/defaultVpcApprovedUsage"
    value = "Not approved"
}