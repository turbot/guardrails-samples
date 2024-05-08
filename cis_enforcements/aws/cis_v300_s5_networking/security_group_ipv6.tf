# AWS > VPC > Security Group > Ingress Rules > Approved
resource "turbot_policy_setting" "aws_vpc_security_group_ingress_rules_approved_ipv6" {
  resource = turbot_smart_folder.aws_cis_v300_s5_networking.id
  type     = "tmod:@turbot/aws-vpc-security#/policy/types/securityGroupIngressRulesApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved"
  note     = "AWS CIS v3.0.0 - Controls: 5.3"
}

# AWS > VPC > Security Group > Ingress Rules > Approved > Rules
resource "turbot_policy_setting" "aws_vpc_security_group_ingress_rules_approved_rules_ipv6" {
  resource = turbot_smart_folder.aws_cis_v300_s5_networking.id
  type     = "tmod:@turbot/aws-vpc-security#/policy/types/securityGroupIngressRulesApprovedRules"
  value    = <<-EOT
    # Reject port range sizes -1 (all traffic)
    REJECT \
      $.turbot.portRangeSize:-1 \
      $.turbot.cidr:::/0

    # Reject prohibited ports
    REJECT \
      $.turbot.ports.+:22,3389 \
      $.IpProtocol:tcp,udp \
      $.turbot.cidr:::/0
    # Approve any unmatched rules
    APPROVE *
    EOT
  note     = "AWS CIS v3.0.0 - Controls: 5.3"
}