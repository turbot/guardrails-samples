# AWS > VPC > Security Group > Ingress Rules > Approved
resource "turbot_policy_setting" "aws_vpc_security_security_group_ingress_rules_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-vpc-security#/policy/types/securityGroupIngressRulesApproved"
  value    = "Check: Approved"
  # value   = "Enforce: Delete unapproved"
}

# AWS > VPC > Security Group > Ingress Rules > Approved > Rules
resource "turbot_policy_setting" "aws_vpc_security_security_group_ingress_rules_approved_rules" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-vpc-security#/policy/types/securityGroupIngressRulesApprovedRules"
  value    = <<-EOT
    # Allow ports 22,443,3389 from individual IP addresses (bitmask = 32)
    APPROVE $.turbot.fromPort:=22 $.turbot.toPort:=22 $.turbot.bitmaskLength:>=32
    APPROVE $.turbot.fromPort:=443 $.turbot.toPort:=443 $.turbot.bitmaskLength:>=32
    APPROVE $.turbot.fromPort:=3389 $.turbot.toPort:=3389 $.turbot.bitmaskLength:>=32

    # List of CIDRs (RFC 1918) that are approved for use
    APPROVE $.turbot.cidr:<=10.0.0.0/8
    APPROVE $.turbot.cidr:<=172.16.0.0/12
    APPROVE $.turbot.cidr:<=192.168.0.0/16

    # Reject unmatched rules
    REJECT *
  EOT
}
