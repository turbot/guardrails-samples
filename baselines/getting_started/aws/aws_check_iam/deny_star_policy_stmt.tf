# CHeck for * Access except for List/Get

resource "turbot_policy_setting" "iam_policy_approved" {
  resource        = turbot_smart_folder.aws_iam.id
  type            = "tmod:@turbot/aws-iam#/policy/types/iamPolicyApproved"
  value           = "Check: Approved"
                    ## "Enforce: Delete unapproved if new"
}

resource "turbot_policy_setting" "iam_policy_approved_statements" {
  resource        = turbot_smart_folder.aws_iam.id
  type            = "tmod:@turbot/aws-iam#/policy/types/iamPolicyApprovedUsage"
  # GraphQL to pull policy Statements
  template_input  = <<-QUERY
    {
        policy: resource {
            statements: get(path: "PolicyVersion.Statement")
        }
    }
QUERY
  
  # Nunjucks template to set usage approval based on policy content
  template        = <<-TEMPLATE
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