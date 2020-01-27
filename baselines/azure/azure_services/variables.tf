
#### Enter a target_resource to set the policies on a specific resource. This can be an AKA or resource id.
variable "target_resource" {
  type    = string
}

# Enter the list of services that you would like to "Enable" or "Disable"
# Service names must match the "policy_map" below
variable "service_status" {
  type = map

  default = {
    azure-compute    = "Enabled"
    azure-cosmosdb   = "Enabled"
    azure-storage    = "Enabled"
    azure-network    = "Enabled"
    azure-appservice = "Disabled"
  }
}

#This is a map of Turbot policy types to service names. It is advised not to modify the below list.
variable "policy_map" {
  type = map

  default = {
    azure-aks                 = "aksEnabled"
    azure-apimanagement       = "apiManagementEnabled"
    azure-applicationgateway  = "applicationGatewayServiceEnabled"
    azure-applicationinsights = "applicationInsightsEnabled"
    azure-appservice          = "appServiceEnabled"
    azure-compute             = "computeEnabled"
    azure-cosmosdb            = "cosmosDbEnabled"
    azure-datafactory         = "dataFactoryEnabled"
    azure-dns                 = "dnsEnabled"
    azure-firewall            = "firewallServiceEnabled"
    azure-frontdoorservice    = "frontDoorsEnabled"
    azure-loadbalancer        = "loadBalancerServiceEnabled"
    azure-loganalytics        = "logAnalyticsEnabled"
    azure-mysql               = "mySqlEnabled"
    azure-network             = "networkEnabled"
    azure-postgresql          = "postgreSqlEnabled"
    azure-searchmanagement    = "searchEnabled"
    azure-sql                 = "sqlEnabled"
    azure-storage             = "storageEnabled"
  }
}