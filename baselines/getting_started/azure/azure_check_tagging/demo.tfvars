# List of services and resources to be Check: Tags are correct.
# Started with a few resource types to get started aligned with the initial mods installed
# You can remove the comment per row to include the resource type.  Make sure you have that related service mod install

# Acceptable Values:
# "Skip"
# "Check: Tags are correct"
# "Enforce: Set tags"

### These tags must exist for Missing Tag use case if enabled
### required_tags = [
###    "Owner",
###    "Contact",
###    "Cost Center",
###    "Project ID",
###    "Department",
### ]

resource_tags = { 
    azure-aks-managed-cluster                       = "Check: Tags are correct"
    # azure-apimanagement-service                     = "Check: Tags are correct"
    # azure-application-gateway                       = "Check: Tags are correct"
    # azure-application-insights-insight              = "Check: Tags are correct"
    # azure-compute-availability-set                  = "Check: Tags are correct"
    # azure-compute-disk                              = "Check: Tags are correct"
    # azure-compute-disk-encryption-set               = "Check: Tags are correct"
    # azure-compute-image                             = "Check: Tags are correct"
    # azure-compute-snapshot                          = "Check: Tags are correct"
    azure-compute-virtual-machine                   = "Check: Tags are correct"
    azure-cosmosdb-database                         = "Check: Tags are correct"
    # azure-databricks-workspace                      = "Check: Tags are correct"
    # azure-datafactory-factory                       = "Check: Tags are correct"
    # azure-dns-record-set                            = "Check: Tags are correct"
    # azure-dns-zone                                  = "Check: Tags are correct"
    # azure-firewall                                  = "Check: Tags are correct"
    # azure-keyvault-vault                            = "Check: Tags are correct"
    # azure-loadbalancer                              = "Check: Tags are correct"
    azure-mysql-server                              = "Check: Tags are correct"
    azure-network-application-security-group        = "Check: Tags are correct"
    # azure-network-network-interface                 = "Check: Tags are correct"
    # azure-network-network-security-groups           = "Check: Tags are correct"
    # azure-network-public-ip-address                 = "Check: Tags are correct"
    # azure-network-route-table                       = "Check: Tags are correct"
    # azure-network-virtual-network                   = "Check: Tags are correct"
    # azure-networkwatcher                            = "Check: Tags are correct"
    azure-postgresql-server                         = "Check: Tags are correct"
    # azure-recoveryservice-vault                     = "Check: Tags are correct"
    azure-resourcegroup                             = "Check: Tags are correct"
    # azure-searchmanagement-search-service           = "Check: Tags are correct"
    azure-sql-database                              = "Check: Tags are correct"
    # azure-sql-elastic-pool                          = "Check: Tags are correct"
    azure-sql-server                                = "Check: Tags are correct"
    azure-storage-storage-account                   = "Check: Tags are correct"
    # azure-synapseanalytics-sql-pool                 = "Check: Tags are correct"
    azure-synapseanalytics-workspace                = "Check: Tags are correct"
}

# Mapping of resource name for the policy
# Note: the resource map above dictates the applicable use of each line item below.  You do not need to comment out these items to reduce scope
policy_map  = {
    azure-aks-managed-cluster                       = "tmod:@turbot/azure-aks#/policy/types/managedClusterTags"
    azure-apimanagement-service                     = "tmod:@turbot/azure-apimanagement#/policy/types/apiManagementServiceTags"
    azure-application-gateway                       = "tmod:@turbot/azure-applicationgateway#/policy/types/applicationGatewayTags"
    azure-application-insights-insight              = "tmod:@turbot/azure-applicationinsights#/policy/types/applicationInsightTags"
    azure-compute-availability-set                  = "tmod:@turbot/azure-compute#/policy/types/availabilitySetTags"
    azure-compute-disk                              = "tmod:@turbot/azure-compute#/policy/types/diskTags"
    azure-compute-disk-encryption-set               = "tmod:@turbot/azure-compute#/policy/types/diskEncryptionSetTags"
    azure-compute-image                             = "tmod:@turbot/azure-compute#/policy/types/imageTags"
    azure-compute-snapshot                          = "tmod:@turbot/azure-compute#/policy/types/snapshotTags"
    azure-compute-virtual-machine                   = "tmod:@turbot/azure-compute#/policy/types/virtualMachineTags"
    azure-cosmosdb-database                         = "tmod:@turbot/azure-cosmosdb#/policy/types/databaseAccountTags"
    azure-databricks-workspace                      = "tmod:@turbot/azure-databricks#/policy/types/databricksWorkspaceTags"
    azure-datafactory-factory                       = "tmod:@turbot/azure-datafactory#/policy/types/factoryTags"
    azure-dns-record-set                            = "tmod:@turbot/azure-dns#/policy/types/recordSetTags"
    azure-dns-zone                                  = "tmod:@turbot/azure-dns#/policy/types/zoneTags"
    azure-firewall                                  = "tmod:@turbot/azure-firewall#/policy/types/firewallTags"
    azure-keyvault-vault                            = "tmod:@turbot/azure-keyvault#/policy/types/vaultTags"
    azure-loadbalancer                              = "tmod:@turbot/azure-loadbalancer#/policy/types/loadBalancerTags"
    azure-mysql-server                              = "tmod:@turbot/azure-mysql#/policy/types/serverTags"
    azure-network-application-security-group        = "tmod:@turbot/azure-network#/policy/types/applicationSecurityGroupTags"
    azure-network-network-interface                 = "tmod:@turbot/azure-network#/policy/types/networkInterfaceTags"
    azure-network-network-security-groups           = "tmod:@turbot/azure-network#/policy/types/networkSecurityGroupTags"
    azure-network-public-ip-address                 = "tmod:@turbot/azure-network#/policy/types/publicIpAddressTags"
    azure-network-route-table                       = "tmod:@turbot/azure-network#/policy/types/routeTableTags"
    azure-network-virtual-network                   = "tmod:@turbot/azure-network#/policy/types/virtualNetworkTags"
    azure-networkwatcher                            = "tmod:@turbot/azure-networkwatcher#/policy/types/networkWatcherTags"
    azure-postgresql-server                         = "tmod:@turbot/azure-postgresql#/policy/types/serverTags"
    azure-recoveryservice-vault                     = "tmod:@turbot/azure-recoveryservice#/policy/types/vaultTags"
    azure-resourcegroup                             = "tmod:@turbot/azure#/policy/types/resourceGroupTags"
    azure-searchmanagement-search-service           = "tmod:@turbot/azure-searchmanagement#/policy/types/searchServiceTags"
    azure-sql-database                              = "tmod:@turbot/azure-sql#/policy/types/databaseTags"
    azure-sql-elastic-pool                          = "tmod:@turbot/azure-sql#/policy/types/elasticPoolTags"
    azure-sql-server                                = "tmod:@turbot/azure-sql#/policy/types/serverTags"
    azure-storage-storage-account                   = "tmod:@turbot/azure-storage#/policy/types/storageAccountTags"
    azure-synapseanalytics-sql-pool                 = "tmod:@turbot/azure-synapseanalytics#/policy/types/sqlPoolTags"
    azure-synapseanalytics-workspace                = "tmod:@turbot/azure-synapseanalytics#/policy/types/synapseWorkspaceTags"
}

# Mapping of resource name to the policy map
# Note: the resource map above dictates the applicable use of each line item below.  You do not need to comment out these items to reduce scope
policy_map_template  = {
    azure-aks-managed-cluster                       = "tmod:@turbot/azure-aks#/policy/types/managedClusterTagsTemplate"
    azure-apimanagement-service                     = "tmod:@turbot/azure-apimanagement#/policy/types/apiManagementServiceTagsTemplate"
    azure-application-gateway                       = "tmod:@turbot/azure-applicationgateway#/policy/types/applicationGatewayTagsTemplate"
    azure-application-insights-insight              = "tmod:@turbot/azure-applicationinsights#/policy/types/applicationInsightTagsTemplate"
    azure-compute-availability-set                  = "tmod:@turbot/azure-compute#/policy/types/availabilitySetTagsTemplate"
    azure-compute-disk                              = "tmod:@turbot/azure-compute#/policy/types/diskTagsTemplate"
    azure-compute-disk-encryption-set               = "tmod:@turbot/azure-compute#/policy/types/diskEncryptionSetTagsTemplate"
    azure-compute-image                             = "tmod:@turbot/azure-compute#/policy/types/imageTagsTemplate"
    azure-compute-snapshot                          = "tmod:@turbot/azure-compute#/policy/types/snapshotTagsTemplate"
    azure-compute-virtual-machine                   = "tmod:@turbot/azure-compute#/policy/types/virtualMachineTagsTemplate"
    azure-cosmosdb-database                         = "tmod:@turbot/azure-cosmosdb#/policy/types/databaseAccountTagsTemplate"
    azure-databricks-workspace                      = "tmod:@turbot/azure-databricks#/policy/types/databricksWorkspaceTagsTemplate"
    azure-datafactory-factory                       = "tmod:@turbot/azure-datafactory#/policy/types/factoryTagsTemplate"
    azure-dns-record-set                            = "tmod:@turbot/azure-dns#/policy/types/recordSetTagsTemplate"
    azure-dns-zone                                  = "tmod:@turbot/azure-dns#/policy/types/zoneTagsTemplate"
    azure-firewall                                  = "tmod:@turbot/azure-firewall#/policy/types/firewallTagsTemplate"
    azure-keyvault-vault                            = "tmod:@turbot/azure-keyvault#/policy/types/vaultTagsTemplate"
    azure-loadbalancer                              = "tmod:@turbot/azure-loadbalancer#/policy/types/loadBalancerTagsTemplate"
    azure-mysql-server                              = "tmod:@turbot/azure-mysql#/policy/types/serverTagsTemplate"
    azure-network-application-security-group        = "tmod:@turbot/azure-network#/policy/types/applicationSecurityGroupTagsTemplate"
    azure-network-network-interface                 = "tmod:@turbot/azure-network#/policy/types/networkInterfaceTagsTemplate"
    azure-network-network-security-groups           = "tmod:@turbot/azure-network#/policy/types/networkSecurityGroupTagsTemplate"
    azure-network-public-ip-address                 = "tmod:@turbot/azure-network#/policy/types/publicIpAddressTagsTemplate"
    azure-network-route-table                       = "tmod:@turbot/azure-network#/policy/types/routeTableTagsTemplate"
    azure-network-virtual-network                   = "tmod:@turbot/azure-network#/policy/types/virtualNetworkTagsTemplate"
    azure-networkwatcher                            = "tmod:@turbot/azure-networkwatcher#/policy/types/networkWatcherTagsTemplate"
    azure-postgresql-server                         = "tmod:@turbot/azure-postgresql#/policy/types/serverTagsTemplate"
    azure-recoveryservice-vault                     = "tmod:@turbot/azure-recoveryservice#/policy/types/vaultTagsTemplate"
    azure-resourcegroup                             = "tmod:@turbot/azure#/policy/types/resourceGroupTagsTemplate"
    azure-searchmanagement-search-service           = "tmod:@turbot/azure-searchmanagement#/policy/types/searchServiceTagsTemplate"
    azure-sql-database                              = "tmod:@turbot/azure-sql#/policy/types/databaseTagsTemplate"
    azure-sql-elastic-pool                          = "tmod:@turbot/azure-sql#/policy/types/elasticPoolTagsTemplate"
    azure-sql-server                                = "tmod:@turbot/azure-sql#/policy/types/serverTagsTemplate"
    azure-storage-storage-account                   = "tmod:@turbot/azure-storage#/policy/types/storageAccountTagsTemplate"
    azure-synapseanalytics-sql-pool                 = "tmod:@turbot/azure-synapseanalytics#/policy/types/sqlPoolTagsTemplate"
    azure-synapseanalytics-workspace                = "tmod:@turbot/azure-synapseanalytics#/policy/types/synapseWorkspaceTagsTemplate"
}