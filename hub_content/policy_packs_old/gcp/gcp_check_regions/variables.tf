# Baseline Configuration
variable "resource_approved_regions" {
  description = <<DESC

  Map of the list of approved regions controls.
  Possible values for the key of this map is found in locals.tf defined in the local variable policy_map.
  For example gcp-bigtable-cluster : "tmod:@turbot/azure-aks#/policy/types/managedClusterApproved"` has key `gcp-bigtable-cluster`.

  The value of the map is one of these possible values:
    - "Skip"
    - "Check: Approved"
    - "Enforce: Delete unapproved if new"

  Check demo.tfvars for an example of how to set this value.

  NOTE: Default behaviour is to approve all services which means expecting all mods to be installed

  DESC
  type        = map(string)
  default = {
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
}

# Optional Common Baseline Configuration

variable "turbot_profile" {
  description = "Enter profile matching your turbot cli credentials."
}

variable "smart_folder_name" {
  description = "Smart folder name for the baseline"
  type        = string
  default     = "GCP Check Regions Policies"
}

variable "smart_folder_description" {
  description = "Enter a description for the smart folder"
  type        = string
  default     = "Defines sets of policies for the GCP Check Regions baseline"
}

variable "smart_folder_parent_resource" {
  description = "Enter the resource ID or AKA for the parent of the smart folder"
  type        = string
  default     = "tmod:@turbot/turbot#/"
}
