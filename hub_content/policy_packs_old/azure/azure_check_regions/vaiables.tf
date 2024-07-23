# Baseline Configuration

variable "resource_approved_regions" {
  description = <<DESC
  Map of the list of approved regions controls.

  Possible values for the key of this map is found in locals.tf defined in the local variable policy_map.
  For example azure-aks-managed-cluster : "tmod:@turbot/azure-aks#/policy/types/managedClusterApproved"` has key `azure-aks-managed-cluster`.

  The value of the map is one of these possible values:
    - "Skip"
    - "Check: Approved"
    - "Enforce: Delete unapproved if new"

  Check demo.tfvars for an example of how to set this value.

  NOTE: Default behaviour is to approve all services which means expecting all mods to be installed
  DESC
  type        = map(string)
  default = {
    azure-aks-managed-cluster                = "Check: Approved"
    azure-apimanagement-service              = "Check: Approved"
    azure-application-gateway                = "Check: Approved"
    azure-application-insights-insight       = "Check: Approved"
    azure-appservice-plan                    = "Check: Approved"
    azure-appservice-function-app            = "Check: Approved"
    azure-compute-availability-set           = "Check: Approved"
    azure-compute-disk                       = "Check: Approved"
    azure-compute-disk-encryption-set        = "Check: Approved"
    azure-compute-image                      = "Check: Approved"
    azure-compute-snapshot                   = "Check: Approved"
    azure-compute-virtual-machine            = "Check: Approved"
    azure-cosmosdb-database                  = "Check: Approved"
    azure-databricks-workspace               = "Check: Approved"
    azure-datafactory-factory                = "Check: Approved"
    azure-firewall                           = "Check: Approved"
    azure-keyvault-key                       = "Check: Approved"
    azure-keyvault-secret                    = "Check: Approved"
    azure-keyvault-vault                     = "Check: Approved"
    azure-loganalytics-workspace             = "Check: Approved"
    azure-loadbalancer                       = "Check: Approved"
    azure-mysql-server                       = "Check: Approved"
    azure-network-application-security-group = "Check: Approved"
    azure-network-network-interface          = "Check: Approved"
    azure-network-network-security-groups    = "Check: Approved"
    azure-network-public-ip-address          = "Check: Approved"
    azure-network-route-table                = "Check: Approved"
    azure-network-virtual-network            = "Check: Approved"
    azure-networkwatcher                     = "Check: Approved"
    azure-postgresql-server                  = "Check: Approved"
    azure-recoveryservice-vault              = "Check: Approved"
    azure-searchmanagement-search-service    = "Check: Approved"
    azure-sql-database                       = "Check: Approved"
    azure-sql-elastic-pool                   = "Check: Approved"
    azure-sql-server                         = "Check: Approved"
    azure-storage-storage-account            = "Check: Approved"
    azure-synapseanalytics-workspace         = "Check: Approved"
  }
}


variable "resource_approved_regions_region_list" {
  description = <<DESC
  The expected format is an array of regions names. You may use the '*' and '?' wildcard characters.
  Example of values:
    - eastus
    - eastus2

  NOTE: Default behaviour is to approve all regions
  DESC
  type        = list(string)
  default = [
    "eastus",
    "eastus"
    # "southcentralus"
    # "westus2"
    # "australiaeast"
    # "southeastasia"
    # "northeurope"
    # "uksouth"
    # "westeurope"
    # "centralus"
    # "northcentralus"
    # "westus"
    # "southafricanorth"
    # "centralindia"
    # "eastasia"
    # "japaneast"
    # "koreacentral"
    # "canadacentral"
    # "francecentral"
    # "germanywestcentral"
    # "norwayeast"
    # "switzerlandnorth"
    # "uaenorth"
    # "brazilsouth"
    # "westcentralus"
    # "australiacentral"
    # "australiasoutheast"
    # "japanwest"
    # "koreasouth"
    # "southindia"
    # "westindia"
    # "canadaeast"
    # "ukwest"
  ]
}

# Optional Common Baseline Configuration

variable "turbot_profile" {
  description = "Enter profile matching your turbot cli credentials."
}

variable "smart_folder_name" {
  description = "Smart folder name for the baseline"
  type        = string
  default     = "Azure Check Regions Policies"
}

variable "smart_folder_description" {
  description = "Enter a description for the smart folder"
  type        = string
  default     = "Defines sets of policies for the Azure check regions baseline"
}

variable "smart_folder_parent_resource" {
  description = "Enter the resource ID or AKA for the parent of the smart folder"
  type        = string
  default     = "tmod:@turbot/turbot#/"
}
