# AWS > VPC > Network ACL > Ingress Rules > Approved
resource "turbot_policy_setting" "aws_vpc_network_acl_ingress_rules_approved" {
  resource = turbot_smart_folder.aws_cis_v300_s5_networking.id
  type     = "tmod:@turbot/aws-vpc-security#/policy/types/networkAclIngressRulesApproved"
  note     = "AWS CIS v3.0.0 - Controls: 5.1"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved"
}

# AWS > VPC > Network ACL > Ingress Rules > Approved > Rules
resource "turbot_policy_setting" "aws_vpc_network_acl_ingress_rules_approved_rules" {
  resource = turbot_smart_folder.aws_cis_v300_s5_networking.id
  type     = "tmod:@turbot/aws-vpc-security#/policy/types/networkAclIngressRulesApprovedRules"
  note     = "AWS CIS v3.0.0 - Controls: 5.1"
  value    = <<-EOT
    # Reject port range sizes -1 (all traffic)
    REJECT \
      $.turbot.portRangeSize:-1 \
      $.turbot.cidr:0.0.0.0/0

    # Reject prohibited ports
    REJECT \
      $.turbot.ports.+:22,3389 \
      $.IpProtocol:tcp,udp \
      $.turbot.cidr:0.0.0.0/0
    # Approve any unmatched rules
    APPROVE *
    EOT
}