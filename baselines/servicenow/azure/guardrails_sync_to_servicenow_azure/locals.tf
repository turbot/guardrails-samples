locals {
  # Map of mods to their respective ServiceNowTable policies
  servicenow_table_policy_map_azure = {

    servicenow-azure = [
      "tmod:@turbot/servicenow-azure#/policy/types/resourceGroupServiceNowTable",
      "tmod:@turbot/servicenow-azure#/policy/types/subscriptionServiceNowTable",
      "tmod:@turbot/servicenow-azure#/policy/types/tenantServiceNowTable"
    ],
    servicenow-azure-activedirectory = [
      "tmod:@turbot/servicenow-azure-activedirectory#/policy/types/applicationServiceNowTable",
      "tmod:@turbot/servicenow-azure-activedirectory#/policy/types/clientSecretServiceNowTable",
      "tmod:@turbot/servicenow-azure-activedirectory#/policy/types/customDomainServiceNowTable",
      "tmod:@turbot/servicenow-azure-activedirectory#/policy/types/directoryServiceNowTable",
      "tmod:@turbot/servicenow-azure-activedirectory#/policy/types/groupServiceNowTable",
      "tmod:@turbot/servicenow-azure-activedirectory#/policy/types/servicePrincipalServiceNowTable",
      "tmod:@turbot/servicenow-azure-activedirectory#/policy/types/userServiceNowTable"
    ],
    servicenow-azure-aks = [
      "tmod:@turbot/servicenow-azure-aks#/policy/types/managedClusterServiceNowTable"
    ],
    servicenow-azure-apimanagement = [
      "tmod:@turbot/servicenow-azure-apimanagement#/policy/types/apiManagementServiceServiceNowTable"
    ],
    servicenow-azure-applicationgateway = [
      "tmod:@turbot/servicenow-azure-applicationgateway#/policy/types/applicationGatewayServiceNowTable"
    ],
    servicenow-azure-applicationinsights = [
      "tmod:@turbot/servicenow-azure-applicationinsights#/policy/types/applicationInsightServiceNowTable"
    ],
    servicenow-azure-appservice = [
      "tmod:@turbot/servicenow-azure-appservice#/policy/types/appServicePlanServiceNowTable",
      "tmod:@turbot/servicenow-azure-appservice#/policy/types/functionAppServiceNowTable",
      "tmod:@turbot/servicenow-azure-appservice#/policy/types/webAppServiceNowTable"
    ],
    servicenow-azure-automation = [
      "tmod:@turbot/servicenow-azure-automation#/policy/types/automationAccountServiceNowTable",
      "tmod:@turbot/servicenow-azure-automation#/policy/types/runbookServiceNowTable"
    ],
    servicenow-azure-compute = [
      "tmod:@turbot/servicenow-azure-compute#/policy/types/availabilitySetServiceNowTable",
      "tmod:@turbot/servicenow-azure-compute#/policy/types/diskEncryptionSetServiceNowTable",
      "tmod:@turbot/servicenow-azure-compute#/policy/types/diskServiceNowTable",
      "tmod:@turbot/servicenow-azure-compute#/policy/types/imageServiceNowTable",
      "tmod:@turbot/servicenow-azure-compute#/policy/types/snapshotServiceNowTable",
      "tmod:@turbot/servicenow-azure-compute#/policy/types/sshPublicKeyServiceNowTable",
      "tmod:@turbot/servicenow-azure-compute#/policy/types/virtualMachineScaleSetServiceNowTable",
      "tmod:@turbot/servicenow-azure-compute#/policy/types/virtualMachineServiceNowTable"
    ],
    servicenow-azure-cosmosdb = [
      "tmod:@turbot/servicenow-azure-cosmosdb#/policy/types/databaseAccountServiceNowTable",
      "tmod:@turbot/servicenow-azure-cosmosdb#/policy/types/mongoDbCollectionServiceNowTable",
      "tmod:@turbot/servicenow-azure-cosmosdb#/policy/types/mongoDbDatabaseServiceNowTable",
      "tmod:@turbot/servicenow-azure-cosmosdb#/policy/types/sqlContainerServiceNowTable",
      "tmod:@turbot/servicenow-azure-cosmosdb#/policy/types/sqlDatabaseServiceNowTable"
    ],
    servicenow-azure-databricks = [
      "tmod:@turbot/servicenow-azure-databricks#/policy/types/databricksWorkspaceServiceNowTable"
    ],
    servicenow-azure-datafactory = [
      "tmod:@turbot/servicenow-azure-datafactory#/policy/types/datasetServiceNowTable",
      "tmod:@turbot/servicenow-azure-datafactory#/policy/types/factoryServiceNowTable",
      "tmod:@turbot/servicenow-azure-datafactory#/policy/types/pipelineServiceNowTable"
    ],
    servicenow-azure-dns = [
      "tmod:@turbot/servicenow-azure-dns#/policy/types/recordSetServiceNowTable",
      "tmod:@turbot/servicenow-azure-dns#/policy/types/zoneServiceNowTable"
    ],
    servicenow-azure-firewall = [
      "tmod:@turbot/servicenow-azure-firewall#/policy/types/firewallServiceNowTable"
    ],
    servicenow-azure-frontdoorservice = [
      "tmod:@turbot/servicenow-azure-frontdoorservice#/policy/types/frontDoorServiceNowTable"
    ],
    servicenow-azure-iam = [
      "tmod:@turbot/servicenow-azure-iam#/policy/types/roleAssignmentServiceNowTable",
      "tmod:@turbot/servicenow-azure-iam#/policy/types/roleDefinitionServiceNowTable"
    ],
    servicenow-azure-keyvault = [
      "tmod:@turbot/servicenow-azure-keyvault#/policy/types/keyServiceNowTable",
      "tmod:@turbot/servicenow-azure-keyvault#/policy/types/secretServiceNowTable",
      "tmod:@turbot/servicenow-azure-keyvault#/policy/types/vaultServiceNowTable"
    ],
    servicenow-azure-loadbalancer = [
      "tmod:@turbot/servicenow-azure-loadbalancer#/policy/types/loadBalancerServiceNowTable"
    ],
    servicenow-azure-loganalytics = [
      "tmod:@turbot/servicenow-azure-loganalytics#/policy/types/logAnalyticsWorkspaceServiceNowTable"
    ],
    servicenow-azure-monitor = [
      "tmod:@turbot/servicenow-azure-monitor#/policy/types/actionGroupServiceNowTable",
      "tmod:@turbot/servicenow-azure-monitor#/policy/types/alertsServiceNowTable",
      "tmod:@turbot/servicenow-azure-monitor#/policy/types/logProfileServiceNowTable"
    ],
    servicenow-azure-mysql = [
      "tmod:@turbot/servicenow-azure-mysql#/policy/types/flexibleServerServiceNowTable",
      "tmod:@turbot/servicenow-azure-mysql#/policy/types/serverServiceNowTable"
    ],
    servicenow-azure-network = [
      "tmod:@turbot/servicenow-azure-network#/policy/types/applicationSecurityGroupServiceNowTable",
      "tmod:@turbot/servicenow-azure-network#/policy/types/expressRouteCircuitsServiceNowTable",
      "tmod:@turbot/servicenow-azure-network#/policy/types/networkInterfaceServiceNowTable",
      "tmod:@turbot/servicenow-azure-network#/policy/types/networkSecurityGroupServiceNowTable",
      "tmod:@turbot/servicenow-azure-network#/policy/types/privateDnsZonesServiceNowTable",
      "tmod:@turbot/servicenow-azure-network#/policy/types/privateEndpointsServiceNowTable",
      "tmod:@turbot/servicenow-azure-network#/policy/types/publicIpAddressServiceNowTable",
      "tmod:@turbot/servicenow-azure-network#/policy/types/routeTableServiceNowTable",
      "tmod:@turbot/servicenow-azure-network#/policy/types/subnetServiceNowTable",
      "tmod:@turbot/servicenow-azure-network#/policy/types/virtualNetworkGatewayServiceNowTable",
      "tmod:@turbot/servicenow-azure-network#/policy/types/virtualNetworkServiceNowTable"
    ],
    servicenow-azure-networkwatcher = [
      "tmod:@turbot/servicenow-azure-networkwatcher#/policy/types/flowLogServiceNowTable",
      "tmod:@turbot/servicenow-azure-networkwatcher#/policy/types/networkWatcherServiceNowTable"
    ],
    servicenow-azure-postgresql = [
      "tmod:@turbot/servicenow-azure-postgresql#/policy/types/flexibleServerServiceNowTable",
      "tmod:@turbot/servicenow-azure-postgresql#/policy/types/serverServiceNowTable"
    ],
    servicenow-azure-recoveryservice = [
      "tmod:@turbot/servicenow-azure-recoveryservice#/policy/types/backupServiceNowTable",
      "tmod:@turbot/servicenow-azure-recoveryservice#/policy/types/vaultServiceNowTable"
    ],
    servicenow-azure-relay = [
      "tmod:@turbot/servicenow-azure-relay#/policy/types/namespaceServiceNowTable"
    ],
    servicenow-azure-searchmanagement = [
      "tmod:@turbot/servicenow-azure-searchmanagement#/policy/types/searchServiceServiceNowTable"
    ],
    servicenow-azure-securitycenter = [
      "tmod:@turbot/servicenow-azure-securitycenter#/policy/types/securityCenterServiceNowTable"
    ],
    servicenow-azure-servicebus = [
      "tmod:@turbot/servicenow-azure-servicebus#/policy/types/namespaceServiceNowTable",
      "tmod:@turbot/servicenow-azure-servicebus#/policy/types/queueServiceNowTable",
      "tmod:@turbot/servicenow-azure-servicebus#/policy/types/topicServiceNowTable"
    ],
    servicenow-azure-signalr = [
      "tmod:@turbot/servicenow-azure-signalr#/policy/types/signalRServiceNowTable"
    ],
    servicenow-azure-sql = [
      "tmod:@turbot/servicenow-azure-sql#/policy/types/databaseServiceNowTable",
      "tmod:@turbot/servicenow-azure-sql#/policy/types/elasticPoolServiceNowTable",
      "tmod:@turbot/servicenow-azure-sql#/policy/types/serverServiceNowTable"
    ],
    servicenow-azure-sqlvirtualmachine = [
      "tmod:@turbot/servicenow-azure-sqlvirtualmachine#/policy/types/sqlVirtualMachineServiceNowTable"
    ],
    servicenow-azure-storage = [
      "tmod:@turbot/servicenow-azure-storage#/policy/types/containerServiceNowTable",
      "tmod:@turbot/servicenow-azure-storage#/policy/types/fileShareServiceNowTable",
      "tmod:@turbot/servicenow-azure-storage#/policy/types/queueServiceNowTable",
      "tmod:@turbot/servicenow-azure-storage#/policy/types/storageAccountServiceNowTable"
    ],
    servicenow-azure-synapseanalytics = [
      "tmod:@turbot/servicenow-azure-synapseanalytics#/policy/types/sqlPoolServiceNowTable",
      "tmod:@turbot/servicenow-azure-synapseanalytics#/policy/types/synapseWorkspaceServiceNowTable"
    ]
  }

  # Flatten the Table policies for installed mods
  servicenow_table_policies_azure = flatten([
    for mod in var.servicenow_mod_list_azure : local.servicenow_table_policy_map_azure[mod] if contains(keys(local.servicenow_table_policy_map_azure), mod)
  ])

  # Map of mods to their respective Configuration Items policies
  servicenow_configuration_item_policy_map_azure = {
    servicenow-azure = [
      "tmod:@turbot/servicenow-azure#/policy/types/resourceGroupServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure#/policy/types/subscriptionServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure#/policy/types/tenantServiceNowConfigurationItem"
    ],
    servicenow-azure-activedirectory = [
      "tmod:@turbot/servicenow-azure-activedirectory#/policy/types/applicationServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure-activedirectory#/policy/types/clientSecretServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure-activedirectory#/policy/types/customDomainServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure-activedirectory#/policy/types/directoryServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure-activedirectory#/policy/types/groupServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure-activedirectory#/policy/types/servicePrincipalServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure-activedirectory#/policy/types/userServiceNowConfigurationItem"
    ],
    servicenow-azure-aks = [
      "tmod:@turbot/servicenow-azure-aks#/policy/types/managedClusterServiceNowConfigurationItem"
    ],
    servicenow-azure-apimanagement = [
      "tmod:@turbot/servicenow-azure-apimanagement#/policy/types/apiManagementServiceServiceNowConfigurationItem"
    ],
    servicenow-azure-applicationgateway = [
      "tmod:@turbot/servicenow-azure-applicationgateway#/policy/types/applicationGatewayServiceNowConfigurationItem"
    ],
    servicenow-azure-applicationinsights = [
      "tmod:@turbot/servicenow-azure-applicationinsights#/policy/types/applicationInsightServiceNowConfigurationItem"
    ],
    servicenow-azure-appservice = [
      "tmod:@turbot/servicenow-azure-appservice#/policy/types/appServicePlanServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure-appservice#/policy/types/functionAppServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure-appservice#/policy/types/webAppServiceNowConfigurationItem"
    ],
    servicenow-azure-automation = [
      "tmod:@turbot/servicenow-azure-automation#/policy/types/automationAccountServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure-automation#/policy/types/runbookServiceNowConfigurationItem"
    ],
    servicenow-azure-compute = [
      "tmod:@turbot/servicenow-azure-compute#/policy/types/availabilitySetServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure-compute#/policy/types/diskEncryptionSetServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure-compute#/policy/types/diskServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure-compute#/policy/types/imageServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure-compute#/policy/types/snapshotServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure-compute#/policy/types/sshPublicKeyServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure-compute#/policy/types/virtualMachineScaleSetServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure-compute#/policy/types/virtualMachineServiceNowConfigurationItem"
    ],
    servicenow-azure-cosmosdb = [
      "tmod:@turbot/servicenow-azure-cosmosdb#/policy/types/databaseAccountServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure-cosmosdb#/policy/types/mongoDbCollectionServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure-cosmosdb#/policy/types/mongoDbDatabaseServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure-cosmosdb#/policy/types/sqlContainerServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure-cosmosdb#/policy/types/sqlDatabaseServiceNowConfigurationItem"
    ],
    servicenow-azure-databricks = [
      "tmod:@turbot/servicenow-azure-databricks#/policy/types/databricksWorkspaceServiceNowConfigurationItem"
    ],
    servicenow-azure-datafactory = [
      "tmod:@turbot/servicenow-azure-datafactory#/policy/types/datasetServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure-datafactory#/policy/types/factoryServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure-datafactory#/policy/types/pipelineServiceNowConfigurationItem"
    ],
    servicenow-azure-dns = [
      "tmod:@turbot/servicenow-azure-dns#/policy/types/recordSetServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure-dns#/policy/types/zoneServiceNowConfigurationItem"
    ],
    servicenow-azure-firewall = [
      "tmod:@turbot/servicenow-azure-firewall#/policy/types/firewallServiceNowConfigurationItem"
    ],
    servicenow-azure-frontdoorservice = [
      "tmod:@turbot/servicenow-azure-frontdoorservice#/policy/types/frontDoorServiceNowConfigurationItem"
    ],
    servicenow-azure-iam = [
      "tmod:@turbot/servicenow-azure-iam#/policy/types/roleAssignmentServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure-iam#/policy/types/roleDefinitionServiceNowConfigurationItem"
    ],
    servicenow-azure-keyvault = [
      "tmod:@turbot/servicenow-azure-keyvault#/policy/types/keyServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure-keyvault#/policy/types/secretServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure-keyvault#/policy/types/vaultServiceNowConfigurationItem"
    ],
    servicenow-azure-loadbalancer = [
      "tmod:@turbot/servicenow-azure-loadbalancer#/policy/types/loadBalancerServiceNowConfigurationItem"
    ],
    servicenow-azure-loganalytics = [
      "tmod:@turbot/servicenow-azure-loganalytics#/policy/types/logAnalyticsWorkspaceServiceNowConfigurationItem"
    ],
    servicenow-azure-monitor = [
      "tmod:@turbot/servicenow-azure-monitor#/policy/types/actionGroupServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure-monitor#/policy/types/alertsServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure-monitor#/policy/types/logProfileServiceNowConfigurationItem"
    ],
    servicenow-azure-mysql = [
      "tmod:@turbot/servicenow-azure-mysql#/policy/types/flexibleServerServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure-mysql#/policy/types/serverServiceNowConfigurationItem"
    ],
    servicenow-azure-network = [
      "tmod:@turbot/servicenow-azure-network#/policy/types/applicationSecurityGroupServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure-network#/policy/types/expressRouteCircuitsServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure-network#/policy/types/networkInterfaceServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure-network#/policy/types/networkSecurityGroupServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure-network#/policy/types/privateDnsZonesServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure-network#/policy/types/privateEndpointsServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure-network#/policy/types/publicIpAddressServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure-network#/policy/types/routeTableServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure-network#/policy/types/subnetServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure-network#/policy/types/virtualNetworkGatewayServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure-network#/policy/types/virtualNetworkServiceNowConfigurationItem"
    ],
    servicenow-azure-networkwatcher = [
      "tmod:@turbot/servicenow-azure-networkwatcher#/policy/types/flowLogServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure-networkwatcher#/policy/types/networkWatcherServiceNowConfigurationItem"
    ],
    servicenow-azure-postgresql = [
      "tmod:@turbot/servicenow-azure-postgresql#/policy/types/flexibleServerServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure-postgresql#/policy/types/serverServiceNowConfigurationItem"
    ],
    servicenow-azure-recoveryservice = [
      "tmod:@turbot/servicenow-azure-recoveryservice#/policy/types/backupServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure-recoveryservice#/policy/types/vaultServiceNowConfigurationItem"
    ],
    servicenow-azure-relay = [
      "tmod:@turbot/servicenow-azure-relay#/policy/types/namespaceServiceNowConfigurationItem"
    ],
    servicenow-azure-searchmanagement = [
      "tmod:@turbot/servicenow-azure-searchmanagement#/policy/types/searchServiceServiceNowConfigurationItem"
    ],
    servicenow-azure-securitycenter = [
      "tmod:@turbot/servicenow-azure-securitycenter#/policy/types/securityCenterServiceNowConfigurationItem"
    ],
    servicenow-azure-servicebus = [
      "tmod:@turbot/servicenow-azure-servicebus#/policy/types/namespaceServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure-servicebus#/policy/types/queueServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure-servicebus#/policy/types/topicServiceNowConfigurationItem"
    ],
    servicenow-azure-signalr = [
      "tmod:@turbot/servicenow-azure-signalr#/policy/types/signalRServiceNowConfigurationItem"
    ],
    servicenow-azure-sql = [
      "tmod:@turbot/servicenow-azure-sql#/policy/types/databaseServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure-sql#/policy/types/elasticPoolServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure-sql#/policy/types/serverServiceNowConfigurationItem"
    ],
    servicenow-azure-sqlvirtualmachine = [
      "tmod:@turbot/servicenow-azure-sqlvirtualmachine#/policy/types/sqlVirtualMachineServiceNowConfigurationItem"
    ],
    servicenow-azure-storage = [
      "tmod:@turbot/servicenow-azure-storage#/policy/types/containerServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure-storage#/policy/types/fileShareServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure-storage#/policy/types/queueServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure-storage#/policy/types/storageAccountServiceNowConfigurationItem"
    ],
    servicenow-azure-synapseanalytics = [
      "tmod:@turbot/servicenow-azure-synapseanalytics#/policy/types/sqlPoolServiceNowConfigurationItem",
      "tmod:@turbot/servicenow-azure-synapseanalytics#/policy/types/synapseWorkspaceServiceNowConfigurationItem"
    ]
  }

  # Flatten the Configuration Item policies for installed mods
  servicenow_configuration_item_policies_azure = flatten([
    for mod in var.servicenow_mod_list_azure : local.servicenow_configuration_item_policy_map_azure[mod] if contains(keys(local.servicenow_configuration_item_policy_map_azure), mod)
  ])

  # Map of mods to their respective relationshups policies
  servicenow_relationships_policy_map_azure = {

    servicenow-azure = [
      "tmod:@turbot/servicenow-azure#/policy/types/resourceGroupServiceNowRelationships",
      "tmod:@turbot/servicenow-azure#/policy/types/subscriptionServiceNowRelationships"
    ],
    servicenow-azure-activedirectory = [
    ],
    servicenow-azure-aks = [
    ],
    servicenow-azure-apimanagement = [
    ],
    servicenow-azure-applicationgateway = [
    ],
    servicenow-azure-applicationinsights = [
    ],
    servicenow-azure-appservice = [
    ],
    servicenow-azure-automation = [
    ],
    servicenow-azure-compute = [
      "tmod:@turbot/servicenow-azure-compute#/policy/types/availabilitySetServiceNowRelationships",
      "tmod:@turbot/servicenow-azure-compute#/policy/types/diskServiceNowRelationships",
      "tmod:@turbot/servicenow-azure-compute#/policy/types/imageServiceNowRelationships",
      "tmod:@turbot/servicenow-azure-compute#/policy/types/snapshotServiceNowRelationships",
      "tmod:@turbot/servicenow-azure-compute#/policy/types/virtualMachineServiceNowRelationships"
    ],
    servicenow-azure-cosmosdb = [
    ],
    servicenow-azure-databricks = [
    ],
    servicenow-azure-datafactory = [
    ],
    servicenow-azure-dns = [
    ],
    servicenow-azure-firewall = [
    ],
    servicenow-azure-frontdoorservice = [
    ],
    servicenow-azure-iam = [
    ],
    servicenow-azure-keyvault = [
    ],
    servicenow-azure-loadbalancer = [
    ],
    servicenow-azure-loganalytics = [
    ],
    servicenow-azure-monitor = [
    ],
    servicenow-azure-mysql = [
    ],
    servicenow-azure-network = [
      "tmod:@turbot/servicenow-azure-network#/policy/types/applicationSecurityGroupServiceNowRelationships",
      "tmod:@turbot/servicenow-azure-network#/policy/types/networkInterfaceServiceNowRelationships",
      "tmod:@turbot/servicenow-azure-network#/policy/types/networkSecurityGroupServiceNowRelationships",
      "tmod:@turbot/servicenow-azure-network#/policy/types/publicIpAddressServiceNowRelationships",
      "tmod:@turbot/servicenow-azure-network#/policy/types/routeTableServiceNowRelationships",
      "tmod:@turbot/servicenow-azure-network#/policy/types/subnetServiceNowRelationships",
      "tmod:@turbot/servicenow-azure-network#/policy/types/virtualNetworkGatewayServiceNowRelationships",
      "tmod:@turbot/servicenow-azure-network#/policy/types/virtualNetworkServiceNowRelationships"
    ],
    servicenow-azure-networkwatcher = [
    ],
    servicenow-azure-postgresql = [
    ],
    servicenow-azure-recoveryservice = [
    ],
    servicenow-azure-relay = [
    ],
    servicenow-azure-searchmanagement = [
    ],
    servicenow-azure-securitycenter = [
    ],
    servicenow-azure-servicebus = [
    ],
    servicenow-azure-signalr = [
    ],
    servicenow-azure-sql = [
    ],
    servicenow-azure-sqlvirtualmachine = [
    ],
    servicenow-azure-storage = [
      "tmod:@turbot/servicenow-azure-storage#/policy/types/containerServiceNowRelationships",
      "tmod:@turbot/servicenow-azure-storage#/policy/types/fileShareServiceNowRelationships",
      "tmod:@turbot/servicenow-azure-storage#/policy/types/queueServiceNowRelationships",
      "tmod:@turbot/servicenow-azure-storage#/policy/types/storageAccountServiceNowRelationships"
    ],
    servicenow-azure-synapseanalytics = [
    ]
  }

  # Flatten the Relationships policies for installed mods
  servicenow_relationships_policies_azure = flatten([
    for mod in var.servicenow_mod_list_azure : local.servicenow_relationships_policy_map_azure[mod] if contains(keys(local.servicenow_relationships_policy_map_azure), mod)
  ])

}


