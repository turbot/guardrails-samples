locals {
  region_to_add = "westus3"
  azure_region_policies = [
    "tmod:@turbot/azure#/policy/types/turbotResourceGroupRegion",
    "tmod:@turbot/azure-aks#/policy/types/aksRegionsDefault",
    "tmod:@turbot/azure-applicationinsights#/policy/types/applicationInsightsRegionsDefault",
    "tmod:@turbot/azure-appservice#/policy/types/appServicePlanRegions",
    "tmod:@turbot/azure-appservice#/policy/types/functionAppRegions",
    "tmod:@turbot/azure-appservice#/policy/types/webAppRegions",
    "tmod:@turbot/azure-compute#/policy/types/computeRegionsDefault",
    "tmod:@turbot/azure-compute#/policy/types/diskEncryptionSetRegions",
    "tmod:@turbot/azure-compute#/policy/types/diskRegions",
    "tmod:@turbot/azure-compute#/policy/types/imageRegions",
    "tmod:@turbot/azure-compute#/policy/types/snapshotRegions",
    "tmod:@turbot/azure-compute#/policy/types/virtualMachineRegions",
    "tmod:@turbot/azure-compute#/policy/types/virtualMachineScaleSetRegions",
    "tmod:@turbot/azure-cosmosdb#/policy/types/cosmosDbRegionsDefault",
    "tmod:@turbot/azure-databricks#/policy/types/databricksRegionsDefault",
    "tmod:@turbot/azure-datafactory#/policy/types/dataFactoryRegionsDefault",
    "tmod:@turbot/azure-datafactory#/policy/types/factoryRegions",
    "tmod:@turbot/azure-firewall#/policy/types/firewallServiceRegionsDefault",
    "tmod:@turbot/azure-keyvault#/policy/types/keyVaultRegionsDefault",
    "tmod:@turbot/azure-loadbalancer#/policy/types/loadBalancerServiceRegionsDefault",
    "tmod:@turbot/azure-loganalytics#/policy/types/logAnalyticsRegionsDefault",
    "tmod:@turbot/azure-mysql#/policy/types/mySqlRegionsDefault",
    "tmod:@turbot/azure-network#/policy/types/networkRegionsDefault",
    "tmod:@turbot/azure-networkwatcher#/policy/types/networkWatcherServiceRegionsDefault",
    "tmod:@turbot/azure-postgresql#/policy/types/postgreSqlRegionsDefault",
    "tmod:@turbot/azure-recoveryservice#/policy/types/recoveryServiceRegionsDefault",
    "tmod:@turbot/azure-relay#/policy/types/relayRegionsDefault",
    "tmod:@turbot/azure-searchmanagement#/policy/types/searchManagementRegionsDefault",
    "tmod:@turbot/azure-signalr#/policy/types/signalRServiceRegionsDefault",
    "tmod:@turbot/azure-synapseanalytics#/policy/types/synapseAnalyticsRegionsDefault"
  ]
}
  