terraform {
  required_providers {
    turbot = {
      source = "turbot/turbot"
    }
  }
}

provider "turbot" {
  profile = "stacy"
}

resource "turbot_smart_folder" "azure_cis_v200_s1_iam" {
  parent      = "tmod:@turbot/turbot#/"
  title       = "Azure CIS v2.0.0 - Section 1 - Identity and Access Management"
  description = "This section contains recommendations for configuring Azure Identity and Access Management features."
}

# Azure > RoleDefinition > Approved
resource "turbot_policy_setting" "azure_iam_role_definition_approved" {
  resource = turbot_smart_folder.azure_cis_v200_s1_iam.id
  type     = "tmod:@turbot/azure-iam#/policy/types/roleDefinitionApproved"
  note     = "Azure CIS v2.0.0 - Control: 1.5"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved"
}

# Azure > RoleDefinition > Approved > Custom
resource "turbot_policy_setting" "azure_iam_role_definition_approved_custom" {
  resource       = turbot_smart_folder.azure_cis_v200_s1_iam.id
  type           = "tmod:@turbot/azure-iam#/policy/types/roleDefinitionApprovedCustom"
  note           = "Azure CIS v2.0.0 - Control: 1.5"
  template       = <<-EOT
    {%- set actionsCheck = false -%}
    {%- for permission in $.roleDefinition.permissions -%}
      {%- if "*" in permission.actions -%}
        {%- set actionsCheck = true -%}
      {%- endif -%}
    {%- endfor -%}

    {%- set assignableScopesCheck = false -%}
    {%- for scope in $.roleDefinition.assignableScopes -%}
      {%- if scope.match('^/subscriptions/[-a-f0-9]{36}$') or scope == '/' -%}
        {%- set assignableScopesCheck = true -%}
      {%- endif -%}
    {%- endfor -%}

    {%- if $.roleDefinition.roleType == "CustomRole" and assignableScopesCheck and actionsCheck -%}
    result: Not approved
    message: "Custom Subscription Administrator Roles exist"
    {%- else -%}
    result: Approved
    message: "Custom Subscription Administrator Roles does not exist"
    {%- endif -%}
    EOT
}
