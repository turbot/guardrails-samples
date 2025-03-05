variable "servicenow_mod_list_azure" {
  type = list(string)
  default = [
    #######################################
    #########  ServiceNow Azure  ##########
    #######################################
    "servicenow-azure",
    "servicenow-azure-activedirectory",
    "servicenow-azure-aks",
    "servicenow-azure-apimanagement",
    "servicenow-azure-applicationgateway",
    "servicenow-azure-applicationinsights",
    "servicenow-azure-appservice",
    "servicenow-azure-automation",
    "servicenow-azure-compute",
    "servicenow-azure-cosmosdb",
    "servicenow-azure-databricks",
    "servicenow-azure-datafactory",
    "servicenow-azure-dns",
    "servicenow-azure-firewall",
    "servicenow-azure-frontdoorservice",
    "servicenow-azure-iam",
    "servicenow-azure-keyvault",
    "servicenow-azure-loadbalancer",
    "servicenow-azure-loganalytics",
    "servicenow-azure-monitor",
    "servicenow-azure-mysql",
    "servicenow-azure-network",
    "servicenow-azure-networkwatcher",
    "servicenow-azure-postgresql",
    "servicenow-azure-recoveryservice",
    "servicenow-azure-relay",
    "servicenow-azure-searchmanagement",
    "servicenow-azure-securitycenter",
    "servicenow-azure-servicebus",
    "servicenow-azure-signalr"
  ]
}
