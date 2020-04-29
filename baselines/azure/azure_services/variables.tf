variable "target_resource" {
  description = "Enter a target_resource to set the policies on a specific resource. This can be an AKA or resource id:"
  type        = string
}

variable "smart_folder_title" {
  description = "Folder to import the Azure Subscription:"
  type        = string
}

# Defaults to the Turbot Resource level using the AKA which identifies the Turbot level.
variable "folder_parent" {
  type    = string
  default = "tmod:@turbot/turbot#/"
}

# Enter the list of services that you would like to "Enable" or "Disable"
# Service names must match the key names for the "policy_map" below
variable "service_status" {
  description = "Choose the subset of services that should be configured. Possible values for each service are: [\"Enabled\", \"Disabled\"]"
  type        = map

  default = {
    azure-aks                 = "Enabled"
    azure-apimanagement       = "Enabled"
    azure-applicationgateway  = "Enabled"
    azure-applicationinsights = "Enabled"
    azure-appservice          = "Enabled"
    azure-compute             = "Enabled"
    azure-cosmosdb            = "Enabled"
    azure-databricks          = "Enabled"
    azure-datafactory         = "Enabled"
    azure-dns                 = "Enabled"
    azure-firewall            = "Enabled"
    azure-frontdoorservice    = "Enabled"
    azure-iam                 = "Enabled"
    azure-keyvault            = "Enabled"
    azure-loadbalancer        = "Enabled"
    azure-loganalytics        = "Enabled"
    azure-monitor             = "Enabled"
    azure-mysql               = "Enabled"
    azure-network             = "Enabled"
    azure-networkwatcher      = "Enabled"
    azure-postgresql          = "Enabled"
    azure-recoveryservice     = "Enabled"
    azure-searchmanagement    = "Enabled"
    azure-securitycenter      = "Enabled"
    azure-sql                 = "Enabled"
    azure-storage             = "Enabled"
  }
}

# This is a map of Turbot policy types to service names. It is advised not to modify the below list.
variable "policy_map" {
  description = "A map of all the enabled policies currently exposed by Turbot"
  type        = map

  default = {
    azure-aks                 = "aksEnabled"
    azure-apimanagement       = "apiManagementEnabled"
    azure-applicationgateway  = "applicationGatewayServiceEnabled"
    azure-applicationinsights = "applicationInsightsEnabled"
    azure-appservice          = "appServiceEnabled"
    azure-compute             = "computeEnabled"
    azure-cosmosdb            = "cosmosDbEnabled"
    azure-databricks          = "databricksEnabled"
    azure-datafactory         = "dataFactoryEnabled"
    azure-dns                 = "dnsEnabled"
    azure-firewall            = "firewallServiceEnabled"
    azure-frontdoorservice    = "frontDoorServiceEnabled"
    azure-iam                 = "iamEnabled"
    azure-keyvault            = "keyVaultEnabled"
    azure-loadbalancer        = "loadBalancerServiceEnabled"
    azure-loganalytics        = "logAnalyticsEnabled"
    azure-monitor             = "monitorEnabled"
    azure-mysql               = "mySqlEnabled"
    azure-network             = "networkEnabled"
    azure-networkwatcher      = "networkWatcherServiceEnabled"
    azure-postgresql          = "postgreSqlEnabled"
    azure-recoveryservice     = "recoveryServiceEnabled"
    azure-searchmanagement    = "searchManagementEnabled"
    azure-securitycenter      = "securityCenterServiceEnabled"
    azure-sql                 = "sqlEnabled"
    azure-storage             = "storageEnabled"
  }
}
