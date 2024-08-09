# https://hub.guardrails.turbot.com/mods/gcp/mods/gcp
resource "turbot_mod" "gcp" {
  parent  = "tmod:@turbot/turbot#/"
  org     = "turbot"
  mod     = "gcp"
  version = ">=5.0.0"
  count   = contains(var.mod_list, "gcp") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/gcp/mods/gcp-appengine
resource "turbot_mod" "gcp-appengine" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.gcp, turbot_mod.gcp-iam]
  org        = "turbot"
  mod        = "gcp-appengine"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "gcp-appengine") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/gcp/mods/gcp-bigquery
resource "turbot_mod" "gcp-bigquery" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.gcp, turbot_mod.gcp-iam]
  org        = "turbot"
  mod        = "gcp-bigquery"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "gcp-bigquery") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/gcp/mods/gcp-bigquerydatatransfer
resource "turbot_mod" "gcp-bigquerydatatransfer" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.gcp, turbot_mod.gcp-iam]
  org        = "turbot"
  mod        = "gcp-bigquerydatatransfer"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "gcp-bigquerydatatransfer") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/gcp/mods/gcp-bigtable
resource "turbot_mod" "gcp-bigtable" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.gcp, turbot_mod.gcp-iam]
  org        = "turbot"
  mod        = "gcp-bigtable"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "gcp-bigtable") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/gcp/mods/gcp-build
resource "turbot_mod" "gcp-build" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.gcp, turbot_mod.gcp-iam]
  org        = "turbot"
  mod        = "gcp-build"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "gcp-build") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/gcp/mods/gcp-cisv1
resource "turbot_mod" "gcp-cisv1" {
  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.gcp,
    turbot_mod.gcp-iam,
    turbot_mod.gcp-computeengine,
    turbot_mod.gcp-dns,
    turbot_mod.gcp-kms,
    turbot_mod.gcp-logging,
    turbot_mod.gcp-network,
    turbot_mod.gcp-sql,
    turbot_mod.gcp-storage
  ]
  org     = "turbot"
  mod     = "gcp-cisv1"
  version = ">=5.0.0"
  count   = contains(var.mod_list, "gcp-cisv1") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/gcp/mods/gcp-cisv2-0
resource "turbot_mod" "gcp-cisv2-0" {
  parent = "tmod:@turbot/turbot#/"
  depends_on = [
    turbot_mod.gcp,
    turbot_mod.gcp-appengine,
    turbot_mod.gcp-bigquery,
    turbot_mod.gcp-computeengine,
    turbot_mod.gcp-dataproc,
    turbot_mod.gcp-dns,
    turbot_mod.gcp-functions,
    turbot_mod.gcp-iam,
    turbot_mod.gcp-kms,
    turbot_mod.gcp-logging,
    turbot_mod.gcp-monitoring,
    turbot_mod.gcp-network,
    turbot_mod.gcp-sql,
    turbot_mod.gcp-storage
  ]
  org     = "turbot"
  mod     = "gcp-cisv2-0"
  version = ">=5.0.0"
  count   = contains(var.mod_list, "gcp-cisv2-0") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/gcp/mods/gcp-composer
resource "turbot_mod" "gcp-composer" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.gcp, turbot_mod.gcp-iam]
  org        = "turbot"
  mod        = "gcp-composer"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "gcp-composer") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/gcp/mods/gcp-computeengine
resource "turbot_mod" "gcp-computeengine" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.gcp, turbot_mod.gcp-iam]
  org        = "turbot"
  mod        = "gcp-computeengine"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "gcp-computeengine") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/gcp/mods/gcp-datacatalog
resource "turbot_mod" "gcp-datacatalog" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.gcp, turbot_mod.gcp-iam]
  org        = "turbot"
  mod        = "gcp-datacatalog"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "gcp-datacatalog") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/gcp/mods/gcp-dataflow
resource "turbot_mod" "gcp-dataflow" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.gcp, turbot_mod.gcp-iam]
  org        = "turbot"
  mod        = "gcp-dataflow"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "gcp-dataflow") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/gcp/mods/gcp-datapipeline
resource "turbot_mod" "gcp-datapipeline" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.gcp, turbot_mod.gcp-iam]
  org        = "turbot"
  mod        = "gcp-datapipeline"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "gcp-datapipeline") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/gcp/mods/gcp-dataproc
resource "turbot_mod" "gcp-dataproc" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.gcp, turbot_mod.gcp-iam]
  org        = "turbot"
  mod        = "gcp-dataproc"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "gcp-dataproc") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/gcp/mods/gcp-dns
resource "turbot_mod" "gcp-dns" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.gcp, turbot_mod.gcp-iam]
  org        = "turbot"
  mod        = "gcp-dns"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "gcp-dns") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/gcp/mods/gcp-firebase
resource "turbot_mod" "gcp-firebase" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.gcp, turbot_mod.gcp-iam]
  org        = "turbot"
  mod        = "gcp-firebase"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "gcp-firebase") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/gcp/mods/gcp-functions
resource "turbot_mod" "gcp-functions" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.gcp, turbot_mod.gcp-iam]
  org        = "turbot"
  mod        = "gcp-functions"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "gcp-functions") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/gcp/mods/gcp-iam
resource "turbot_mod" "gcp-iam" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.gcp]
  org        = "turbot"
  mod        = "gcp-iam"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "gcp-iam") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/gcp/mods/gcp-kms
resource "turbot_mod" "gcp-kms" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.gcp, turbot_mod.gcp-iam]
  org        = "turbot"
  mod        = "gcp-kms"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "gcp-kms") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/gcp/mods/gcp-kubernetesengine
resource "turbot_mod" "gcp-kubernetesengine" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.gcp, turbot_mod.gcp-iam]
  org        = "turbot"
  mod        = "gcp-kubernetesengine"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "gcp-kubernetesengine") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/gcp/mods/gcp-logging
resource "turbot_mod" "gcp-logging" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.gcp, turbot_mod.gcp-iam]
  org        = "turbot"
  mod        = "gcp-logging"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "gcp-logging") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/gcp/mods/gcp-memorystore
resource "turbot_mod" "gcp-memorystore" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.gcp, turbot_mod.gcp-iam]
  org        = "turbot"
  mod        = "gcp-memorystore"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "gcp-memorystore") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/gcp/mods/gcp-monitoring
resource "turbot_mod" "gcp-monitoring" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.gcp, turbot_mod.gcp-iam]
  org        = "turbot"
  mod        = "gcp-monitoring"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "gcp-monitoring") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/gcp/mods/gcp-network
resource "turbot_mod" "gcp-network" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.gcp, turbot_mod.gcp-iam]
  org        = "turbot"
  mod        = "gcp-network"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "gcp-network") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/gcp/mods/gcp-notebooks
resource "turbot_mod" "gcp-notebooks" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.gcp, turbot_mod.gcp-iam]
  org        = "turbot"
  mod        = "gcp-notebooks"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "gcp-notebooks") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/gcp/mods/gcp-oauth
resource "turbot_mod" "gcp-oauth" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.gcp, turbot_mod.gcp-iam]
  org        = "turbot"
  mod        = "gcp-oauth"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "gcp-oauth") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/gcp/mods/gcp-orgpolicy
resource "turbot_mod" "gcp-orgpolicy" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.gcp]
  org        = "turbot"
  mod        = "gcp-orgpolicy"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "gcp-orgpolicy") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/gcp/mods/gcp-pubsub
resource "turbot_mod" "gcp-pubsub" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.gcp, turbot_mod.gcp-iam]
  org        = "turbot"
  mod        = "gcp-pubsub"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "gcp-pubsub") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/gcp/mods/gcp-run
resource "turbot_mod" "gcp-run" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.gcp, turbot_mod.gcp-iam]
  org        = "turbot"
  mod        = "gcp-run"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "gcp-run") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/gcp/mods/gcp-scheduler
resource "turbot_mod" "gcp-scheduler" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.gcp, turbot_mod.gcp-iam]
  org        = "turbot"
  mod        = "gcp-scheduler"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "gcp-scheduler") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/gcp/mods/gcp-secretmanager
resource "turbot_mod" "gcp-secretmanager" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.gcp, turbot_mod.gcp-iam]
  org        = "turbot"
  mod        = "gcp-secretmanager"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "gcp-secretmanager") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/gcp/mods/gcp-spanner
resource "turbot_mod" "gcp-spanner" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.gcp, turbot_mod.gcp-iam]
  org        = "turbot"
  mod        = "gcp-spanner"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "gcp-spanner") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/gcp/mods/gcp-sql
resource "turbot_mod" "gcp-sql" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.gcp, turbot_mod.gcp-iam]
  org        = "turbot"
  mod        = "gcp-sql"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "gcp-sql") ? 1 : 0
}

# https://hub.guardrails.turbot.com/mods/gcp/mods/gcp-storage
resource "turbot_mod" "gcp-storage" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = [turbot_mod.gcp, turbot_mod.gcp-iam]
  org        = "turbot"
  mod        = "gcp-storage"
  version    = ">=5.0.0"
  count      = contains(var.mod_list, "gcp-storage") ? 1 : 0
}
