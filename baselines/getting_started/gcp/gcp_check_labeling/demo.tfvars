# List of services and resources to be Check: Labels are correct.
# Started with a few resource types to get started aligned with the initial mods installed
# You can remove the comment per row to include the resource type.  Make sure you have that related service mod install

# Acceptable Values:
# "Skip"
# "Check: Labels are correct
# "Enforce: Set labels"

resource_tags = { 
    # gcp-project                        = "Check: Labels are correct"
    # gcp-bigquery-dataset               = "Check: Labels are correct"
    gcp-bigquery-table                 = "Check: Labels are correct"
    # gcp-bigtable-instance              = "Check: Labels are correct"
    # gcp-composer-environment           = "Check: Labels are correct"
    gcp-computeengine-disk             = "Check: Labels are correct"
    # gcp-computeengine-image            = "Check: Labels are correct"
    gcp-computeengine-instance         = "Check: Labels are correct"
    # gcp-computeengine-regionDisk       = "Check: Labels are correct"
    gcp-computeengine-snapshot         = "Check: Labels are correct"
    # gcp-dataproc-cluster               = "Check: Labels are correct"
    # gcp-dataproc-job                   = "Check: Labels are correct"
    # gcp-dataproc-workflowTemplate      = "Check: Labels are correct"
    # gcp-dns-managedZone                = "Check: Labels are correct"
    # gcp-kms-cryptoKey                  = "Check: Labels are correct"
    # gcp-kubernetesengine-regionCluster = "Check: Labels are correct"
    # gcp-kubernetesengine-zoneCluster   = "Check: Labels are correct"
    # gcp-network-forwardingRule         = "Check: Labels are correct"
    # gcp-network-globalForwardingRule   = "Check: Labels are correct"
    # gcp-network-vpnTunnel              = "Check: Labels are correct"
    # gcp-pubsub-snapshot                = "Check: Labels are correct"
    # gcp-pubsub-subscription            = "Check: Labels are correct"
    # gcp-spanner-instance               = "Check: Labels are correct"
    gcp-sql-instance                   = "Check: Labels are correct"
    gcp-storage-bucket                 = "Check: Labels are correct"
}