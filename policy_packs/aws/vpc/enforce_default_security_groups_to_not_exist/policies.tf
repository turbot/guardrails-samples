# AWS > VPC > Security Group > Approved
resource "turbot_policy_setting" "aws_vpc_security_group_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-vpc-security#/policy/types/securityGroupApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved"
}

# AWS > VPC > Security Group > Approved > Custom
resource "turbot_policy_setting" "aws_vpc_security_group_approved_custom" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/aws-vpc-security#/policy/types/securityGroupApprovedCustom"
  template_input = <<-EOT
    {   
      resource {
        name: get(path: "GroupName")
      }
    }
  EOT
  template = <<-EOT
    {%- if $.resource.name == "default" -%}

     {% set data = {
          "title": "Default Security Group",
          "result": "Not approved",
          "message": "Security Group is the default group"
      } -%}
    
    {%- else %}

      {% set data = {
          "title": "Default Security Group",
          "result": "Approved",
          "message": "Security Group is not the default group"
      } -%}

    {%- endif -%}
    {{ data | json }}
  EOT
}