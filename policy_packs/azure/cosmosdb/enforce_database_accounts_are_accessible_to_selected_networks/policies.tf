# Azure > Cosmos DB > Database Account > Firewall
resource "turbot_policy_setting" "azure_cosmosdb_database_account_firewall" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-cosmosdb#/policy/types/databaseAccountFirewall"
  value    = "Check: Allow only approved virtual networks and IP ranges"
  # value    = "Enforce: Allow only approved virtual networks and IP ranges"
}

# Azure > Cosmos DB > Database Account > Firewall > IP Ranges > Required
resource "turbot_policy_setting" "azure_cosmosdb_database_account_firewall_ip_ranges_required" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-cosmosdb#/policy/types/databaseAccountFirewallIpRangesRequired"
  value    = "Check: Required > Items"
  # value    = "Enforce: Required > Items"
}

# Azure > Cosmos DB > Database Account > Firewall > IP Ranges > Required > Items
resource "turbot_policy_setting" "azure_cosmosdb_database_account_firewall_ip_ranges_required_items" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-cosmosdb#/policy/types/databaseAccountFirewallIpRangesRequiredItems"
  # Required IP ranges that can access the Cosmos DB account
  value    = <<-EOT
    - "45.127.45.223"
    - "45.127.45.221"
  EOT
}

# Azure > Cosmos DB > Database Account > Firewall > Virtual Networks > Required
resource "turbot_policy_setting" "azure_cosmosdb_database_account_firewall_virtual_networks_required" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-cosmosdb#/policy/types/databaseAccountFirewallVirtualNetworksRequired"
  value    = "Check: Required > Items"
  # value    = "Enforce: Required > Items"
}

# Azure > Cosmos DB > Database Account > Firewall > Virtual Networks > Required > Items
resource "turbot_policy_setting" "azure_cosmosdb_database_account_firewall_virtual_networks_required_items" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-cosmosdb#/policy/types/databaseAccountFirewallVirtualNetworksRequiredItems"
  # Required virtual networks that can access the Cosmos DB account
  value    = <<-EOT
    - "/subscriptions/1234ae5d-678b-901d-2f34-56b7890fc1c2/resourceGroups/myResourceGroup/providers/Microsoft.Network/virtualNetworks/myVirtualNetwork/subnets/mySubnet"
  EOT
}
