
# Create Policy Pack
# https://hub.guardrails.turbot.com/mods/servicenow/mods?q=azure
resource "turbot_policy_pack" "main" {
  title       = "Guardrails sync to ServiceNow [Azure]"
  description = "Enable Guardrails sync to ServiceNow for Azure resource types."
  akas        = ["guardrails_sync_to_servicenow_azure"]
}

# {Cloud Provider} > {Service} > {Resource Type} > ServiceNow > Table
resource "turbot_policy_setting" "servicenow_table_policies_azure" {
  for_each = toset(local.servicenow_table_policies_azure)
  resource = turbot_policy_pack.main.id
  type     = each.value
  value    = "Enforce: Configured"
  note     = "Managed by Terraform"
}

# {Cloud Provider} > {Service} > {Resource Type} > ServiceNow > Configuration Item
resource "turbot_policy_setting" "servicenow_configuration_item_policies_azure" {
  for_each = toset(local.servicenow_configuration_item_policies_azure)
  resource = turbot_policy_pack.main.id
  type     = each.value
  value    = "Enforce: Sync"
  # value    = "Enforce: Sync, archive on delete"
  note = "Managed by Terraform"
}

# {Cloud Provider} > {Service} > {Resource Type} > ServiceNow > Relationships
resource "turbot_policy_setting" "servicenow_relationships_policies_azure" {
  for_each = toset(local.servicenow_relationships_policies_azure)
  resource = turbot_policy_pack.main.id
  type     = each.value
  value    = "Enforce: Enabled"
  note     = "Managed by Terraform"
}
