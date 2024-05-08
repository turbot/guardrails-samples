# AWS > VPC > Security Group > Ingress Rules > Approved
resource "turbot_policy_setting" "aws_vpc_security_group_ingress_rules_approved" {
  resource = turbot_smart_folder.aws_cis_v300_s5_networking.id
  type     = "tmod:@turbot/aws-vpc-security#/policy/types/securityGroupIngressRulesApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved"
  note     = "AWS CIS v3.0.0 - Controls: 5.4"
}

# AWS > VPC > Security Group > Ingress Rules > Approved > Rules
resource "turbot_policy_setting" "aws_vpc_security_group_ingress_rules_approved_rules" {
  resource = turbot_smart_folder.aws_cis_v300_s5_networking.id
  type     = "tmod:@turbot/aws-vpc-security#/policy/types/securityGroupIngressRulesApprovedRules"
  note     = "AWS CIS v3.0.0 - Controls: 5.4"
  template_input = <<-EOT
    {
      value: constant(value: "REJECT *")
      securityGroup {
        GroupName: get(path: "GroupName")
        IpPermissions: get(path: "IpPermissions")
      }
    }
    EOT
  template       = <<-EOT
    {%- if $.securityGroup.GroupName == "default" and $.securityGroup.IpPermissions | length > 0 -%}
    {{ $.value }}
    {%- endif %}
    EOT
}

# AWS > VPC > Security Group > Egress Rules > Approved
resource "turbot_policy_setting" "aws_vpc_security_group_egress_rules_approved" {
  resource = turbot_smart_folder.aws_cis_v300_s5_networking.id
  type     = "tmod:@turbot/aws-vpc-security#/policy/types/securityGroupEgressRulesApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved"
  note     = "AWS CIS v3.0.0 - Controls: 5.4"
}

# AWS > VPC > Security Group > Egress Rules > Approved > Rules
resource "turbot_policy_setting" "aws_vpc_security_group_egress_rules_approved_rules" {
  resource = turbot_smart_folder.aws_cis_v300_s5_networking.id
  type     = "tmod:@turbot/aws-vpc-security#/policy/types/securityGroupEgressRulesApprovedRules"
  note     = "AWS CIS v3.0.0 - Controls: 5.4"
  template_input = <<-EOT
    {
      value: constant(value: "REJECT *")
      securityGroup {
        GroupName: get(path: "GroupName")
        IpPermissionsEgress: get(path: "IpPermissionsEgress")
      }
    }
    EOT
  template       = <<-EOT
    {%- if $.securityGroup.GroupName == "default" and $.securityGroup.IpPermissionsEgress | length > 0 -%}
    {{ $.value }}
    {%- endif %}
    EOT
}