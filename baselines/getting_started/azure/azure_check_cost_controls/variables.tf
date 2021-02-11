variable "resource_active" {
  description = <<DESC
  Map of the list of resources to be active.
  Possible values for the key of this map is found in locals.tf defined in the local variable policy_map.
  For example `azure-compute-virtualMachine` : "tmod:@turbot/azure-compute#/policy/types/virtualMachineActive"
  The value of the map is one of these possible values:
      "Skip"
      "Check: Active"
      "Enforce: Delete inactive with 1 day warning"
      "Enforce: Delete inactive with 3 days warning"
      "Enforce: Delete inactive with 7 days warning"
      "Enforce: Delete inactive with 14 days warning"
      "Enforce: Delete inactive with 30 days warning"
      "Enforce: Delete inactive with 60 days warning"
      "Enforce: Delete inactive with 90 days warning"
      "Enforce: Delete inactive with 180 days warning"
      "Enforce: Delete inactive with 365 days warning"
  Check demo.tfvars for an example of how to set this value.
  NOTE: Default behaviour is to approve all services which means expecting all mods to be installed
  DESC
  type        = map(string)
  default = {
    azure-aks-managedCluster                     = "Check: Active"
    # azure-applicationgateway-applicationGateway  = "Check: Active"
    # azure-applicationinsights-applicationInsight = "Check: Active"
    # azure-apimanagement-apiManagementService     = "Check: Active"
    # azure-appservice-appServicePlan              = "Check: Active"
    # azure-appservice-functionApp                 = "Check: Active"
    # azure-appservice-webApp                      = "Check: Active"
    # azure-compute-availabilitySet                = "Check: Active"
    ##Have Unattached Policy Set instead##azure-compute-disk                           = "Check: Active"
    # azure-compute-diskEncryptionSet              = "Check: Active"
    azure-compute-image                          = "Check: Active"
    azure-compute-snapshot                       = "Check: Active"
    azure-compute-virtualMachine                 = "Check: Active"
    azure-cosmosdb-databaseAccount               = "Check: Active"
    # azure-cosmosdb-mongoDbCollection             = "Check: Active"
    azure-cosmosdb-mongoDbDatabase               = "Check: Active"
    azure-cosmosdb-sqlContainer                  = "Check: Active"
    azure-cosmosdb-sqlDatabase                   = "Check: Active"
    azure-databricks-databricksWorkspace         = "Check: Active"
    # azure-datafactory-dataset                    = "Check: Active"
    # azure-datafactory-factory                    = "Check: Active"
    # azure-datafactory-pipeline                   = "Check: Active"
    # azure-dns-recordSet                          = "Check: Active"
    # azure-dns-zone                               = "Check: Active"
    # azure-firewall-firewall                      = "Check: Active"
    # azure-frontdoorservice-frontDoor             = "Check: Active"
    # azure-iam-roleAssignment                     = "Check: Active"
    # azure-iam-roleDefinition                     = "Check: Active"
    # azure-keyvault-key                           = "Check: Active"
    # azure-keyvault-secret                        = "Check: Active"
    # azure-keyvault-vault                         = "Check: Active"
    # azure-loadbalancer-loadBalancer              = "Check: Active"
    # azure-loganalytics-logAnalyticsWorkspace     = "Check: Active"
    # azure-monitor-actionGroup                    = "Check: Active"
    # azure-monitor-alerts                         = "Check: Active"
    # azure-monitor-logProfile                     = "Check: Active"
    azure-mysql-server                           = "Check: Active"
    # azure-network-applicationSecurityGroup       = "Check: Active"
    # azure-network-networkInterface               = "Check: Active"
    # azure-network-networkSecurityGroup           = "Check: Active"
    # azure-network-publicIpAddress                = "Check: Active"
    # azure-network-routeTable                     = "Check: Active"
    # azure-network-subnet                         = "Check: Active"
    # azure-network-virtualNetwork                 = "Check: Active"
    # azure-networkwatcher-flowLog                 = "Check: Active"
    # azure-networkwatcher-networkWatcher          = "Check: Active"
    azure-postgresql-database                    = "Check: Active"
    azure-postgresql-server                      = "Check: Active"
    # azure-recoveryservice-vault                  = "Check: Active"
    # azure-searchmanagement-searchService         = "Check: Active"
    azure-sql-database                           = "Check: Active"
    # azure-sql-elasticPool                        = "Check: Active"
    azure-sql-server                             = "Check: Active"
    azure-storage-container                      = "Check: Active"
    azure-storage-fileShare                      = "Check: Active"
    azure-storage-storageAccount                 = "Check: Active"
    # azure-synapseanalytics-sqlPool               = "Check: Active"
    azure-synapseanalytics-synapseWorkspace      = "Check: Active"
  }
}

variable "turbot_profile" {
  description = "Enter profile matching your turbot cli credentials."
}

variable "smart_folder_name" {
  description = "Smart folder name for the baseline"
  type        = string
  default     = "Azure Check Cost Control Policies"
}

variable "smart_folder_description" {
  description = "Enter a description for the smart folder"
  type        = string
  default     = "Defines sets of policies for Azure check regions baseline"
}

variable "smart_folder_parent_resource" {
  description = "Enter the resource ID or AKA for the parent of the smart folder"
  type        = string
  default     = "tmod:@turbot/turbot#/"
} 