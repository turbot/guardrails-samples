# AWS > Lambda > Function > Approved
resource "turbot_policy_setting" "aws_lambda_function_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-lambda#/policy/types/functionApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
}

# AWS > Lambda > Function > Approved > Custom
resource "turbot_policy_setting" "aws_lambda_function_approved_custom" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/aws-lambda#/policy/types/functionApprovedCustom"
  template_input = <<-EOT
    {
      item: function {
        vpcConfig: get(path: "Configuration.VpcConfig")
      }
    }
  EOT
  template       = <<-EOT
    {%- set vpcConfig = $.item.vpcConfig -%}

    {% if vpcConfig.VpcId -%}

      {%- set data = {
          "title": "Lambda Function in VPC",
          "result": "Approved",
          "message": "Function can access resources within a VPC"
      } -%}

    {%- elif not vpcConfig.VpcId -%}

      {%- set data = {
          "title": "Lambda Function in VPC",
          "result": "Not approved",
          "message": "Function cannot access resources within a VPC"
      } -%}

    {%- else -%}

      {%- set data = {
         "title": "Lambda Function in VPC",
          "result": "Skip",
          "message": "No data for VPC configuration yet"
      } -%}

    {%- endif -%}
    {{ data | json }}
  EOT
}
