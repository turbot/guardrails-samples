# AWS > EC2 > Application Load Balancer > Approved
resource "turbot_policy_setting" "aws_ec2_application_load_balancer_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/applicationLoadBalancerApproved"
  value    = "Check: Approved"
  # value = "Enforce: Delete unapproved if new"
}

# AWS > EC2 > Application Load Balancer > Approved > Custom
resource "turbot_policy_setting" "aws_ec2_application_load_balancer_approved_custom" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/aws-ec2#/policy/types/applicationLoadBalancerApprovedCustom"
  template_input = <<-EOT
    {
      item: applicationLoadBalancer {
        scheme: get(path:"Scheme")
      }
    }
    EOT
  template       = <<-EOT
    {%- set scheme = $.item.scheme -%}

    {%- if $.item.scheme and scheme == "internal" -%}

      {%- set data = {
          "title": "Scheme Type",
          "result": "Approved",
          "message": "Application Load Balancer scheme is internal"
      } -%}

    {%- elif $.item.scheme and scheme == "internet-facing" -%}

      {%- set data = {
          "title": "Scheme Type",
          "result": "Not approved",
          "message": "Application Load Balancer scheme is internet-facing"
      } -%}

    {%- else -%}

      {%- set data = {
         "title": "Scheme Type",
          "result": "Skip",
          "message": "No data for Application Load Balancer yet"
      } -%}

    {%- endif -%}
    {{ data | json }}
  EOT
}
