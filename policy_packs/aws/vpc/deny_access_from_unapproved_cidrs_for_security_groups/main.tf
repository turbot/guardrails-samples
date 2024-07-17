resource "turbot_policy_pack" "main" {
  title       = "Deny Access from Unapproved CIDRs for AWS VPC Security Groups"
  description = "Ensure that only traffic from trusted and authorized IP ranges can access your resources, reducing the risk of unauthorized access and potential attacks."
  akas        = ["aws_vpc_deny_access_from_unapproved_cidrs_for_security_groups"]
}
