# Smart Folder Definition
resource "turbot_smart_folder" "ec2_load_balancer" {
  title       = var.smart_folder_title
  description = var.smart_folder_description
  parent      = var.smart_folder_parent_resource
}

# All Approved policies are set to `Check` by default! 

# Application Load Balancer (ALB) Public Facing
resource "turbot_policy_setting" "ec2_application_load_balancer_approved_usage"{
  resource = turbot_smart_folder.va_networking.id
  type = "tmod:@turbot/aws-ec2#/policy/types/applicationLoadBalancerApprovedUsage"
  template_input = <<EOT
{
  applicationLoadBalancer{
    Scheme
  }
}
  EOT
  template      = <<EOT
{%- if $.applicationLoadBalancer.Scheme == "internet-facing" -%}
"Not approved"
{%- else -%}
"Approved"
{%- endif -%}
EOT
}

resource "turbot_policy_setting" "ec2_application_load_balancer_approved"{
  resource = turbot_smart_folder.va_networking.id
  type = "tmod:@turbot/aws-ec2#/policy/types/applicationLoadBalancerApproved"
  value = "Check: Approved"
}

# Network Load Balancer (NLB) Public Facing
resource "turbot_policy_setting" "ec2_network_load_balancer_approved_usage"{
  resource = turbot_smart_folder.va_networking.id
  type = "tmod:@turbot/aws-ec2#/policy/types/networkLoadBalancerApprovedUsage"
  template_input = <<EOT
{
  networkLoadBalancer{
    Scheme
  }
}
  EOT
  template      = <<EOT
{%- if $.networkLoadBalancer.Scheme == "internet-facing" -%}
"Not approved"
{%- else -%}
"Approved"
{%- endif -%}
EOT
}

resource "turbot_policy_setting" "ec2_network_load_balancer_approved"{
  resource = turbot_smart_folder.va_networking.id
  type = "tmod:@turbot/aws-ec2#/policy/types/networkLoadBalancerApproved"
  value = "Check: Approved"
}


# Classic Load Balancer Public Facing
resource "turbot_policy_setting" "ec2_classic_load_balancer_approved_usage"{
  resource = turbot_smart_folder.va_networking.id
  type = "tmod:@turbot/aws-ec2#/policy/types/classicLoadBalancerApprovedUsage"
  template_input = <<EOT
{
  classicLoadBalancer{
    Scheme
  }
}
  EOT
  template      = <<EOT
{%- if $.classicLoadBalancer.Scheme == "internet-facing" -%}
"Not approved"
{%- else -%}
"Approved"
{%- endif -%}
EOT
}

resource "turbot_policy_setting" "ec2_classic_load_balancer_approved"{
  resource = turbot_smart_folder.va_networking.id
  type = "tmod:@turbot/aws-ec2#/policy/types/classicLoadBalancerApproved"
  value = "Check: Approved"
}