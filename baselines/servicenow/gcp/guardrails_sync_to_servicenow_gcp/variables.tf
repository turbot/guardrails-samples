variable "servicenow_mod_list_gcp" {
  type = list(string)
  default = [
    #####################################
    #########  ServiceNow GCP  ##########
    #####################################
    "servicenow-gcp",
    "servicenow-gcp-appengine",
    "servicenow-gcp-bigquery",
    "servicenow-gcp-bigtable",
    "servicenow-gcp-composer",
    "servicenow-gcp-computeengine",
    "servicenow-gcp-dataflow",
    "servicenow-gcp-datapipeline",
    "servicenow-gcp-dataplex",
    "servicenow-gcp-dataproc",
    "servicenow-gcp-dns",
    "servicenow-gcp-firebase",
    "servicenow-gcp-functions",
    "servicenow-gcp-iam",
    "servicenow-gcp-kms",
    "servicenow-gcp-kubernetesengine",
    "servicenow-gcp-logging",
    "servicenow-gcp-memorystore",
    "servicenow-gcp-monitoring",
    "servicenow-gcp-network",
    "servicenow-gcp-pubsub",
    "servicenow-gcp-run",
    "servicenow-gcp-scheduler",
    "servicenow-gcp-secretmanager",
    "servicenow-gcp-spanner",
    "servicenow-gcp-sql",
    "servicenow-gcp-storage",
    "servicenow-gcp-vertexai"
  ]
}
