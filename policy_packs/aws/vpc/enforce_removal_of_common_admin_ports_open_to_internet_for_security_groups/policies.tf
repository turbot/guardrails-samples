# AWS > VPC > Security Group > Ingress Rules > Approved
resource "turbot_policy_setting" "aws_vpc_security_security_group_ingress_rules_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-vpc-security#/policy/types/securityGroupIngressRulesApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved"
}

# AWS > VPC > Security Group > Ingress Rules > Approved > Rules
resource "turbot_policy_setting" "aws_vpc_security_security_group_ingress_rules_approved_rules" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-vpc-security#/policy/types/securityGroupIngressRulesApprovedRules"
  value    = <<-EOT
    # Reject port 22 from internet
    REJECT $.turbot.fromPort:<=22 $.turbot.toPort:>=22 $.turbot.cidr:0.0.0.0/0,::/0
    REJECT $.turbot.fromPort:<=3389 $.turbot.toPort:>=3389 $.turbot.cidr:0.0.0.0/0,::/0
    REJECT $.turbot.portRangeSize:-1  $.turbot.cidr:0.0.0.0/0,::/0

    # APPROVE unmatched rules
    APPROVE *
    EOT
}
