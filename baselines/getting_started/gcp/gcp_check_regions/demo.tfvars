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

## Mapping of resource name to resource tag policy
# Note: the resource map above dictates the applicable use of each line item below.  You do not need to comment out these items to reduce scope
policy_map  = {
  gcp-bigtable-cluster                  = "tmod:@turbot/gcp-bigtable#/policy/types/clusterApproved"
  gcp-composer-environment              = "tmod:@turbot/gcp-composer#/policy/types/environmentApproved"
  gcp-computeengine-disk                = "tmod:@turbot/gcp-computeengine#/policy/types/diskApproved"
  gcp-computeengine-instance            = "tmod:@turbot/gcp-computeengine#/policy/types/instanceApproved"
  gcp-computeengine-node-group          = "tmod:@turbot/gcp-computeengine#/policy/types/nodeGroupApproved"
  gcp-computeengine-node-template       = "tmod:@turbot/gcp-computeengine#/policy/types/nodeTemplateApproved"
  gcp-computeengine-region-disk         = "tmod:@turbot/gcp-computeengine#/policy/types/regionDiskApproved"
  gcp-computeengine-region-health-check = "tmod:@turbot/gcp-computeengine#/policy/types/regionHealthCheckApproved"
  gcp-dataflow-job                      = "tmod:@turbot/gcp-dataflow#/policy/types/jobApproved"
  gcp-dataproc-cluster                  = "tmod:@turbot/gcp-dataproc#/policy/types/clusterApproved"
  gcp-dataproc-job                      = "tmod:@turbot/gcp-dataproc#/policy/types/jobApproved"
  gcp-dataproc-workflowtemplate         = "tmod:@turbot/gcp-dataproc#/policy/types/workflowTemplateApproved"
  gcp-functions-function                = "tmod:@turbot/gcp-functions#/policy/types/functionApproved"
  gcp-kms-cryptokey                     = "tmod:@turbot/gcp-kms#/policy/types/cryptoKeyApproved"
  gcp-kubernetesengine-region-cluster   = "tmod:@turbot/gcp-kubernetesengine#/policy/types/regionClusterApproved"
  gcp-kubernetesengine-region-node-pool = "tmod:@turbot/gcp-kubernetesengine#/policy/types/regionNodePoolApproved"
  gcp-kubernetesengine-zone-cluster     = "tmod:@turbot/gcp-kubernetesengine#/policy/types/zoneClusterApproved"
  gcp-kubernetesengine-zone-node-pool   = "tmod:@turbot/gcp-kubernetesengine#/policy/types/zoneNodePoolApproved"
  gcp-network-address                   = "tmod:@turbot/gcp-network#/policy/types/addressApproved"
  gcp-network-forwarding-rule           = "tmod:@turbot/gcp-network#/policy/types/forwardingRuleApproved"
  gcp-network-region-backend-service    = "tmod:@turbot/gcp-network#/policy/types/regionBackendServiceApproved"
  gcp-network-region-url-map            = "tmod:@turbot/gcp-network#/policy/types/regionUrlMapApproved"
  gcp-network-router                    = "tmod:@turbot/gcp-network#/policy/types/routerApproved"
  gcp-network-subnetwork                = "tmod:@turbot/gcp-network#/policy/types/subnetworkApproved"
  gcp-network-target-pool               = "tmod:@turbot/gcp-network#/policy/types/targetPoolApproved"
  gcp-network-target-vpn-gateway        = "tmod:@turbot/gcp-network#/policy/types/targetVpnGatewayApproved"
  gcp-network-vpn-tunnel                = "tmod:@turbot/gcp-network#/policy/types/vpnTunnelApproved"
  gcp-scheduler-job                     = "tmod:@turbot/gcp-scheduler#/policy/types/jobApproved"
  gcp-spanner-instance                  = "tmod:@turbot/gcp-spanner#/policy/types/instanceApproved"
  gcp-sql-backup                        = "tmod:@turbot/gcp-sql#/policy/types/backupApproved"
  gcp-sql-database                      = "tmod:@turbot/gcp-sql#/policy/types/databaseApproved"
  gcp-sql-instance                      = "tmod:@turbot/gcp-sql#/policy/types/instanceApproved"
  gcp-storage-bucket                    = "tmod:@turbot/gcp-storage#/policy/types/bucketApproved"
  gcp-storage-object                    = "tmod:@turbot/gcp-storage#/policy/types/objectApproved"
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
  # gcp-pubsub-topic