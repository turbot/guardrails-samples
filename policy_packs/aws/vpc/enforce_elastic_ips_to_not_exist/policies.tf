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

# AWS > VPC > Elastic IP > Active
resource "turbot_policy_setting" "aws_vpc_elastic_ip_active" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-vpc-internet#/policy/types/elasticIpActive"
  value    = "Check: Active"
  # value    = "Enforce: Delete inactive with 7 days warning"
}

# AWS > VPC > Elastic IP > Active > Age
resource "turbot_policy_setting" "aws_vpc_elastic_ip_active_age" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-vpc-internet#/policy/types/elasticIpActiveAge"
  value    = "Force inactive if age > 1 day"
}