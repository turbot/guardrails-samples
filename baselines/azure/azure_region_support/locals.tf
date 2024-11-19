locals {
  region_to_add = "westus3"
  azure_region_policies = [
    "tmod:@turbot/azure-signalr#/policy/types/signalRServiceRegionsDefault",
    "tmod:@turbot/azure-relay#/policy/types/relayRegionsDefault",
    "tmod:@turbot/azure-synapseanalytics#/policy/types/synapseAnalyticsRegionsDefault",
    "tmod:@turbot/azure-recoveryservice#/policy/types/recoveryServiceRegionsDefault",
    "tmod:@turbot/azure-databricks#/policy/types/databricksRegionsDefault",
    "tmod:@turbot/azure-cosmosdb#/policy/types/cosmosDbRegionsDefault",
    "tmod:@turbot/azure-firewall#/policy/types/firewallServiceRegionsDefault",
    "tmod:@turbot/azure-networkwatcher#/policy/types/networkWatcherServiceRegionsDefault",
    "tmod:@turbot/azure-datafactory#/policy/types/dataFactoryRegionsDefault",
    "tmod:@turbot/azure-searchmanagement#/policy/types/searchManagementRegionsDefault",
    "tmod:@turbot/azure-network#/policy/types/networkRegionsDefault",
    "tmod:@turbot/azure-mysql#/policy/types/mySqlRegionsDefault",
    "tmod:@turbot/azure-loganalytics#/policy/types/logAnalyticsRegionsDefault",
    "tmod:@turbot/azure-loadbalancer#/policy/types/loadBalancerServiceRegionsDefault",
    "tmod:@turbot/azure-keyvault#/policy/types/keyVaultRegionsDefault",
    "tmod:@turbot/azure-postgresql#/policy/types/postgreSqlRegionsDefault",
    "tmod:@turbot/azure-applicationinsights#/policy/types/applicationInsightsRegionsDefault",
    "tmod:@turbot/azure-aks#/policy/types/aksRegionsDefault",
    "tmod:@turbot/azure-compute#/policy/types/computeRegionsDefault"
  ]
}
  