resource "turbot_policy_pack" "main" {
  title       = "Enforce Azure Cosmos DB Database Accounts Are Accessible to Selected Networks"
  description = "Ensure that only trusted and authorized networks can access the database, reducing the risk of unauthorized access, data breaches, and ensuring compliance."
  akas        = ["azure_cosmosdb_enforce_database_accounts_are_accessible_to_selected_networks"]
}
