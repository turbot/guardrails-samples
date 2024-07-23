# VPC Security Group Rules check 

resource "turbot_smart_folder" "vpc_sg_rule_check" {
  title         = var.smart_folder_title
  description   = "Create a smart folder and security group rule check policies"
  parent        = "tmod:@turbot/turbot#/"
}

# REJECTING 22, 3389 ingress from public internet 0.0.0.0/0 and ipv6 ::/0
# APPROVING rds default ports of 1433, 1521, 3306, 5432 from 10.0.0.0/8 are allowed
# APPROVING 80 and 443 are allowed egress to 0.0.0.0/0 but nothing else
# Also AWS CIS v1.2 Section 4.01 Ensure no security groups allow ingress from 0.0.0.0/0 to port 22 (Scored) and # 4.02 Ensure no security groups allow ingress from 0.0.0.0/0 to port 3389 (Scored)

# resource "turbot_policy_setting" "security_group_ingress_rules_approved_rules"{
#   resource = turbot_smart_folder.vpc_sg_rule_check.id
#   type = "tmod:@turbot/aws-vpc-security#/policy/types/securityGroupIngressRulesApprovedRules"
#   value = "REJECT $.turbot.ports.+:22,3389 $.turbot.cidr:0.0.0.0/0,::/0\nAPPROVE $.turbot.ports.+:1433,1521,3306,5432 $.turbot.cidr:<=10.0.0.0/8\nREJECT *"
# }

resource "turbot_policy_setting" "security_group_ingress_rules_approved_rules" {
  resource = turbot_smart_folder.vpc_sg_rule_check.id
  type     = "tmod:@turbot/aws-vpc-security#/policy/types/securityGroupIngressRulesApprovedRules"
  value    = <<EOF
REJECT $.turbot.ports.+:22,3389 $.turbot.cidr:0.0.0.0/0,::/0
APPROVE $.turbot.ports.+:1433,1521,3306,5432 $.turbot.cidr:<=10.0.0.0/8
REJECT *
EOF
}

resource "turbot_policy_setting" "security_group_egress_rules_approved_rules"{
  resource = turbot_smart_folder.vpc_sg_rule_check.id
  type = "tmod:@turbot/aws-vpc-security#/policy/types/securityGroupEgressRulesApprovedRules"
  value = "APROVE $.turbot.ports.+:80,443 $.turbot.cidr:0.0.0.0/0,::/0\nREJECT *"
}

resource "turbot_policy_setting" "security_group_ingress_rules_approved"{
  resource = turbot_smart_folder.vpc_sg_rule_check.id
  type = "tmod:@turbot/aws-vpc-security#/policy/types/securityGroupIngressRulesApproved"
  value = "Check: Approved"
}

resource "turbot_policy_setting" "security_group_egress_rules_approved"{
  resource = turbot_smart_folder.vpc_sg_rule_check.id
  type = "tmod:@turbot/aws-vpc-security#/policy/types/securityGroupEgressRulesApproved"
  value = "Check: Approved"
}