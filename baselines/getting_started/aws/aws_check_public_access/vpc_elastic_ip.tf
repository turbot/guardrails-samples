# No Elastic IPs (EIPs) should exist in the account, unless approved for use

resource "turbot_policy_setting" "aws_vpc_elastic_ip_approved" {
    resource        = turbot_smart_folder.aws_public_access.id
    type            = "tmod:@turbot/aws-vpc-internet#/policy/types/elasticIpApproved"
    value           = "Check: Approved"
}

resource "turbot_policy_setting" "aws_vpc_elastic_ip_approved_usage" {
    resource        = turbot_smart_folder.aws_public_access.id
    type            = "tmod:@turbot/aws-vpc-internet#/policy/types/elasticIpApprovedUsage"
    value           = "Not approved"
}
