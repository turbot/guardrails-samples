# AWS > EC2 > Network Load Balancer > Approved
resource "turbot_policy_setting" "aws_ec2_network_load_balancer_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/networkLoadBalancerApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
}

# AWS > EC2 > Network Load Balancer > Approved > Custom
resource "turbot_policy_setting" "aws_ec2_network_load_balancer_approved_custom" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/aws-ec2#/policy/types/networkLoadBalancerApprovedCustom"
  template_input = <<-EOT
    {
      item: networkLoadBalancer {
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
          "message": "Network Load Balancer scheme is internal"
      } -%}

    {%- elif $.item.scheme and scheme == "internet-facing" -%}

      {%- set data = {
          "title": "Scheme Type",
          "result": "Not approved",
          "message": "Network Load Balancer scheme is internet-facing"
      } -%}

    {%- else -%}

      {%- set data = {
         "title": "Scheme Type",
          "result": "Skip",
          "message": "No data for Network Load Balancer yet"
      } -%}

    {%- endif -%}
    {{ data | json }}
  EOT
}
