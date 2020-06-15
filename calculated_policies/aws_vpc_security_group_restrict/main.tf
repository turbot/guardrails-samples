# Smart Folder Definition
resource "turbot_smart_folder" "aws_vpc_security_group_restrict" {
  title       = var.smart_folder_title
  description = var.smart_folder_description
  parent      = var.smart_folder_parent_resource
}

## Control Objective: AWS Security groups should not allow internet traffic
## Control Objective: Restrict all traffic in default security group.

# AWS > VPC > Security Group > Ingress Rules > Approved 
resource "turbot_policy_setting" "aws_vpc_security_group_ingress_rules_approved" {
    resource       = turbot_smart_folder.aws_vpc_security_group_restrict.id
    type           = "tmod:@turbot/aws-vpc-security#/policy/types/securityGroupIngressRulesApproved"
    value          = "Check: Approved"
    #value          = "Enforce: Delete unapproved"
}

# Approved RFC 1918 Ranges (All other ranges are unapproved)
# AWS > VPC > Security Group > Ingress Rules > Approved > CIDR Ranges
resource "turbot_policy_setting" "aws_vpc_security_group_ingress_rules_approved_cidr_ranges" {
    resource       = turbot_smart_folder.aws_vpc_security_group_restrict.id
    type           = "tmod:@turbot/aws-vpc-security#/policy/types/securityGroupIngressRulesApprovedCidrRanges"
    value          = <<-CIDRS
        ## RFC 1918
        - '10.0.0.0/8'
        - '172.16.0.0/12'
        - '192.168.0.0/16'
        CIDRS
}

# AWS > VPC > Security Group > Ingress Rules > Approved > Rules
resource "turbot_policy_setting" "aws_vpc_security_group_ingress_rules_approved_default" {
    resource        = turbot_smart_folder.aws_vpc_security_group_restrict.id
    type            = "tmod:@turbot/aws-vpc-security#/policy/types/securityGroupIngressRulesApprovedRules"
    # GraphQL to get metadata
    template_input  = <<-QUERY
        {   
            resource {
                name: get(path: "GroupName")
            }
        }
        QUERY
    
    # Nunjucks template evaluate metadata.
    template        = <<-TEMPLATE
        {%- if $.resource.name == "default" -%}
        REJECT *
        {%- else -%}
        APPROVE *
        {%- endif -%}
        TEMPLATE
}

# AWS > VPC > Security Group > Egress Rules > Approved > Rules
resource "turbot_policy_setting" "aws_vpc_security_group_egress_rules_approved_default" {
    resource        = turbot_smart_folder.aws_vpc_security_group_restrict.id
    type            = "tmod:@turbot/aws-vpc-security#/policy/types/securityGroupEgressRulesApprovedRules"
    # GraphQL to get metadata
    template_input  = <<-QUERY
        {   
            resource {
                name: get(path: "GroupName")
            }
        }
        QUERY
    
    # Nunjucks template evaluate metadata.
    template        = <<-TEMPLATE
        {%- if $.resource.name == "default" -%}
        REJECT *
        {%- else -%}
        APPROVE *
        {%- endif -%}
        TEMPLATE
}