# Azure > IAM > Role Definition > Approved
resource "turbot_policy_setting" "azure_iam_role_definition_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-iam#/policy/types/roleDefinitionApproved"
  note     = "Azure CIS v2.0.0 - Control: 1.23"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved"
}

# Azure > IAM > Role Definition > Approved > Custom
resource "turbot_policy_setting" "azure_iam_role_definition_approved_custom" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/azure-iam#/policy/types/roleDefinitionApprovedCustom"
  note           = "Azure CIS v2.0.0 - Control: 1.23"
  template_input = <<-EOT
    {
      roleDefinition {
        roleType: get(path: "roleType")
        assignableScopes: get(path: "assignableScopes")
        permissions: get(path: "permissions")
      }
    }
  EOT
  template       = <<-EOT
    {%- set starAction = false -%}

    {%- for permission in $.roleDefinition.permissions -%}

      {%- if "*" in permission.actions -%}

        {%- set starAction = true -%}

      {%- endif -%}

    {%- endfor -%}

    {%- set subscriptionScope = false -%}


    {%- for scope in $.roleDefinition.assignableScopes -%}

      {%- if scope.match('^/subscriptions/[-a-f0-9]{36}$') or scope == '/' -%}

        {%- set subscriptionScope = true -%}

      {%- endif -%}

    {%- endfor -%}

    {%- if $.roleDefinition.roleType == "CustomRole" and subscriptionScope and starAction -%}

      {%- set data = {
          "title": "Custom Subscription Administrator Role",
          "result": "Not approved",
          "message": "Custom subscription administrator role does exists"
      } -%}

    {%- elif $.roleDefinition.roleType != "CustomRole" or not subscriptionScope or not starAction -%}

      {%- set data = {
          "title": "Custom Subscription Administrator Role",
          "result": "Approved",
          "message": "Custom subscription administrator role does not exist"
      } -%}

    {%- else -%}

      {%- set data = {
          "title": "Custom Subscription Administrator Role",
          "result": "Skip",
          "message": "No data for custom subscription administrator role yet"
      } -%}

    {%- endif -%}
    {{ data | json }}
  EOT
}
