# AWS > VPC > Security Group > Ingress Rules > Approved 
resource "turbot_policy_setting" "aws_vpc_security_group_ingress_rules_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-vpc-security#/policy/types/securityGroupIngressRulesApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved"
}

# AWS > VPC > Security Group > Ingress Rules > Approved > Rules
resource "turbot_policy_setting" "aws_vpc_security_group_ingress_rules_approved_rules" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/aws-vpc-security#/policy/types/securityGroupIngressRulesApprovedRules"
  template_input = <<-EOT
    {   
      resource {
        name: get(path: "GroupName")
      }
    }
  EOT
  template       = <<-EOT
    {%- if $.resource.name == "default" -%}

      REJECT *

    {%- endif -%}
  EOT
}

# AWS > VPC > Security Group > Egress Rules > Approved
resource "turbot_policy_setting" "aws_vpc_security_group_egress_rules_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-vpc-security#/policy/types/securityGroupEgressRulesApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved"
}

# AWS > VPC > Security Group > Egress Rules > Approved > Rules
resource "turbot_policy_setting" "aws_vpc_security_group_egress_rules_approved_rules" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/aws-vpc-security#/policy/types/securityGroupEgressRulesApprovedRules"
  template_input = <<-EOT
    {   
      resource {
        name: get(path: "GroupName")
      }
    }
  EOT
  template       = <<-EOT
    {%- if $.resource.name == "default" -%}

      REJECT *

    {%- endif -%}
  EOT
}