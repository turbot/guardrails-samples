# AWS > VPC > Elastic IP > Approved
resource "turbot_policy_setting" "vpc_elastic_ip_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-vpc-internet#/policy/types/elasticIpApproved"
  value    = "Check: Approved"
  # value = "Enforce: Delete unapproved if new"
}

# AWS > VPC > Elastic IP > Approved > Usage
resource "turbot_policy_setting" "vpc_elastic_ip_approved_usage" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-vpc-internet#/policy/types/elasticIpApprovedUsage"
  value    = "Not approved"
}
