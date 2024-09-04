# Azure > Key Vault > Vault > Approved
resource "turbot_policy_setting" "azure_keyvault_vault_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-keyvault#/policy/types/vaultApproved"
  note     = "Azure CIS v2.0.0 - Control: 8.6 and 8.7"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
}

# Azure > Key Vault > Vault > Custom
resource "turbot_policy_setting" "azure_keyvault_vault_approved_custom" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/azure-keyvault#/policy/types/vaultApprovedCustom"
  note           = "Azure CIS v2.0.0 - Control: 8.6 and 8.7"
  template_input = <<-EOT
    {
      vault {
        enableRbacAuthorization: get(path:"properties.enableRbacAuthorization"),
        privateEndpointConnections: get(path:"properties.privateEndpointConnections")

      }
    }
  EOT
  template       = <<-EOT
    {% set results = [] -%}

    {%- if $.vault.enableRbacAuthorization == false -%}

      {%- set data = {
          "title": "Role Based Access Control",
          "result": "Not approved",
          "message": "Role based access control is disabled"
      } -%}

    {%- elif $.vault.enableRbacAuthorization == false -%}

      {%- set data = {
          "title": "Role Based Access Control",
          "result": "Approved",
          "message": "Role based access control is enabled"
        } -%}

    {%- else -%}

      {%- set data = {
          "title": "Role Based Access Control",
          "result": "Skip",
          "message": "No data for role based access control yet"
        } -%}

    {%- endif -%}

    {% set results = results.concat(data) -%}

    {%- if $.vault.privateEndpointConnections == null -%}

      {%- set data = {
          "title": "Private Endpoint Connections",
          "result": "Not approved",
          "message": "Private endpoint connections are not used"
      } -%}

    {%- else -%}

      {%- set data = {
          "title": "Private Endpoint Connections",
          "result": "Approved",
          "message": "Private endpoint connections are used"
      } -%}

    {%- endif -%}

    {% set results = results.concat(data) -%}

    {{ results | json }}
  EOT
}

# Azure > Key Vault > Key > Expiration
resource "turbot_policy_setting" "azure_keyvault_key_expiration" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-keyvault#/policy/types/keyExpiration"
  note     = "Azure CIS v2.0.0 - Control: 8.1 and 8.2"
  value    = "Check: Expiration"
  # value    = "Enforce: Expiration"
}

# Azure > Key Vault > Secret > Expiration
resource "turbot_policy_setting" "azure_keyvault_secret_expiration" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-keyvault#/policy/types/secretExpiration"
  note     = "Azure CIS v2.0.0 - Control: 8.3 and 8.4"
  value    = "Check: Expiration"
  # value    = "Enforce: Expiration"
}

# Azure > Key Vault > Vault > Purge Protection
resource "turbot_policy_setting" "azure_keyvault_vault_purge_protection" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-keyvault#/policy/types/vaultPurgeProtection"
  note     = "Azure CIS v2.0.0 - Control: 8.5"
  value    = "Check: Purge Protection Enabled"
  # value    = "Enforce: Enable Purge Protection"
}
