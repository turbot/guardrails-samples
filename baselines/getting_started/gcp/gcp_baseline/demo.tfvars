# List of services and providers to set as Enabled  
# Enabling all by default, can comment out the services and APIs to reduce scope
# Make sure you have the mods installed if enabling / registering.  The default mod install baseline assumes all

# For Service Status, change the options per service:
# "Enabled"
# "Disabled"

service_status = {
  gcp-appengine        = "Enabled"
  gcp-bigquery         = "Enabled"
  gcp-bigtable         = "Enabled"
  gcp-build            = "Enabled"
  gcp-composer         = "Enabled"
  gcp-computeengine    = "Enabled"
  gcp-datacatalog      = "Enabled"
  gcp-dataflow         = "Enabled"
  gcp-dataproc         = "Enabled"
  gcp-dns              = "Enabled"
  gcp-functions        = "Enabled"
  gcp-iam              = "Enabled"
  gcp-kms              = "Enabled"
  gcp-kubernetesengine = "Enabled"
  gcp-logging          = "Enabled" ### Enabled in Real-Time events if turned on
  gcp-memorystore      = "Enabled"
  gcp-monitoring       = "Enabled"
  gcp-network          = "Enabled"
  gcp-notebooks        = "Enabled"
  gcp-pubsub           = "Enabled" ### Enabled in Real-Time events if turned on
  gcp-scheduler        = "Enabled"
  gcp-spanner          = "Enabled"
  gcp-sql              = "Enabled"
  gcp-storage          = "Enabled"
  ##gcp-orgpolicy        = ""  ## Note: OrgPolicy does not have an Enabled
}
