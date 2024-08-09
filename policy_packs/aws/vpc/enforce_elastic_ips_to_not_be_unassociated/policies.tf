# AWS > VPC > Elastic IP > Approved
resource "turbot_policy_setting" "aws_vpc_elastic_ip_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-vpc-internet#/policy/types/elasticIpApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
}

# AWS > VPC > Elastic IP > Approved > Custom
resource "turbot_policy_setting" "aws_vpc_elastic_ip_approved_custom" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-vpc-internet#/policy/types/elasticIpApprovedCustom"
  template_input = <<-EOT
    {
      resource {
        PublicIp: get(path: "PublicIp")
        AllocationId: get(path: "AllocationId")
        AssociationId: get(path: "AssociationId")
        turbot {
          akas
        }
      }
    }
  EOT
  template = <<-EOT
    {% if $.resource.PublicIp and $.resource.AssociationId == null %}

      {% set data = {
          "title": "EIP Asssociation",
          "result": "Not approved",
          "message": "Elastic IP is not associated"
      } -%}

    {% elif $.resource.PublicIp and $.resource.AssociationId != null %}

      {% set data = {
          "title": "EIP Asssociation",
          "result": "Approved",
          "message": "Elastic IP is associated"
      } -%}

    {% else %}

      {% set data = {
          "title": "EIP Asssociation",
          "result": "Skip",
          "message": "No data for EIP yet"
      } -%}

    {% endif %}

    {{ data | json }}
  EOT
}

# AWS > VPC > Elastic IP > Active
resource "turbot_policy_setting" "aws_vpc_elastic_ip_active" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-vpc-internet#/policy/types/elasticIpActive"
  value    = "Check: Active"
  # value    = "Enforce: Delete inactive with 7 days warning"
}

# AWS > VPC > Elastic IP > Active > Attached
resource "turbot_policy_setting" "aws_vpc_elastic_ip_active_attached" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-vpc-internet#/policy/types/elasticIpActiveAttached"
  value    = "Force inactive if unattached"
}