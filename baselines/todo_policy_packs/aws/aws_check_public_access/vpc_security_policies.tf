# AWS > VPC > Security Group > Ingress Rules > Approved > Rules -  https://turbot.com/v5/docs/guides/managing-policies/OCL#aws--vpc--security-group--ingress-rules--approved--rules
# OCL - https://turbot.com/v5/docs/reference/ocl

# Approve / Reject Security Group Ingress/Egress Rules

# AWS > VPC > Security Group > Ingress Rules > Approved
# https://turbot.com/v5/mods/turbot/aws-vpc-security/inspect#/policy/types/securityGroupIngressRulesApproved
resource "turbot_policy_setting" "aws_vpc_security_group_ingress_rule_approved" {
  resource = turbot_smart_folder.aws_public_access.id
  type     = "tmod:@turbot/aws-vpc-security#/policy/types/securityGroupIngressRulesApproved"
  value    = "Check: Approved"
  # "Skip"
  # "Check: Approved"
  # "Enforce: Delete unapproved"
}

# Example of a friendly Security Group Ingress policy to set approved CIDR Ranges
# Example is of internal IP ranges, RFC 1918

# AWS > VPC > Security Group > Ingress Rules > Approved > CIDR Ranges
# https://turbot.com/v5/mods/turbot/aws-vpc-security/inspect#/policy/types/securityGroupIngressRulesApprovedCidrRanges
resource "turbot_policy_setting" "aws_vpc_security_group_ingress_rule_approved_cidr_ranges" {
  resource = turbot_smart_folder.aws_public_access.id
  type     = "tmod:@turbot/aws-vpc-security#/policy/types/securityGroupIngressRulesApprovedCidrRanges"
  value    = <<-VALUE
      # RFC 1918
      - 10.0.0.0/8
      - 172.16.0.0/12
      - 192.168.0.0/16
      VALUE
}

# Mostly used are the Rules.  This provides an APPROVE REJECT syntax for granular policies
# Below REJECTS Port 22 and 3389 from IPv4 & V6 0.0.0.0/0 and ::/0. APPROVES everything else
# Example below aligns to AWS CIS 4.01 and 4.02

# AWS > VPC > Security Group > Ingress Rules > Approved > Rules
# https://turbot.com/v5/mods/turbot/aws-vpc-security/inspect#/policy/types/securityGroupIngressRulesApprovedRules
resource "turbot_policy_setting" "security_Group_IngressRules_ApprovedRules" {
  resource = turbot_smart_folder.aws_public_access.id
  type     = "tmod:@turbot/aws-vpc-security#/policy/types/securityGroupIngressRulesApprovedRules"
  value    = <<EOT
  REJECT $.turbot.ports.+:22,3389 $.turbot.cidr:0.0.0.0/0,::/0
  APPROVE *
EOT
}
