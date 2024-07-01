# Azure > KeyVault > Vault > Approved
resource "turbot_policy_setting" "azure_keyvault_vault_approved" {
  resource = turbot_smart_folder.azure_cis_v200_s8_keyvault.id
  type     = "tmod:@turbot/azure-keyvault#/policy/types/vaultApproved"
  note     = "Azure CIS v2.0.0 - Control: 8.6 and 8.7"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved"
}

# Azure > KeyVault > Vault > custom
resource "turbot_policy_setting" "azure_keyvault_vault_approved_custom" {
  resource       = turbot_smart_folder.azure_cis_v200_s8_keyvault.id
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
    {%- if $.vault.enableRbacAuthorization == false -%}

      {%- set data = {
          "title": "Role Based Access Control",
          "result": "Not approved",
          "message": "Role based access control is disabled"
      } -%}

    {%- elif $.vault.privateEndpointConnections == null -%}

      {%- set data = {
          "title": "Private endpoint connections",
          "result": "Not approved",
          "message": "Private endpoint connections is not used"
      } -%}

    {%- else -%}

      {%- if $.vault.enableRbacAuthorization == true -%}

        {%- set data = {
            "title": "Role Based Access Control",
            "result": "Approved",
            "message": "Role based access control is enabled"
        } -%}

      {%- else -%}

        {%- set data = {
            "title": "Private endpoint connections",
            "result": "Approved",
            "message": "Private endpoint connections is used"
        } -%}

      {%- endif -%}

    {%- endif -%}
    {{ data | json }}
  EOT
}
