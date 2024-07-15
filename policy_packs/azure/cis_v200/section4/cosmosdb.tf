# Azure > Cosmos DB > Database Account > Firewall
resource "turbot_policy_setting" "azure_cosmosdb_database_account_firewall" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-cosmosdb#/policy/types/databaseAccountFirewall"
  note     = "Azure CIS v2.0.0 - Control: 4.5.1"
  value    = "Check: Allow only approved virtual networks and IP ranges"
  # value    = "Enforce: Allow only approved virtual networks and IP ranges"
}

# Azure > Cosmos DB > Database Account > Firewall > IP Ranges > Required
resource "turbot_policy_setting" "azure_cosmosdb_database_account_firewall_ip_ranges_required" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-cosmosdb#/policy/types/databaseAccountFirewallIpRangesRequired"
  note     = "Azure CIS v2.0.0 - Control: 4.5.1"
  value    = "Check: Required > Items"
  # value    = "Enforce: Required > Items"
}

# Azure > Cosmos DB > Database Account > Firewall > IP Ranges > Required > Items
resource "turbot_policy_setting" "azure_cosmosdb_database_account_firewall_ip_ranges_required_items" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-cosmosdb#/policy/types/databaseAccountFirewallIpRangesRequiredItems"
  note     = "Azure CIS v2.0.0 - Control: 4.5.1"
  value    = <<-EOT
    - "45.127.45.223"
    - "45.127.45.221"
  EOT
}

# Azure > Cosmos DB > Database Account > Firewall > Virtual Networks > Required
resource "turbot_policy_setting" "azure_cosmosdb_database_account_firewall_virtual_networks_required" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-cosmosdb#/policy/types/databaseAccountFirewallVirtualNetworksRequired"
  note     = "Azure CIS v2.0.0 - Control: 4.5.1"
  value    = "Check: Required > Items"
  # value    = "Enforce: Required > Items"
}

# Azure > Cosmos DB > Database Account > Firewall > Virtual Networks > Required > Items
resource "turbot_policy_setting" "azure_cosmosdb_database_account_firewall_virtual_networks_required_items" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-cosmosdb#/policy/types/databaseAccountFirewallVirtualNetworksRequiredItems"
  note     = "Azure CIS v2.0.0 - Control: 4.5.1"
  value    = <<-EOT
    - "/subscriptions/3510ae4d-530b-497d-8f30-53b9616fc6c1/resourceGroups/integration_test_rg/providers/Microsoft.Network/virtualNetworks/turbottest9341/subnets/gatewaysubnet"
  EOT
}
