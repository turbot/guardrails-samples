# AWS > VPC > Security Group > Approved
resource "turbot_policy_setting" "aws_vpc_security_group_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-vpc-security#/policy/types/securityGroupApproved"
  template_input = <<-EOT
    {   
      resource {
        name: get(path: "GroupName")
      }
    }
  EOT
  template       = <<-EOT
    {%- if $.resource.name == "default" -%}

      "Check: Approved"
      {# "Enforce: Delete unapproved if new" #}

    {%- else -%}

      "Skip"
      
    {%- endif -%}
  EOT
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
          "message": "Default security group is not allowed to exist"
      } -%}

    {%- elif $.resource.name != "default" -%}

     {% set data = {
          "title": "Default Security Group",
          "result": "Approved",
          "message": "Not a default security group"
      } -%}

    {%- else -%}

      {% set data = {
          "title": "Default Security Group",
          "result": "Skip",
          "message": "No data for security group yet"
      } -%}

    {%- endif -%}
    {{ data | json }}
  EOT
}
