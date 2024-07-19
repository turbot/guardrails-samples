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
      inputTagKey: constant(value: "name")
      item: function {
        tags: get(path: "Tags")
      }
    }
  EOT
  template       = <<-EOT
    {%- set tags = $.item.tags -%}
    {%- set tagsLength = tags | length -%}
    {%- set inputTagKey = $.inputTagKey -%}

    {% if tagsLength > 0 and inputTagKey in tags -%}

      {%- set data = {
          "title": "Lambda Function Tag",
          "result": "Approved",
          "message": "Function contains specific tag"
      } -%}

    {%- elif tagsLength == 0 or not inputTagKey in tags -%}

      {%- set data = {
          "title": "Lambda Function Tag",
          "result": "Not approved",
          "message": "Function does not contain specific tag"
      } -%}

    {%- else -%}

      {%- set data = {
         "title": "Lambda Function Tag",
          "result": "Skip",
          "message": "No data for lambda function's tag yet"
      } -%}

    {%- endif -%}
    {{ data | json }}
  EOT
}
