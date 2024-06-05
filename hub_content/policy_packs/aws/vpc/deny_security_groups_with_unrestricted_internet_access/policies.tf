# AWS > VPC > Security Group > Ingress Rules > Approved
resource "turbot_policy_setting" "aws_vpc_security_group_ingress_rules_approved" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-vpc-security#/policy/types/securityGroupIngressRulesApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved"
}

# AWS > VPC > Security Group > Ingress Rules > Approved > Rules
resource "turbot_policy_setting" "aws_vpc_security_group_ingress_rules_approved_rules" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-vpc-security#/policy/types/securityGroupIngressRulesApprovedRules"
  template = <<-EOT
    {#- Reject ports 21(FTP), 22(SSH), 25(SMTP), 80(HTTP), 443(HTTPS), 3389(RDP) -#}
    REJECT $.turbot.fromPort:="21" $.turbot.toPort:="21"

    REJECT $.turbot.fromPort:="22" $.turbot.toPort:="22"

    REJECT $.turbot.fromPort:="25" $.turbot.toPort:="25"

    REJECT $.turbot.fromPort:="80" $.turbot.toPort:="80"

    REJECT $.turbot.fromPort:="443" $.turbot.toPort:="443"

    REJECT $.turbot.fromPort:="3389" $.turbot.toPort:="3389"

    {#- Approve unmatched rules -#}
    APPROVE *
    EOT
}
