
locals {
  api_policy_map = {
    gcp-appengine        = "appEngineApiEnabled"
    gcp-bigquery         = "bigQueryApiEnabled"
    gcp-bigtable         = "bigtableApiEnabled"
    gcp-build            = "buildServiceApiEnabled"
    gcp-composer         = "composerApiEnabled"
    gcp-computeengine    = "computeEngineApiEnabled"
    gcp-datacatalog      = "dataCatalogApiEnabled"
    gcp-dataflow         = "dataflowApiEnabled"
    gcp-dataproc         = "dataprocApiEnabled"
    gcp-dns              = "dnsApiEnabled"
    gcp-functions        = "functionsApiEnabled"
    gcp-iam              = "iamApiEnabled"
    gcp-kms              = "kmsApiEnabled"
    gcp-kubernetesengine = "kubernetesEngineApiEnabled"
    gcp-logging          = "loggingApiEnabled"
    gcp-memorystore      = "memorystoreApiEnabled"
    gcp-monitoring       = "monitoringApiEnabled"
    gcp-network          = "networkServiceApiEnabled"
    gcp-notebooks        = "notebooksApiEnabled"
    ##gcp-orgpolicy        = ""  ## Note: OrgPolicy does not have an API Enabled
    gcp-pubsub    = "pubsubApiEnabled"
    gcp-scheduler = "schedulerApiEnabled"
    gcp-spanner   = "spannerApiEnabled"
    gcp-sql       = "sqlApiEnabled"
    gcp-storage   = "storageApiEnabled"
  }
}
