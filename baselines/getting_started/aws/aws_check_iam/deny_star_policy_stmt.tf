# CHeck for * Access except for List/Get

# AWS > IAM > Policy > Approved
# https://turbot.com/v5/mods/turbot/aws-iam/inspect#/policy/types/iamPolicyApproved
resource "turbot_policy_setting" "iam_policy_approved" {
  count    = var.enable_iam_policy_approved ? 1 : 0
  resource = turbot_smart_folder.aws_iam.id
  type     = "tmod:@turbot/aws-iam#/policy/types/iamPolicyApproved"
  value    = "Check: Approved"
  ## "Enforce: Delete unapproved if new"
}

# AWS > IAM > Policy > Approved > Usage
# https://turbot.com/v5/mods/turbot/aws-iam/inspect#/policy/types/iamPolicyApprovedUsage
resource "turbot_policy_setting" "iam_policy_approved_statements" {
  count    = var.enable_iam_policy_approved_statements ? 1 : 0
  resource = turbot_smart_folder.aws_iam.id
  type     = "tmod:@turbot/aws-iam#/policy/types/iamPolicyApprovedUsage"
  # GraphQL to pull policy Statements
  template_input = <<-QUERY
    {
        policy: resource {
            statements: get(path: "PolicyVersion.Statement")
        }
    }
QUERY

  # Nunjucks template to set usage approval based on policy content
  template = <<-TEMPLATE
    {%- set anyStar = r/\*/g -%}
    {%- set goodStar = r/(Get|List)\*/g -%}
    {%- set approved = true -%}
    {%- for statement in $.policy.statements -%}
        {%- for action in statement.Action -%}
            {%- if anyStar.test(action) -%}
                {%- if not goodStar.test(action) -%}
                    {%- set approved = false -%}
                {%- endif -%}
            {%- endif -%}
        {%- endfor -%}
    {%- endfor -%}
    {%- if approved  -%}
        "Approved"
    {%- else -%}
        "Not approved"
    {%- endif -%}
TEMPLATE
}
