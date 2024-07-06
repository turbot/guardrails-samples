# AWS > VPC > Network ACL > Ingress Rules > Approved
resource "turbot_policy_setting" "aws_vpc_network_acl_ingress_rules_approved" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/aws-vpc-security#/policy/types/networkAclIngressRulesApproved"
  note     = "AWS CIS v3.0.0 - Controls: 5.1"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved"
}

# AWS > VPC > Network ACL > Ingress Rules > Approved > Rules
resource "turbot_policy_setting" "aws_vpc_network_acl_ingress_rules_approved_rules" {
  resource = turbot_smart_folder.main.id
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

# AWS > VPC > Security Group > Ingress Rules > Approved
resource "turbot_policy_setting" "aws_vpc_security_group_ingress_rules_approved" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/aws-vpc-security#/policy/types/securityGroupIngressRulesApproved"
  note     = "AWS CIS v3.0.0 - Controls: 5.2, 5.3, 5.4"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved"
}

# AWS > VPC > Security Group > Ingress Rules > Approved > Rules
resource "turbot_policy_setting" "aws_vpc_security_group_ingress_rules_approved_rules" {
  resource       = turbot_smart_folder.main.id
  type           = "tmod:@turbot/aws-vpc-security#/policy/types/securityGroupIngressRulesApprovedRules"
  note           = "AWS CIS v3.0.0 - Controls: 5.2, 5.3, 5.4"
  template_input = <<-EOT
    {
      securityGroup {
        GroupName: get(path: "GroupName")
        IpPermissions: get(path: "IpPermissions")
      }
    }
    EOT
  template       = <<-EOT
    {%- if $.securityGroup.GroupName == "default" and $.securityGroup.IpPermissions | length > 0 -%}
    REJECT *
    {%- else -%}
    # Reject all ingress from 0.0.0.0/0 and ::/0 to remote server admin ports
    REJECT $.turbot.portRangeSize:-1 $.turbot.cidr:0.0.0.0/0

    REJECT $.turbot.portRangeSize:-1 $.turbot.cidr:::/0

    REJECT $.turbot.ports.+:22,3389 $.IpProtocol:tcp,udp $.turbot.cidr:0.0.0.0/0

    REJECT $.turbot.ports.+:22,3389 $.IpProtocol:tcp,udp $.turbot.cidr:::/0

    APPROVE *
    {%- endif %}
    EOT
}

# AWS > VPC > Security Group > Egress Rules > Approved
resource "turbot_policy_setting" "aws_vpc_security_group_egress_rules_approved" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/aws-vpc-security#/policy/types/securityGroupEgressRulesApproved"
  note     = "AWS CIS v3.0.0 - Controls: 5.4"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved"
}

# AWS > VPC > Security Group > Egress Rules > Approved > Rules
resource "turbot_policy_setting" "aws_vpc_security_group_egress_rules_approved_rules" {
  resource       = turbot_smart_folder.main.id
  type           = "tmod:@turbot/aws-vpc-security#/policy/types/securityGroupEgressRulesApprovedRules"
  note           = "AWS CIS v3.0.0 - Controls: 5.4"
  template_input = <<-EOT
    {
      securityGroup {
        GroupName: get(path: "GroupName")
        IpPermissionsEgress: get(path: "IpPermissionsEgress")
      }
    }
    EOT
  template       = <<-EOT
    {%- if $.securityGroup.GroupName == "default" and $.securityGroup.IpPermissionsEgress | length > 0 -%}
    REJECT *
    {%- endif %}
    EOT
}
