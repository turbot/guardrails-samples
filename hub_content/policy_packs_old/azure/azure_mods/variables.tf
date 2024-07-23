variable "mod_list" {
  type = "list"
  default = [
    "azure",
    "azure-activedirectory",
    "azure-aks",
    "azure-apimanagement",
    "azure-applicationgateway",
    "azure-applicationinsights",
    "azure-appservice",
    "azure-cisv1",
    "azure-compute",
    "azure-cosmosdb",
    "azure-databricks",
    "azure-datafactory",
    "azure-dns",
    "azure-firewall",
    "azure-frontdoorservice",
    "azure-iam",
    "azure-keyvault",
    "azure-loadbalancer",
    "azure-loganalytics",
    "azure-monitor",
    "azure-mysql",
    "azure-network",
    "azure-networkwatcher",
    "azure-postgresql",
    "azure-provider",
    "azure-recoveryservice",
    "azure-searchmanagement",
    "azure-securitycenter",
    "azure-sql",
    "azure-storage",
    "azure-synapseanalytics"
  ]
}

variable "turbot_profile" {
  type        = string
  description = "Turbot profile for the workspace where this terraform code will be executed"
}