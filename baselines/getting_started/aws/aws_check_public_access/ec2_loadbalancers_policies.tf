# Check Public Load Balancers

# Public Application Load Balancer (ALB)
# AWS > EC2 > Application Load Balancer > Approved
# https://turbot.com/v5/mods/turbot/aws-ec2/inspect#/policy/types/applicationLoadBalancerApproved
resource "turbot_policy_setting" "aws_ec2_alb_approved" {
  resource = turbot_smart_folder.aws_public_access.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/applicationLoadBalancerApproved"
  value    = "Check: Approved"
  #value   = "Enforce: Delete unapproved if new"
}

# AWS > EC2 > Application Load Balancer > Approved > Usage
# https://turbot.com/v5/mods/turbot/aws-ec2/inspect#/policy/types/applicationLoadBalancerApprovedUsage
resource "turbot_policy_setting" "aws_ec2_alb_approved_usage" {
  resource = turbot_smart_folder.aws_public_access.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/applicationLoadBalancerApprovedUsage"
  # GraphQL to pull public scheme
  template_input = <<-QUERY
    {
      resource {
        scheme: get(path: "Scheme")
      }
    }
    QUERY

  # Nunjucks template
  template = <<-TEMPLATE
    {%- if $.resource.scheme == "internal" -%}
    Approved
    {%- else -%}
    Not approved
    {%- endif -%}
    TEMPLATE
}

# Public Classic Load Balancer (ELB)
# AWS > EC2 > Classic Load Balancer > Approved
# https://turbot.com/v5/mods/turbot/aws-ec2/inspect#/policy/types/classicLoadBalancerApproved
resource "turbot_policy_setting" "aws_ec2_elb_approved" {
  resource = turbot_smart_folder.aws_public_access.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/classicLoadBalancerApproved"
  value    = "Check: Approved"
  #value           = "Enforce: Delete unapproved if new"
}

# AWS > EC2 > Classic Load Balancer > Approved > Usage
# https://turbot.com/v5/mods/turbot/aws-ec2/inspect#/policy/types/classicLoadBalancerApprovedUsage
resource "turbot_policy_setting" "aws_ec2_elb_approved_usage" {
  resource = turbot_smart_folder.aws_public_access.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/classicLoadBalancerApprovedUsage"
  # GraphQL to pull public scheme
  template_input = <<-QUERY
    {
      resource {
        scheme: get(path: "Scheme")
      }
    }
    QUERY
  # Nunjucks template
  template = <<-TEMPLATE
    {%- if $.resource.scheme == "internal" -%}
    Approved
    {%- else -%}
    Not approved
    {%- endif -%}
    TEMPLATE
}

# Public Network Load Balancer (NLB)
# AWS > EC2 > Network Load Balancer > Approved
# https://turbot.com/v5/mods/turbot/aws-ec2/inspect#/policy/types/networkLoadBalancerApproved
resource "turbot_policy_setting" "aws_ec2_nlb_approved" {
  resource = turbot_smart_folder.aws_public_access.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/networkLoadBalancerApproved"
  value    = "Check: Approved"
  #value   = "Enforce: Delete unapproved if new"
}

# AWS > EC2 > Network Load Balancer > Approved > Usage
# https://turbot.com/v5/mods/turbot/aws-ec2/inspect#/policy/types/networkLoadBalancerApprovedUsage
resource "turbot_policy_setting" "aws_ec2_nlb_approved_usage" {
  resource = turbot_smart_folder.aws_public_access.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/networkLoadBalancerApprovedUsage"
  # GraphQL to pull public scheme
  template_input = <<-QUERY
    {
      resource {
        scheme: get(path: "Scheme")
      }
    }
    QUERY
  # Nunjucks template
  template = <<-TEMPLATE
    {%- if $.resource.scheme == "internal" -%}
    Approved
    {%- else -%}
    Not approved
    {%- endif -%}
    TEMPLATE
}
