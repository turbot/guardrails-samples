# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-gcp
resource "turbot_mod" "servicenow-gcp" {
  parent  = "tmod:@turbot/turbot#/"
  org     = "turbot"
  mod     = "servicenow-gcp"
  version = ">=5.0.0"
  count   = contains(var.mod_list, "servicenow-gcp") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-gcp-appengine
resource "turbot_mod" "servicenow-gcp-appengine" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-gcp]
  org        = "turbot"
  mod        = "servicenow-gcp-appengine"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-gcp-appengine") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-gcp-bigquery
resource "turbot_mod" "servicenow-gcp-bigquery" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-gcp]
  org        = "turbot"
  mod        = "servicenow-gcp-bigquery"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-gcp-bigquery") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-gcp-bigtable
resource "turbot_mod" "servicenow-gcp-bigtable" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-gcp]
  org        = "turbot"
  mod        = "servicenow-gcp-bigtable"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-gcp-bigtable") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-gcp-composer
resource "turbot_mod" "servicenow-gcp-composer" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-gcp]
  org        = "turbot"
  mod        = "servicenow-gcp-composer"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-gcp-composer") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-gcp-computeengine
resource "turbot_mod" "servicenow-gcp-computeengine" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-gcp]
  org        = "turbot"
  mod        = "servicenow-gcp-computeengine"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-gcp-computeengine") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-gcp-dataflow
resource "turbot_mod" "servicenow-gcp-dataflow" {
  parent  = "tmod:@turbot/turbot#/"
  org     = "turbot"
  mod     = "servicenow-gcp-dataflow"
  version = ">=5.0.0"
  count   = contains(var.mod_list, "servicenow-gcp-dataflow") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-gcp-datapipeline
resource "turbot_mod" "servicenow-gcp-datapipeline" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-gcp]
  org        = "turbot"
  mod        = "servicenow-gcp-datapipeline"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-gcp-datapipeline") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-gcp-dataplex
resource "turbot_mod" "servicenow-gcp-dataplex" {
  parent  = "tmod:@turbot/turbot#/"
  org     = "turbot"
  mod     = "servicenow-gcp-dataplex"
  version = ">=5.0.0"
  count   = contains(var.mod_list, "servicenow-gcp-dataplex") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-gcp-dataproc
resource "turbot_mod" "servicenow-gcp-dataproc" {
  parent  = "tmod:@turbot/turbot#/"
  org     = "turbot"
  mod     = "servicenow-gcp-dataproc"
  version = ">=5.0.0"
  count   = contains(var.mod_list, "servicenow-gcp-dataproc") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-gcp-dns
resource "turbot_mod" "servicenow-gcp-dns" {
  parent  = "tmod:@turbot/turbot#/"
  org     = "turbot"
  mod     = "servicenow-gcp-dns"
  version = ">=5.0.0"
  count   = contains(var.mod_list, "servicenow-gcp-dns") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-gcp-firebase
resource "turbot_mod" "servicenow-gcp-firebase" {
  parent  = "tmod:@turbot/turbot#/"
  org     = "turbot"
  mod     = "servicenow-gcp-firebase"
  version = ">=5.0.0"
  count   = contains(var.mod_list, "servicenow-gcp-firebase") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-gcp-functions
resource "turbot_mod" "servicenow-gcp-functions" {
  parent  = "tmod:@turbot/turbot#/"
  org     = "turbot"
  mod     = "servicenow-gcp-functions"
  version = ">=5.0.0"
  count   = contains(var.mod_list, "servicenow-gcp-functions") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-gcp-iam
resource "turbot_mod" "servicenow-gcp-iam" {
  parent  = "tmod:@turbot/turbot#/"
  org     = "turbot"
  mod     = "servicenow-gcp-iam"
  version = ">=5.0.0"
  count   = contains(var.mod_list, "servicenow-gcp-iam") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-gcp-kms
resource "turbot_mod" "servicenow-gcp-kms" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-gcp]
  org        = "turbot"
  mod        = "servicenow-gcp-kms"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-gcp-kms") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-gcp-kubernetesengine
resource "turbot_mod" "servicenow-gcp-kubernetesengine" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-gcp]
  org        = "turbot"
  mod        = "servicenow-gcp-kubernetesengine"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-gcp-kubernetesengine") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-gcp-logging
resource "turbot_mod" "servicenow-gcp-logging" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-gcp]
  org        = "turbot"
  mod        = "servicenow-gcp-logging"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-gcp-logging") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-gcp-memorystore
resource "turbot_mod" "servicenow-gcp-memorystore" {
  parent  = "tmod:@turbot/turbot#/"
  org     = "turbot"
  mod     = "servicenow-gcp-memorystore"
  version = ">=5.0.0"
  count   = contains(var.mod_list, "servicenow-gcp-memorystore") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-gcp-monitoring
resource "turbot_mod" "servicenow-gcp-monitoring" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-gcp]
  org        = "turbot"
  mod        = "servicenow-gcp-monitoring"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-gcp-monitoring") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-gcp-network
resource "turbot_mod" "servicenow-gcp-network" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-gcp]
  org        = "turbot"
  mod        = "servicenow-gcp-network"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-gcp-network") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-gcp-pubsub
resource "turbot_mod" "servicenow-gcp-pubsub" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-gcp]
  org        = "turbot"
  mod        = "servicenow-gcp-pubsub"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-gcp-pubsub") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-gcp-run
resource "turbot_mod" "servicenow-gcp-run" {
  parent  = "tmod:@turbot/turbot#/"
  org     = "turbot"
  mod     = "servicenow-gcp-run"
  version = ">=5.0.0"
  count   = contains(var.mod_list, "servicenow-gcp-run") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-gcp-scheduler
resource "turbot_mod" "servicenow-gcp-scheduler" {
  parent  = "tmod:@turbot/turbot#/"
  org     = "turbot"
  mod     = "servicenow-gcp-scheduler"
  version = ">=5.0.0"
  count   = contains(var.mod_list, "servicenow-gcp-scheduler") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-gcp-secretmanager
resource "turbot_mod" "servicenow-gcp-secretmanager" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-gcp]
  org        = "turbot"
  mod        = "servicenow-gcp-secretmanager"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-gcp-secretmanager") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-gcp-spanner
resource "turbot_mod" "servicenow-gcp-spanner" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-gcp]
  org        = "turbot"
  mod        = "servicenow-gcp-spanner"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-gcp-spanner") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-gcp-sql
resource "turbot_mod" "servicenow-gcp-sql" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-gcp]
  org        = "turbot"
  mod        = "servicenow-gcp-sql"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-gcp-sql") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-gcp-storage
resource "turbot_mod" "servicenow-gcp-storage" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-gcp]
  org        = "turbot"
  mod        = "servicenow-gcp-storage"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-gcp-storage") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-gcp-vertexai
resource "turbot_mod" "servicenow-gcp-vertexai" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.servicenow-gcp]
  org        = "turbot"
  mod        = "servicenow-gcp-vertexai"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "servicenow-gcp-vertexai") ? 1 : 0
}
