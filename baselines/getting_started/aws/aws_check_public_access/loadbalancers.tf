# Check Public Load Balancers

# Public Application Load Balancer (ALB)
resource "turbot_policy_setting" "aws_ec2_alb_approved" {
    resource        = turbot_smart_folder.aws_public_access.id
    type            = "tmod:@turbot/aws-ec2#/policy/types/applicationLoadBalancerApproved"
    value           = "Check: Approved"
    #value           = "Enforce: Delete unapproved if new"
}

resource "turbot_policy_setting" "aws_ec2_alb_approved_usage" {
  resource          = turbot_smart_folder.aws_public_access.id
  type              = "tmod:@turbot/aws-ec2#/policy/types/applicationLoadBalancerApprovedUsage"
  # GraphQL to pull public scheme
  template_input    = <<-QUERY
    {
      resource {
        scheme: get(path: "Scheme")
      }
    }
    QUERY
  
  # Nunjucks template
  template          = <<-TEMPLATE
    {%- if $.resource.scheme == "internal" -%}
    Approved
    {%- else -%}
    Not approved
    {%- endif -%}
    TEMPLATE
}


# Public Classic Load Balancer (ELB)
resource "turbot_policy_setting" "aws_ec2_elb_approved" {
    resource        = turbot_smart_folder.aws_public_access.id
    type            = "tmod:@turbot/aws-ec2#/policy/types/classicLoadBalancerApproved"
    value           = "Check: Approved"
    #value           = "Enforce: Delete unapproved if new"
}

resource "turbot_policy_setting" "aws_ec2_elb_approved_usage" {
  resource          = turbot_smart_folder.aws_public_access.id
  type              = "tmod:@turbot/aws-ec2#/policy/types/classicLoadBalancerApprovedUsage"
  # GraphQL to pull public scheme
  template_input    = <<-QUERY
    {
      resource {
        scheme: get(path: "Scheme")
      }
    }
    QUERY
  # Nunjucks template
  template          = <<-TEMPLATE
    {%- if $.resource.scheme == "internal" -%}
    Approved
    {%- else -%}
    Not approved
    {%- endif -%}
    TEMPLATE
}



# Public Network Load Balancer (NLB)
resource "turbot_policy_setting" "aws_ec2_nlb_approved" {
    resource        = turbot_smart_folder.aws_public_access.id
    type            = "tmod:@turbot/aws-ec2#/policy/types/networkLoadBalancerApproved"
    value           = "Check: Approved"
    #value           = "Enforce: Delete unapproved if new"
}

resource "turbot_policy_setting" "aws_ec2_nlb_approved_usage" {
  resource          = turbot_smart_folder.aws_public_access.id
  type              = "tmod:@turbot/aws-ec2#/policy/types/networkLoadBalancerApprovedUsage"
  # GraphQL to pull public scheme
  template_input    = <<-QUERY
    {
      resource {
        scheme: get(path: "Scheme")
      }
    }
    QUERY
  # Nunjucks template
  template          = <<-TEMPLATE
    {%- if $.resource.scheme == "internal" -%}
    Approved
    {%- else -%}
    Not approved
    {%- endif -%}
    TEMPLATE
}