# No Elastic IPs (EIPs) should exist in the account, unless approved for use

# AWS > VPC > Elastic IP > Approved
# https://turbot.com/v5/mods/turbot/aws-vpc-internet/inspect#/policy/types/elasticIpApproved
resource "turbot_policy_setting" "aws_vpc_elastic_ip_approved" {
  count    = var.enable_aws_vpc_elastic_ip_approved ? 1 : 0
  resource = turbot_smart_folder.aws_public_access.id
  type     = "tmod:@turbot/aws-vpc-internet#/policy/types/elasticIpApproved"
  value    = "Check: Approved"
}

# AWS > VPC > Elastic IP > Approved > Usage
# https://turbot.com/v5/mods/turbot/aws-vpc-internet/inspect#/policy/types/elasticIpApprovedUsage
resource "turbot_policy_setting" "aws_vpc_elastic_ip_approved_usage" {
  count    = var.enable_aws_vpc_elastic_ip_approved_usage ? 1 : 0
  resource = turbot_smart_folder.aws_public_access.id
  type     = "tmod:@turbot/aws-vpc-internet#/policy/types/elasticIpApprovedUsage"
  value    = "Not approved"
}
