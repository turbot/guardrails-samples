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
  {%- if $.resource.descendants.items | length == 0 %}

    {% set data = {
        "title": "VPC with TGW",
        "result": "Not approved",
        "message": "TGW attachment is not approved"
    } -%}

  {% else -%}

    {% set data = {
        "title": "VPC with TGW",
        "result": "Approved",
        "message": "TGW attachment is approved"
    } -%}

  {%- endif %}
  {{ results | json }}
  EOT
}