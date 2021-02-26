# https://turbot.com/v5/mods/turbot/azure
resource "turbot_mod" "azure" {
  parent  = "tmod:@turbot/turbot#/"
  org     = "turbot"
  mod     = "azure"
  version = ">=5.0.0-beta.1"
  count   = contains(var.mod_list, "azure") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/azure-provider
resource "turbot_mod" "azure-provider" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.azure"]
  org        = "turbot"
  mod        = "azure-provider"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "azure-provider") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/azure-iam
resource "turbot_mod" "azure-iam" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.azure"]
  org        = "turbot"
  mod        = "azure-iam"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "azure-iam") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/azure-activedirectory
resource "turbot_mod" "azure-activedirectory" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.azure"]
  org        = "turbot"
  mod        = "azure-activedirectory"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "azure-activedirectory") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/azure-aks
resource "turbot_mod" "azure-aks" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.azure", "turbot_mod.azure-iam", "turbot_mod.azure-provider"]
  org        = "turbot"
  mod        = "azure-aks"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "azure-aks") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/azure-apimanagement
resource "turbot_mod" "azure-apimanagement" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.azure", "turbot_mod.azure-iam", "turbot_mod.azure-provider"]
  org        = "turbot"
  mod        = "azure-apimanagement"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "azure-apimanagement") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/azure-applicationgateway
resource "turbot_mod" "azure-applicationgateway" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.azure", "turbot_mod.azure-iam", "turbot_mod.azure-provider"]
  org        = "turbot"
  mod        = "azure-applicationgateway"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "azure-applicationgateway") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/azure-applicationinsights
resource "turbot_mod" "azure-applicationinsights" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.azure", "turbot_mod.azure-iam", "turbot_mod.azure-provider"]
  org        = "turbot"
  mod        = "azure-applicationinsights"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "azure-applicationinsights") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/azure-appservice
resource "turbot_mod" "azure-appservice" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.azure", "turbot_mod.azure-iam", "turbot_mod.azure-provider"]
  org        = "turbot"
  mod        = "azure-appservice"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "azure-appservice") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/azure-compute
resource "turbot_mod" "azure-compute" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.azure", "turbot_mod.azure-iam", "turbot_mod.azure-provider"]
  org        = "turbot"
  mod        = "azure-compute"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "azure-compute") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/azure-cosmosdb
resource "turbot_mod" "azure-cosmosdb" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.azure", "turbot_mod.azure-iam", "turbot_mod.azure-provider"]
  org        = "turbot"
  mod        = "azure-cosmosdb"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "azure-cosmosdb") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/azure-databricks
resource "turbot_mod" "azure-databricks" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.azure", "turbot_mod.azure-iam", "turbot_mod.azure-provider"]
  org        = "turbot"
  mod        = "azure-databricks"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "azure-databricks") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/azure-datafactory
resource "turbot_mod" "azure-datafactory" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.azure", "turbot_mod.azure-iam", "turbot_mod.azure-provider"]
  org        = "turbot"
  mod        = "azure-datafactory"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "azure-datafactory") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/azure-dns
resource "turbot_mod" "azure-dns" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.azure", "turbot_mod.azure-iam", "turbot_mod.azure-provider"]
  org        = "turbot"
  mod        = "azure-dns"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "azure-dns") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/azure-firewall
resource "turbot_mod" "azure-firewall" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.azure", "turbot_mod.azure-iam", "turbot_mod.azure-provider"]
  org        = "turbot"
  mod        = "azure-firewall"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "azure-firewall") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/azure-frontdoorservice
resource "turbot_mod" "azure-frontdoorservice" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.azure", "turbot_mod.azure-iam"]
  org        = "turbot"
  mod        = "azure-frontdoorservice"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "azure-frontdoorservice") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/azure-loadbalancer
resource "turbot_mod" "azure-loadbalancer" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.azure", "turbot_mod.azure-iam", "turbot_mod.azure-provider"]
  org        = "turbot"
  mod        = "azure-loadbalancer"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "azure-loadbalancer") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/azure-loganalytics
resource "turbot_mod" "azure-loganalytics" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.azure", "turbot_mod.azure-iam", "turbot_mod.azure-provider"]
  org        = "turbot"
  mod        = "azure-loganalytics"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "azure-loganalytics") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/azure-monitor
resource "turbot_mod" "azure-monitor" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.azure", "turbot_mod.azure-iam", "turbot_mod.azure-provider"]
  org        = "turbot"
  mod        = "azure-monitor"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "azure-monitor") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/azure-mysql
resource "turbot_mod" "azure-mysql" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.azure", "turbot_mod.azure-iam", "turbot_mod.azure-provider"]
  org        = "turbot"
  mod        = "azure-mysql"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "azure-mysql") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/azure-network
resource "turbot_mod" "azure-network" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.azure", "turbot_mod.azure-iam", "turbot_mod.azure-provider"]
  org        = "turbot"
  mod        = "azure-network"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "azure-network") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/azure-postgresql
resource "turbot_mod" "azure-postgresql" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.azure", "turbot_mod.azure-iam", "turbot_mod.azure-provider"]
  org        = "turbot"
  mod        = "azure-postgresql"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "azure-postgresql") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/azure-recoveryservice
resource "turbot_mod" "azure-recoveryservice" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.azure", "turbot_mod.azure-iam", "turbot_mod.azure-provider"]
  org        = "turbot"
  mod        = "azure-recoveryservice"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "azure-recoveryservice") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/azure-searchmanagement
resource "turbot_mod" "azure-searchmanagement" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.azure", "turbot_mod.azure-iam", "turbot_mod.azure-provider"]
  org        = "turbot"
  mod        = "azure-searchmanagement"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "azure-searchmanagement") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/azure-securitycenter
resource "turbot_mod" "azure-securitycenter" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.azure", "turbot_mod.azure-iam", "turbot_mod.azure-provider"]
  org        = "turbot"
  mod        = "azure-securitycenter"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "azure-securitycenter") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/azure-sql
resource "turbot_mod" "azure-sql" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.azure", "turbot_mod.azure-iam", "turbot_mod.azure-provider"]
  org        = "turbot"
  mod        = "azure-sql"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "azure-sql") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/azure-storage
resource "turbot_mod" "azure-storage" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.azure", "turbot_mod.azure-iam", "turbot_mod.azure-provider"]
  org        = "turbot"
  mod        = "azure-storage"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "azure-storage") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/azure-synapseanalytics
resource "turbot_mod" "azure-synapseanalytics" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.azure", "turbot_mod.azure-iam", "turbot_mod.azure-provider"]
  org        = "turbot"
  mod        = "azure-synapseanalytics"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "azure-synapseanalytics") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/azure-keyvault
resource "turbot_mod" "azure-keyvault" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.azure", "turbot_mod.azure-iam", "turbot_mod.azure-provider"]
  org        = "turbot"
  mod        = "azure-keyvault"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "azure-keyvault") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/azure-networkwatcher
resource "turbot_mod" "azure-networkwatcher" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.azure", "turbot_mod.azure-iam", "turbot_mod.azure-provider"]
  org        = "turbot"
  mod        = "azure-networkwatcher"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "azure-networkwatcher") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/azure-cisv1
resource "turbot_mod" "azure-cisv1" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [ "turbot_mod.azure", "turbot_mod.azure-iam", "turbot_mod.azure-appservice", "turbot_mod.azure-compute", "turbot_mod.azure-keyvault", "turbot_mod.azure-monitor", "turbot_mod.azure-mysql", "turbot_mod.azure-network", "turbot_mod.azure-provider", "turbot_mod.azure-securitycenter", "turbot_mod.azure-sql", "turbot_mod.azure-postgresql", "turbot_mod.azure-storage", "turbot_mod.azure-networkwatcher", "turbot_mod.azure-aks"]
  org        = "turbot"
  mod        = "azure-cisv1"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "azure-cisv1") ? 1 : 0
}
