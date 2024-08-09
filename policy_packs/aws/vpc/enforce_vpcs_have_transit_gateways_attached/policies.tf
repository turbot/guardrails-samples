# AWS > VPC > VPC > Approved
resource "turbot_policy_setting" "aws_vpc_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-vpc-core#/policy/types/vpcApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
}

# AWS > VPC > VPC > Approved > Custom
resource "turbot_policy_setting" "aws_vpc_approved_custom" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-vpc-core#/policy/types/vpcApprovedCustom"
  template_input = <<-EOT
    {
      resource {
        VpcId: get(path: "VpcId")
        descendants(filter: "resourceTypeId:tmod:@turbot/aws-vpc-connect#/resource/types/transitGatewayAttachment level:self,descendant") {
          items {
            VpcId: get(path: "VpcId")
          }
        }
      }
    }
  EOT
  template = <<-EOT
    {%- if $.resource.VpcId and $.resource.descendants.items | length == 0 %}

      {% set data = {
          "title": "Transit Gateway Attachment",
          "result": "Not approved",
          "message": "Transit Gateway is not attached to VPC"
      } -%}

    {%- elif $.resource.VpcId and $.resource.descendants.items | length > 0 %}

      {% set data = {
          "title": "Transit Gateway Attachment",
          "result": "Approved",
          "message": "Transit Gateway is attached to VPC"
      } -%}

    {%- else %}

      {% set data = {
          "title": "Transit Gateway Attachment",
          "result": "Skip",
          "message": "No data for VPC yet"
      } -%}

    {%- endif %}

    {{ data | json }}
  EOT
}
