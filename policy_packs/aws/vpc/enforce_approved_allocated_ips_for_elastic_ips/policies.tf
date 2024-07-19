# AWS > VPC > Elastic IP > Approved
resource "turbot_policy_setting" "awx_vpc_elastic_ip_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-vpc-internet#/policy/types/elasticIpApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
}

# AWS > VPC > Elastic IP > Approved > Custom
resource "turbot_policy_setting" "awx_vpc_elastic_ip_approved_custom" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-vpc-internet#/policy/types/elasticIpApprovedCustom"
  template_input = <<-EOT
  {
    resources {
      metadata {
        stats {
          total
        }
      }
      items {
        PublicIp: get(path: "PublicIp")
        AllocationId: get(path: "AllocationId")
        AssociationId: get(path: "AssociationId")
        turbot {
          akas
        }
      }
    }
  }
  EOT
  template = <<-EOT
  {% if $.AssociationId == null %}

    {% set data = {
        "title": EIP Asssociation,
        "result": "Not approved",
        "message": "Elastic IP association is not approved"
    } -%}

  {% else %}

    {% set data = {
        "title": EIP Asssociation,
        "result": "Approved",
        "message": "Elastic IP association is approved"
    } -%}

  {% endif %}
  {{ results | json }}
  EOT
}