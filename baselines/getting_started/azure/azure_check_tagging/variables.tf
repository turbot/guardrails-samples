variable "resource_tags" {
description = <<DESC
List of services and resources to be checked if its Tags are correct.
These tags must exist for Missing Tag use case if enabled
required_tags = [
  "Owner",
  "Contact",
  "Cost Center",
  "Project ID",
  "Department",
]
The value of the map is one of these possible values:
Acceptable Values:
  "Skip"
  "Check: Tags are correct"
  "Enforce: Set tags"
Check demo.tfvars for an example of how to set this value.
DESC
type          =map(string)
default = {
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
}

variable "turbot_profile" {
  description = "Enter profile matching your turbot cli credentials."
}

variable "smart_folder_name" {
  description = "Smart folder name for the baseline"
  type        = string
  default     = "Azure Tagging Policies"
}

variable "smart_folder_description" {
  description = "Enter a description for the smart folder"
  type        = string
  default     = "Defines sets of policies for the Azure Tagging baseline"
}

variable "smart_folder_parent_resource" {
  description = "Enter the resource ID or AKA for the parent of the smart folder"
  type        = string
  default     = "tmod:@turbot/turbot#/"
} 