# AWS > EC2 > Instance > Approved
resource "turbot_policy_setting" "aws_ec2_instance_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/instanceApproved"
  value    = "Check: Approved"
  # value    =  "Enforce: Stop unapproved"
  # value    =  "Enforce: Stop unapproved if new"
  # value    =  "Enforce: Delete unapproved if new"
}

# AWS > EC2 > Instance > Approved > Custom
resource "turbot_policy_setting" "aws_ec2_instance_approved_custom" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/aws-ec2#/policy/types/instanceApprovedCustom"
  template_input = <<-EOT
    - |
      {
        item: region {
          turbot {
            id
          }
        }
      }
    - |
      {
        item: instance {
          subnetId: get(path: "SubnetId")
        }
        resources(filter: "resourceId:{{ $.item.turbot.id }} resourceTypeId:'tmod:@turbot/aws-vpc-core#/resource/types/routeTable' resourceTypeLevel:self") {
          items {
            associations: get(path: "Associations.[0].SubnetId")
            routes: get(path: "Routes")
          }
        }
      }
  EOT
  template       = <<-EOT
    {%- set hasIgw = false -%}
    {%- set isApproved = true -%}

    {%- for item in $.resources.items -%}
      {%- if item.associations == $.item.subnetId -%}
        {%- for gateway in item.routes -%}
          {%- if 'igw' in gateway.GatewayId -%}
            {%- set hasIgw = true -%}
          {%- endif -%}
        {%- endfor -%}
      {%- endif -%}
    {%- endfor -%}

    {%- if not hasIgw -%}

      {%- set data = {
          "title": "EC2 Instance Internet Access",
          "result": "Approved",
          "message": "EC2 instances are not allowed to have internet access via subnets"
      } -%}

    {%- elif hasIgw -%}

      {%- set data = {
          "title": "EC2 Instance Internet Access",
          "result": "Not approved",
          "message": "EC2 instances are allowed to have internet access via subnets"
      } -%}

    {%- else -%}

      {%- set data = {
         "title": "EC2 Instance Internet Access",
          "result": "Skip",
          "message": "No data for EC2 instance internet access yet"
      } -%}

    {%- endif -%}
    {{ data | json }}
  EOT
}
