target_resource          = "<resource id>"

#This is list of services that you would like to Enable or Disable, Service names must match the policy_map
service_status  = {
    gcp-computeengine    = "Enabled"
    gcp-pubsub           = "Enabled"
    gcp-iam              = "Enabled"
    gcp-network          = "Enabled"
    gcp-kubernetesengine = "Enabled"
    gcp-dns              = "Disabled"
  }

#This is a map of Turbot policy types to service names. It is advised not to modify the below list.
policy_map    = {
    gcp-appengine        = "appEngineEnabled"
    gcp-bigquery         = "bigQueryEnabled"
    gcp-bigtable         = "bigtableEnabled"
    gcp-computeengine    = "computeEngineEnabled"
    gcp-dataproc         = "dataprocEnabled"
    gcp-dns              = "dnsEnabled"
    gcp-functions        = "functionsEnabled"
    gcp-iam              = "iamEnabled"
    gcp-kms              = "kmsEnabled"
    gcp-kubernetesengine = "kubernetesEngineEnabled"
    gcp-logging          = "loggingEnabled"
    gcp-monitoring       = "monitoringEnabled"
    gcp-network          = "networkServiceEnabled"
    gcp-pubsub           = "pubsubEnabled"
    gcp-spanner          = "spannerEnabled"
    gcp-sql              = "sqlEnabled"
    gcp-storage          = "storageEnabled"
}

#This is a map of service API enabled policy types to service names. It is advised not to modify the below list.
api_policy_map    = {
    gcp-appengine        = "appEngineApiEnabled"
    gcp-bigquery         = "bigQueryApiEnabled"
    gcp-bigtable         = "bigtableApiEnabled"
    gcp-computeengine    = "computeEngineApiEnabled"
    gcp-dataproc         = "dataprocApiEnabled"
    gcp-dns              = "dnsApiEnabled"
    gcp-functions        = "functionsApiEnabled"
    gcp-iam              = "iamApiEnabled"
    gcp-kms              = "kmsApiEnabled"
    gcp-kubernetesengine = "kubernetesEngineApiEnabled"
    gcp-logging          = "loggingApiEnabled"
    gcp-monitoring       = "monitoringApiEnabled"
    gcp-network          = "networkServiceApiEnabled"
    gcp-pubsub           = "pubsubApiEnabled"
    gcp-spanner          = "spannerApiEnabled"
    gcp-sql              = "sqlApiEnabled"
    gcp-storage          = "storageApiEnabled"
  }
