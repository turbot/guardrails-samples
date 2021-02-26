# List of services and resources to be Check: Approved.
# Started with a few resource types to get started aligned with the initial mods installed
# You can remove the comment per row to include the resource type.  Make sure you have the related service mod installed

# Acceptable Values:
# "Skip"
# "Check: Approved"
# "Enforce: Delete unapproved if new"

resource_approved_regions = { 
    azure-aks-managed-cluster                       = "Check: Approved"
    azure-apimanagement-service                     = "Check: Approved"
    azure-application-gateway                       = "Check: Approved"
    azure-application-insights-insight              = "Check: Approved"
    azure-appservice-plan                           = "Check: Approved"
    azure-appservice-function-app                   = "Check: Approved"
    azure-compute-availability-set                  = "Check: Approved"
    azure-compute-disk                              = "Check: Approved"
    azure-compute-disk-encryption-set               = "Check: Approved"
    azure-compute-image                             = "Check: Approved"
    azure-compute-snapshot                          = "Check: Approved"
    azure-compute-virtual-machine                   = "Check: Approved"
    azure-cosmosdb-database                         = "Check: Approved"
    azure-databricks-workspace                      = "Check: Approved"
    azure-datafactory-factory                       = "Check: Approved"
    azure-firewall                                  = "Check: Approved"
    azure-keyvault-key                              = "Check: Approved"
    azure-keyvault-secret                           = "Check: Approved"
    azure-keyvault-vault                            = "Check: Approved"
    azure-loganalytics-workspace                    = "Check: Approved"
    azure-loadbalancer                              = "Check: Approved"
    azure-mysql-server                              = "Check: Approved"
    azure-network-application-security-group        = "Check: Approved"
    azure-network-network-interface                 = "Check: Approved"
    azure-network-network-security-groups           = "Check: Approved"
    azure-network-public-ip-address                 = "Check: Approved"
    azure-network-route-table                       = "Check: Approved"
    azure-network-virtual-network                   = "Check: Approved"
    azure-networkwatcher                            = "Check: Approved"
    azure-postgresql-server                         = "Check: Approved"
    azure-recoveryservice-vault                     = "Check: Approved"
    azure-searchmanagement-search-service           = "Check: Approved"
    azure-sql-database                              = "Check: Approved"
    azure-sql-elastic-pool                          = "Check: Approved"
    azure-sql-server                                = "Check: Approved"
    azure-storage-storage-account                   = "Check: Approved"
    azure-synapseanalytics-workspace                = "Check: Approved"
}

# NOTE: For full list of values, look in variables.tf at the default value
resource_approved_regions_region_list = [
    "eastus",
    "eastus2"
]
