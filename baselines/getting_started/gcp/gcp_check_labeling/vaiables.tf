variable "resource_tags" {
description = <<DESC
List of services and resources to be checked if its Tags are correct.
These tags must exist for Missing Tag use case if enabled
required_tags = [
  "Owner",
  "Contact",
  "Cost Center",
  "Project ID",
  "Department",
]
The value of the map is one of these possible values:
Acceptable Values:
  "Skip"
  "Check: Tags are correct"
  "Enforce: Set tags"
Check demo.tfvars for an example of how to set this value.
DESC
type          =map(string)
default = {
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
}

variable "turbot_profile" {
  description = "Enter profile matching your turbot cli credentials."
}

variable "smart_folder_name" {
  description = "Smart folder name for the baseline"
  type        = string
  default     = "GCP Labeling Policies"
}

variable "smart_folder_description" {
  description = "Enter a description for the smart folder"
  type        = string
  default     = "Defines sets of policies for the GCP Labeling baseline"
}

variable "smart_folder_parent_resource" {
  description = "Enter the resource ID or AKA for the parent of the smart folder"
  type        = string
  default     = "tmod:@turbot/turbot#/"
}  