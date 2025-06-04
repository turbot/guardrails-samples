resource "turbot_policy_pack" "main" {
  title       = "Enforce AWS VPC Security Group Rules with Time-Limited Exceptions"
  description = "Temporarily apply controlled security group rules to AWS VPCs with automatic expiration for maintenance windows and compliance automation."
  akas        = ["aws_vpc_enforce_sg_rules_time_limited"]
}
