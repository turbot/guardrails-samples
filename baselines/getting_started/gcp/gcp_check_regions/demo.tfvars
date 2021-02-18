# List of services and resources to be Check: Approved.
# Started with a few resource types to get started aligned with the initial mods installed
# You can comment per row to exclude the resource type.  For any included, make sure you have that related service mod install
# See notes per row for nuance conditions for specific service policy settings

# Acceptable Values:
# "Skip"
# "Check: Approved"
# "Enforce: Delete unapproved if new"

resource_approved_regions = { 
  gcp-bigtable-cluster                  = "Check: Approved"
  gcp-composer-environment              = "Check: Approved"
  gcp-computeengine-disk                = "Check: Approved"
  gcp-computeengine-instance            = "Check: Approved"  # note: "Enforce: Stop unapproved", "Enforce: Stop unapproved if new", "Enforce: Delete unapproved if new"
  gcp-computeengine-node-group          = "Check: Approved"
  gcp-computeengine-node-template       = "Check: Approved"
  gcp-computeengine-region-disk         = "Check: Approved"
  gcp-computeengine-region-health-check = "Check: Approved"
  gcp-dataflow-job                      = "Check: Approved"  # note: does not have an enforce value
  gcp-dataproc-cluster                  = "Check: Approved"
  gcp-dataproc-job                      = "Check: Approved"
  gcp-dataproc-workflowtemplate         = "Check: Approved"
  gcp-functions-function                = "Check: Approved"
  gcp-kms-cryptokey                     = "Check: Approved"  # note: does not have an enforce value
  gcp-kubernetesengine-region-cluster   = "Check: Approved"
  gcp-kubernetesengine-region-node-pool = "Check: Approved"
  gcp-kubernetesengine-zone-cluster     = "Check: Approved"
  gcp-kubernetesengine-zone-node-pool   = "Check: Approved"
  gcp-network-address                   = "Check: Approved"
  gcp-network-forwarding-rule           = "Check: Approved"
  gcp-network-router                    = "Check: Approved"
  gcp-network-region-backend-service    = "Check: Approved"
  gcp-network-region-url-map            = "Check: Approved"
  gcp-network-subnetwork                = "Check: Approved"
  gcp-network-target-pool               = "Check: Approved"
  gcp-network-target-vpn-gateway        = "Check: Approved"
  gcp-network-vpn-tunnel                = "Check: Approved"
  gcp-scheduler-job                     = "Check: Approved"  # note: does not have an enforce value
  gcp-spanner-instance                  = "Check: Approved"
  gcp-sql-backup                        = "Check: Approved"
  gcp-sql-database                      = "Check: Approved"
  gcp-sql-instance                      = "Check: Approved"
  gcp-storage-bucket                    = "Check: Approved"
  # gcp-storage-object                   = "Check: Approved"  # turned off by default to reduce noise
}

# For reference, resources that do not reside in a specific region, therefore cannot limit which regions the resource resides in:
  # gcp-appengine
  # gcp-bigquery-dataset
  # gcp-bigquery-table
  # gcp-build
  # gcp-datacatalog
  # gcp-dns-managed-zone
  # gcp-iam-login-names
  # gcp-iam-member
  # gcp-iam-project-role
  # gcp-iam-project-user
  # gcp-iam-service-account
  # gcp-iam-service-account-key
  # gcp-logging-exclusion
  # gcp-logging-metric
  # gcp-logging-sink
  # gcp-memorystore
  # gcp-monitoring-alert-policy
  # gcp-monitoring-group
  # gcp-monitoring-notification-channel
  # gcp-notebooks
  # gcp-orgpolicy
  # gcp-pubsub-snapshot
  # gcp-pubsub-subscription 
  # gcp-pubsub-
  