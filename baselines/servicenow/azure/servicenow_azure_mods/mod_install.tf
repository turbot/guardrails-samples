# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-azure
resource "turbot_mod" "servicenow-azure" {
  parent  = "tmod:@turbot/turbot#/"
  org     = "turbot"
  mod     = "servicenow-azure"
  version = ">=5.0.0"
  count   = contains(var.mod_list, "servicenow-azure") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-azure-activedirectory
resource "turbot_mod" "servicenow-azure-activedirectory" {
  parent  = "tmod:@turbot/turbot#/"
  org     = "turbot"
  mod     = "servicenow-azure-activedirectory"
  version = ">=5.0.0"
  count   = contains(var.mod_list, "servicenow-azure-activedirectory") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-azure-aks
resource "turbot_mod" "servicenow-azure-aks" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-azure]
  org        = "turbot"
  mod        = "servicenow-azure-aks"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-azure-aks") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-azure-apimanagement
resource "turbot_mod" "servicenow-azure-apimanagement" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-azure]
  org        = "turbot"
  mod        = "servicenow-azure-apimanagement"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-azure-apimanagement") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-azure-applicationgateway
resource "turbot_mod" "servicenow-azure-applicationgateway" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-azure]
  org        = "turbot"
  mod        = "servicenow-azure-applicationgateway"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-azure-applicationgateway") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-azure-applicationinsights
resource "turbot_mod" "servicenow-azure-applicationinsights" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-azure]
  org        = "turbot"
  mod        = "servicenow-azure-applicationinsights"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-azure-applicationinsights") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-azure-appservice
resource "turbot_mod" "servicenow-azure-appservice" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-azure]
  org        = "turbot"
  mod        = "servicenow-azure-appservice"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-azure-appservice") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-azure-automation
resource "turbot_mod" "servicenow-azure-automation" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-azure]
  org        = "turbot"
  mod        = "servicenow-azure-automation"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-azure-automation") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-azure-compute
resource "turbot_mod" "servicenow-azure-compute" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-azure]
  org        = "turbot"
  mod        = "servicenow-azure-compute"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-azure-compute") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-azure-cosmosdb
resource "turbot_mod" "servicenow-azure-cosmosdb" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-azure]
  org        = "turbot"
  mod        = "servicenow-azure-cosmosdb"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-azure-cosmosdb") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-azure-databricks
resource "turbot_mod" "servicenow-azure-databricks" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-azure]
  org        = "turbot"
  mod        = "servicenow-azure-databricks"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-azure-databricks") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-azure-datafactory
resource "turbot_mod" "servicenow-azure-datafactory" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-azure]
  org        = "turbot"
  mod        = "servicenow-azure-datafactory"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-azure-datafactory") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-azure-dns
resource "turbot_mod" "servicenow-azure-dns" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-azure]
  org        = "turbot"
  mod        = "servicenow-azure-dns"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-azure-dns") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-azure-firewall
resource "turbot_mod" "servicenow-azure-firewall" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-azure]
  org        = "turbot"
  mod        = "servicenow-azure-firewall"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-azure-firewall") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-azure-frontdoorservice
resource "turbot_mod" "servicenow-azure-frontdoorservice" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-azure]
  org        = "turbot"
  mod        = "servicenow-azure-frontdoorservice"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-azure-frontdoorservice") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-azure-iam
resource "turbot_mod" "servicenow-azure-iam" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-azure]
  org        = "turbot"
  mod        = "servicenow-azure-iam"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-azure-iam") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-azure-keyvault
resource "turbot_mod" "servicenow-azure-keyvault" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-azure]
  org        = "turbot"
  mod        = "servicenow-azure-keyvault"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-azure-keyvault") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-azure-loadbalancer
resource "turbot_mod" "servicenow-azure-loadbalancer" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-azure]
  org        = "turbot"
  mod        = "servicenow-azure-loadbalancer"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-azure-loadbalancer") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-azure-loganalytics
resource "turbot_mod" "servicenow-azure-loganalytics" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-azure]
  org        = "turbot"
  mod        = "servicenow-azure-loganalytics"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-azure-loganalytics") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-azure-monitor
resource "turbot_mod" "servicenow-azure-monitor" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-azure]
  org        = "turbot"
  mod        = "servicenow-azure-monitor"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-azure-monitor") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-azure-mysql
resource "turbot_mod" "servicenow-azure-mysql" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-azure]
  org        = "turbot"
  mod        = "servicenow-azure-mysql"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-azure-mysql") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-azure-network
resource "turbot_mod" "servicenow-azure-network" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-azure]
  org        = "turbot"
  mod        = "servicenow-azure-network"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-azure-network") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-azure-networkwatcher
resource "turbot_mod" "servicenow-azure-networkwatcher" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-azure]
  org        = "turbot"
  mod        = "servicenow-azure-networkwatcher"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-azure-networkwatcher") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-azure-postgresql
resource "turbot_mod" "servicenow-azure-postgresql" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-azure]
  org        = "turbot"
  mod        = "servicenow-azure-postgresql"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-azure-postgresql") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-azure-recoveryservice
resource "turbot_mod" "servicenow-azure-recoveryservice" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-azure]
  org        = "turbot"
  mod        = "servicenow-azure-recoveryservice"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-azure-recoveryservice") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-azure-relay
resource "turbot_mod" "servicenow-azure-relay" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-azure]
  org        = "turbot"
  mod        = "servicenow-azure-relay"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-azure-relay") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-azure-searchmanagement
resource "turbot_mod" "servicenow-azure-searchmanagement" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-azure]
  org        = "turbot"
  mod        = "servicenow-azure-searchmanagement"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-azure-searchmanagement") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-azure-securitycenter
resource "turbot_mod" "servicenow-azure-securitycenter" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-azure]
  org        = "turbot"
  mod        = "servicenow-azure-securitycenter"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-azure-securitycenter") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-azure-servicebus
resource "turbot_mod" "servicenow-azure-servicebus" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-azure]
  org        = "turbot"
  mod        = "servicenow-azure-servicebus"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-azure-servicebus") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-azure-signalr
resource "turbot_mod" "servicenow-azure-signalr" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-azure]
  org        = "turbot"
  mod        = "servicenow-azure-signalr"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-azure-signalr") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-azure-sql
resource "turbot_mod" "servicenow-azure-sql" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-azure]
  org        = "turbot"
  mod        = "servicenow-azure-sql"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-azure-sql") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-azure-sqlvirtualmachine
resource "turbot_mod" "servicenow-azure-sqlvirtualmachine" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-azure]
  org        = "turbot"
  mod        = "servicenow-azure-sqlvirtualmachine"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-azure-sqlvirtualmachine") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-azure-storage
resource "turbot_mod" "servicenow-azure-storage" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-azure]
  org        = "turbot"
  mod        = "servicenow-azure-storage"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-azure-storage") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-azure-synapseanalytics
resource "turbot_mod" "servicenow-azure-synapseanalytics" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-azure]
  org        = "turbot"
  mod        = "servicenow-azure-synapseanalytics"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-azure-synapseanalytics") ? 1 : 0
}
