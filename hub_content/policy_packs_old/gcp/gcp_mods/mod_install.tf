# https://turbot.com/v5/mods/turbot/gcp
resource "turbot_mod" "gcp" {
  parent  = "tmod:@turbot/turbot#/"
  org     = "turbot"
  mod     = "gcp"
  version = ">=5.0.0-beta.1"
  count   = contains(var.mod_list, "gcp") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/gcp-iam
resource "turbot_mod" "gcp-iam" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.gcp"]
  org        = "turbot"
  mod        = "gcp-iam"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "gcp-iam") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/gcp-appengine
resource "turbot_mod" "gcp-appengine" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.gcp", "turbot_mod.gcp-iam"]
  org        = "turbot"
  mod        = "gcp-appengine"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "gcp-appengine") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/gcp-bigquery
resource "turbot_mod" "gcp-bigquery" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.gcp", "turbot_mod.gcp-iam"]
  org        = "turbot"
  mod        = "gcp-bigquery"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "gcp-bigquery") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/gcp-bigtable
resource "turbot_mod" "gcp-bigtable" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.gcp", "turbot_mod.gcp-iam"]
  org        = "turbot"
  mod        = "gcp-bigtable"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "gcp-bigtable") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/gcp-build
resource "turbot_mod" "gcp-build" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.gcp", "turbot_mod.gcp-iam"]
  org        = "turbot"
  mod        = "gcp-build"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "gcp-build") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/gcp-composer
resource "turbot_mod" "gcp-composer" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.gcp", "turbot_mod.gcp-iam"]
  org        = "turbot"
  mod        = "gcp-composer"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "gcp-composer") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/gcp-computeengine
resource "turbot_mod" "gcp-computeengine" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.gcp", "turbot_mod.gcp-iam"]
  org        = "turbot"
  mod        = "gcp-computeengine"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "gcp-computeengine") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/gcp-datacatalog
resource "turbot_mod" "gcp-datacatalog" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.gcp", "turbot_mod.gcp-iam"]
  org        = "turbot"
  mod        = "gcp-datacatalog"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "gcp-datacatalog") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/gcp-dataflow
resource "turbot_mod" "gcp-dataflow" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.gcp", "turbot_mod.gcp-iam"]
  org        = "turbot"
  mod        = "gcp-dataflow"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "gcp-dataflow") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/gcp-dataproc
resource "turbot_mod" "gcp-dataproc" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.gcp", "turbot_mod.gcp-iam"]
  org        = "turbot"
  mod        = "gcp-dataproc"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "gcp-dataproc") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/gcp-dns
resource "turbot_mod" "gcp-dns" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.gcp", "turbot_mod.gcp-iam"]
  org        = "turbot"
  mod        = "gcp-dns"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "gcp-dns") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/gcp-functions
resource "turbot_mod" "gcp-functions" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.gcp", "turbot_mod.gcp-iam"]
  org        = "turbot"
  mod        = "gcp-functions"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "gcp-functions") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/gcp-kms
resource "turbot_mod" "gcp-kms" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.gcp", "turbot_mod.gcp-iam"]
  org        = "turbot"
  mod        = "gcp-kms"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "gcp-kms") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/gcp-kubernetesengine
resource "turbot_mod" "gcp-kubernetesengine" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.gcp", "turbot_mod.gcp-iam"]
  org        = "turbot"
  mod        = "gcp-kubernetesengine"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "gcp-kubernetesengine") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/gcp-logging
resource "turbot_mod" "gcp-logging" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.gcp", "turbot_mod.gcp-iam"]
  org        = "turbot"
  mod        = "gcp-logging"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "gcp-logging") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/gcp-memorystore
resource "turbot_mod" "gcp-memorystore" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.gcp", "turbot_mod.gcp-iam"]
  org        = "turbot"
  mod        = "gcp-memorystore"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "gcp-memorystore") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/gcp-monitoring
resource "turbot_mod" "gcp-monitoring" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.gcp", "turbot_mod.gcp-iam"]
  org        = "turbot"
  mod        = "gcp-monitoring"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "gcp-monitoring") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/gcp-network
resource "turbot_mod" "gcp-network" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.gcp", "turbot_mod.gcp-iam"]
  org        = "turbot"
  mod        = "gcp-network"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "gcp-network") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/gcp-notebooks
resource "turbot_mod" "gcp-notebooks" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.gcp"]
  org        = "turbot"
  mod        = "gcp-notebooks"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "gcp-notebooks") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/gcp-orgpolicy
resource "turbot_mod" "gcp-orgpolicy" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.gcp", "turbot_mod.gcp-iam"]
  org        = "turbot"
  mod        = "gcp-orgpolicy"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "gcp-orgpolicy") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/gcp-pubsub
resource "turbot_mod" "gcp-pubsub" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.gcp", "turbot_mod.gcp-iam"]
  org        = "turbot"
  mod        = "gcp-pubsub"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "gcp-pubsub") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/gcp-scheduler
resource "turbot_mod" "gcp-scheduler" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.gcp", "turbot_mod.gcp-iam"]
  org        = "turbot"
  mod        = "gcp-scheduler"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "gcp-scheduler") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/gcp-spanner
resource "turbot_mod" "gcp-spanner" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.gcp", "turbot_mod.gcp-iam"]
  org        = "turbot"
  mod        = "gcp-spanner"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "gcp-spanner") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/gcp-sql
resource "turbot_mod" "gcp-sql" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.gcp", "turbot_mod.gcp-iam"]
  org        = "turbot"
  mod        = "gcp-sql"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "gcp-sql") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/gcp-storage
resource "turbot_mod" "gcp-storage" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.gcp", "turbot_mod.gcp-iam"]
  org        = "turbot"
  mod        = "gcp-storage"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "gcp-storage") ? 1 : 0
}

# https://turbot.com/v5/mods/turbot/gcp-cisv1
resource "turbot_mod" "gcp-cisv1" {
  parent     = "tmod:@turbot/turbot#/"
  depends_on = ["turbot_mod.gcp", "turbot_mod.gcp-iam", "turbot_mod.cis", "turbot_mod.gcp-computeengine", "turbot_mod.gcp-dns", "turbot_mod.gcp-kms", "turbot_mod.gcp-logging", "turbot_mod.gcp-network", "turbot_mod.gcp-sql", "turbot_mod.gcp-storage"]
  org        = "turbot"
  mod        = "gcp-cisv1"
  version    = ">=5.0.0-beta.1"
  count      = contains(var.mod_list, "gcp-cisv1") ? 1 : 0
}
