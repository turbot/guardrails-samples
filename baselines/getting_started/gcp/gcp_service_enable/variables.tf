variable "service_status" {
  description = "Enter the list of services that you would like to Enable or Disable, Service names must match the policy_map:"
  type        = map(any)
  default = {
    gcp-appengine            = "Enabled"
    gcp-bigquery             = "Enabled"
    gcp-bigquerydatatransfer = "Enabled"
    gcp-bigtable             = "Enabled"
    gcp-build                = "Enabled"
    gcp-run                  = "Enabled"
    gcp-composer             = "Enabled"
    gcp-computeengine        = "Enabled"
    gcp-datacatalog          = "Enabled"
    gcp-datapipeline         = "Enabled"
    gcp-dataflow             = "Enabled"
    gcp-dataproc             = "Enabled"
    gcp-dns                  = "Enabled"
    gcp-firebase             = "Enabled"
    gcp-functions            = "Enabled"
    gcp-iam                  = "Enabled"
    gcp-kms                  = "Enabled"
    gcp-kubernetesengine     = "Enabled"
    gcp-logging              = "Enabled"
    gcp-memorystore          = "Enabled"
    gcp-monitoring           = "Enabled"
    gcp-network              = "Enabled"
    gcp-notebooks            = "Enabled"
    gcp-pubsub               = "Enabled"
    gcp-scheduler            = "Enabled"
    gcp-secretmanager        = "Enabled"
    gcp-spanner              = "Enabled"
    gcp-sql                  = "Enabled"
    gcp-storage              = "Enabled"
  }
}

variable "enabled_policy_map" {
  description = "This is a map of Turbot policy types to service names. You probably should not modify this."
  type        = map(any)
  default = {
    gcp-appengine            = "appEngineEnabled"
    gcp-bigquery             = "bigQueryEnabled"
    gcp-bigquerydatatransfer = "bigQueryDataTransferEnabled"
    gcp-bigtable             = "bigtableEnabled"
    gcp-build                = "buildServiceEnabled"
    gcp-run                  = "runEnabled"
    gcp-composer             = "composerEnabled"
    gcp-computeengine        = "computeEngineEnabled"
    gcp-datacatalog          = "dataCatalogEnabled"
    gcp-datapipeline         = "datapipelineEnabled"
    gcp-dataflow             = "dataflowEnabled"
    gcp-dataproc             = "dataprocEnabled"
    gcp-dns                  = "dnsEnabled"
    gcp-firebase             = "firebaseEnabled"
    gcp-functions            = "functionsEnabled"
    gcp-iam                  = "iamEnabled"
    gcp-kms                  = "kmsEnabled"
    gcp-kubernetesengine     = "kubernetesEngineEnabled"
    gcp-logging              = "loggingEnabled"
    gcp-memorystore          = "memorystoreEnabled"
    gcp-monitoring           = "monitoringEnabled"
    gcp-network              = "networkServiceEnabled"
    gcp-notebooks            = "notebooksEnabled"
    gcp-pubsub               = "pubsubEnabled"
    gcp-scheduler            = "schedulerEnabled"
    gcp-secretmanager        = "secretManagerEnabled"
    gcp-spanner              = "spannerEnabled"
    gcp-sql                  = "sqlEnabled"
    gcp-storage              = "storageEnabled"
    ##gcp-orgpolicy        = ""  ## Note: OrgPolicy does not have an Enabled
  }
}

variable "api_policy_map" {
  description = "This is a map of service API enabled policy types to service names. It is advised not to modify the below list."
  type        = map(any)
  default = {
    gcp-appengine            = "appEngineApiEnabled"
    gcp-bigquery             = "bigQueryApiEnabled"
    gcp-bigquerydatatransfer = "bigQueryDataTransferApiEnabled"
    gcp-bigtable             = "bigtableApiEnabled"
    gcp-build                = "buildServiceApiEnabled"
    gcp-run                  = "runApiEnabled"
    gcp-composer             = "composerApiEnabled"
    gcp-computeengine        = "computeEngineApiEnabled"
    gcp-datacatalog          = "dataCatalogApiEnabled"
    gcp-datapipeline         = "datapipelineApiEnabled"
    gcp-dataflow             = "dataflowApiEnabled"
    gcp-dataproc             = "dataprocApiEnabled"
    gcp-dns                  = "dnsApiEnabled"
    gcp-firebase             = "firebaseApiEnabled"
    gcp-functions            = "functionsApiEnabled"
    gcp-iam                  = "iamApiEnabled"
    gcp-kms                  = "kmsApiEnabled"
    gcp-kubernetesengine     = "kubernetesEngineApiEnabled"
    gcp-logging              = "loggingApiEnabled"
    gcp-memorystore          = "memorystoreApiEnabled"
    gcp-monitoring           = "monitoringApiEnabled"
    gcp-network              = "networkServiceApiEnabled"
    gcp-notebooks            = "notebooksApiEnabled"
    gcp-pubsub               = "pubsubApiEnabled"
    gcp-scheduler            = "schedulerApiEnabled"
    gcp-secretmanager        = "secretManagerApiEnabled"
    gcp-spanner              = "spannerApiEnabled"
    gcp-sql                  = "sqlApiEnabled"
    gcp-storage              = "storageApiEnabled"
    ##gcp-orgpolicy        = ""  ## Note: OrgPolicy does not have an API Enabled
  }
}





