
# This is list of services that you would like to Enable or Disable, Service names must match the policy_map
service_status = {
  gcp-computeengine = "Enabled"
  gcp-dns           = "Enabled"
  gcp-functions     = "Enabled"
  gcp-iam           = "Enabled"
  gcp-kms           = "Enabled"
  gcp-logging       = "Enabled"
  gcp-monitoring    = "Enabled"
  gcp-network       = "Enabled"
  gcp-pubsub        = "Enabled"
  gcp-sql           = "Enabled"
  gcp-storage       = "Enabled"
}

# This is a map of Turbot policy types to service names. It is advised not to modify the below list.
enabled_policy_map = {
  gcp-computeengine = "computeEngineEnabled"
  gcp-dns           = "dnsEnabled"
  gcp-functions     = "functionsEnabled"
  gcp-iam           = "iamEnabled"
  gcp-kms           = "kmsEnabled"
  gcp-logging       = "loggingEnabled"
  gcp-monitoring    = "monitoringEnabled"
  gcp-network       = "networkServiceEnabled"
  gcp-pubsub        = "pubsubEnabled"
  gcp-sql           = "sqlEnabled"
  gcp-storage       = "storageEnabled"
}

# This is a map of service API enabled policy types to service names. It is advised not to modify the below list.
api_policy_map = {
  gcp-computeengine = "computeEngineApiEnabled"
  gcp-dns           = "dnsApiEnabled"
  gcp-functions     = "functionsApiEnabled"
  gcp-iam           = "iamApiEnabled"
  gcp-kms           = "kmsApiEnabled"
  gcp-logging       = "loggingApiEnabled"
  gcp-monitoring    = "monitoringApiEnabled"
  gcp-network       = "networkServiceApiEnabled"
  gcp-pubsub        = "pubsubApiEnabled"
  gcp-sql           = "sqlApiEnabled"
  gcp-storage       = "storageApiEnabled"
}
