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
        tags: get(path: "Tags")
      }
    }
  EOT
  # Replace dummy value for inputTagKeys in calculated policy
  template = <<-EOT
    {%- set tags = $.item.tags -%}
    {%- set inputTagKeys = ["name", "environment"] -%}
    {%- set tagsLength = tags | length -%}
    {%- set allTagsPresent = true -%}
    {%- set flag = true -%}

    {%- if tagsLength > 0 -%}
      {%- for key in inputTagKeys -%}
        {%- if flag and not key in tags -%}
          {%- set allTagsPresent = false -%}
          {%- set flag = false -%}
        {%- endif -%}
      {%- endfor -%}
    {%- endif -%}

    {%- if tagsLength > 0 and allTagsPresent -%}

      {%- set data = {
          "title": "Lambda Functions Approved Tags",
          "result": "Approved",
          "message": "Function contains specific tags"
      } -%}

    {%- elif tagsLength == 0 or not allTagsPresent -%}

      {%- set data = {
          "title": "Lambda Functions Approved Tags",
          "result": "Not approved",
          "message": "Function do not contain specific tags"
      } -%}

    {%- else -%}

      {%- set data = {
         "title": "Lambda Functions Approved Tags",
          "result": "Skip",
          "message": "No data for lambda function tags yet"
      } -%}

    {%- endif -%}
    {{ data | json }}
  EOT
}
