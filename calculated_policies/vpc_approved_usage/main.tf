# Smart Folder Definition
resource "turbot_smart_folder" "aws_vpc_approved" {
  title       = var.smart_folder_title
  description = var.smart_folder_description
  parent      = var.smart_folder_parent_resource
}

# AWS > VPC > VPC > Approved
resource "turbot_policy_setting" "aws_vpc_approved" {
  resource = turbot_smart_folder.aws_vpc_approved.id
  type     = "tmod:@turbot/aws-vpc-core#/policy/types/vpcApproved"
  value    = "Check: Approved"
}

# AWS > VPC > VPC > Approved > Usage
resource "turbot_policy_setting" "aws_vpc_approved_usage" {
  resource = turbot_smart_folder.aws_vpc_approved.id
  type     = "tmod:@turbot/aws-vpc-core#/policy/types/vpcApprovedUsage"
  # GraphQL to pull function metadata
  template_input = <<EOT
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
  # Nunjucks Template Nunjucks Comments are formatted: {# comment #}
  template = <<EOT
  {%- if $.resource.descendants.items | length == 0 %}
  'Not approved'
  {% else -%}
  'Approved'
  {%- endif %}
  EOT
}
