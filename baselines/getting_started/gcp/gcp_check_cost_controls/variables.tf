# Required

variable "turbot_profile" {
  description = "Enter profile matching your turbot cli credentials."
}

# Optional

variable "resource_active" {
  description = <<DESC
  Map of the list of approved regions controls.
  Possible values for the key of this map is found in locals.tf defined in the local variable policy_map.
  For example `aws-ec2 : "tmod:@turbot/aws-ec2#/policy/types/instanceActive"
  The value of the map is one of these possible values:
      "Skip"
      "Check: Active"
      "Enforce: Delete inactive with 1 day warning"
      "Enforce: Delete inactive with 3 days warning"
      "Enforce: Delete inactive with 7 days warning"
      "Enforce: Delete inactive with 14 days warning"
      "Enforce: Delete inactive with 30 days warning"
      "Enforce: Delete inactive with 60 days warning"
      "Enforce: Delete inactive with 90 days warning"
      "Enforce: Delete inactive with 180 days warning"
      "Enforce: Delete inactive with 365 days warning"
  Check demo.tfvars for an example of how to set this value.
  NOTE: Default behaviour is to approve all services which means expecting all mods to be installed
  DESC
  type        = map(string)
  default = {
    # gcp-bigquery-dataset                = "Check: Active"
    # gcp-bigquery-table                  = "Check: Active"
    # gcp-bigtable-cluster                = "Check: Active"
    # gcp-bigtable-instance               = "Check: Active"
    # gcp-bigtable-table                  = "Check: Active"
    # gcp-composer-environment            = "Check: Active"
    ##Have Unattached Policy Set instead## gcp-computeengine-disk              = "Check: Active"
    # gcp-computeengine-healthCheck       = "Check: Active"
    # gcp-computeengine-httpHealthCheck   = "Check: Active"
    # gcp-computeengine-httpsHealthCheck  = "Check: Active"
    gcp-computeengine-image    = "Check: Active"
    gcp-computeengine-instance = "Check: Active"
    # gcp-computeengine-instanceTemplate  = "Check: Active"
    # gcp-computeengine-nodeGroup         = "Check: Active"
    # gcp-computeengine-nodeTemplate      = "Check: Active"
    gcp-computeengine-regionDisk = "Check: Active"
    # gcp-computeengine-regionHealthCheck = "Check: Active"
    gcp-computeengine-snapshot = "Check: Active"
    # gcp-dataflow-job                    = "Check: Active"
    # gcp-dataproc-cluster                = "Check: Active"
    # gcp-dataproc-job                    = "Check: Active"
    # gcp-dataproc-workflowTemplate       = "Check: Active"
    # gcp-dns-managedZone                 = "Check: Active"
    gcp-functions-function = "Check: Active"
    # gcp-iam-projectUser                 = "Check: Active"
    # gcp-iam-projectUserAdminActivity    = "Check: Active"
    # gcp-iam-serviceAccount              = "Check: Active"
    # gcp-iam-serviceAccountKey           = "Check: Active"
    gcp-kubernetesengine-regionCluster = "Check: Active"
    # gcp-kubernetesengine-regionNodePool = "Check: Active"
    gcp-kubernetesengine-zoneCluster = "Check: Active"
    # gcp-kubernetesengine-zoneNodePool   = "Check: Active"
    # gcp-logging-exclusion               = "Check: Active"
    # gcp-logging-metric                  = "Check: Active"
    # gcp-logging-sink                    = "Check: Active"
    # gcp-monitoring-alertPolicy          = "Check: Active"
    # gcp-monitoring-group                = "Check: Active"
    # gcp-monitoring-notificationChannel  = "Check: Active"
    # gcp-network-address                 = "Check: Active"
    # gcp-network-backendBucket           = "Check: Active"
    # gcp-network-backendService          = "Check: Active"
    # gcp-network-firewall                = "Check: Active"
    # gcp-network-forwardingRule          = "Check: Active"
    # gcp-network-globalAddress           = "Check: Active"
    # gcp-network-globalForwardingRule    = "Check: Active"
    # gcp-network-interconnect            = "Check: Active"
    # gcp-network-network                 = "Check: Active"
    # gcp-network-packetMirroring         = "Check: Active"
    # gcp-network-regionBackendService    = "Check: Active"
    # gcp-network-regionSslCertificate    = "Check: Active"
    # gcp-network-regionTargetHttpsProxy  = "Check: Active"
    # gcp-network-regionUrlMap            = "Check: Active"
    # gcp-network-route                   = "Check: Active"
    # gcp-network-router                  = "Check: Active"
    # gcp-network-sslCertificate          = "Check: Active"
    # gcp-network-sslPolicy               = "Check: Active"
    # gcp-network-subnetwork              = "Check: Active"
    # gcp-network-targetHttpsProxy        = "Check: Active"
    # gcp-network-targetPool              = "Check: Active"
    # gcp-network-targetSslProxy          = "Check: Active"
    # gcp-network-targetTcpProxy          = "Check: Active"
    # gcp-network-targetVpnGateway        = "Check: Active"
    # gcp-network-urlMap                  = "Check: Active"
    # gcp-network-vpnTunnel               = "Check: Active"
    # gcp-pubsub-snapshot                 = "Check: Active"
    # gcp-pubsub-subscription             = "Check: Active"
    # gcp-pubsub-topic                    = "Check: Active"
    # gcp-scheduler-job                   = "Check: Active"
    # gcp-spanner-instance                = "Check: Active"
    gcp-sql-backup     = "Check: Active"
    gcp-sql-database   = "Check: Active"
    gcp-sql-instance   = "Check: Active"
    gcp-storage-bucket = "Check: Active"
    # gcp-storage-object                  = "Check: Active" # turned off by default to reduce noise
  }
}

variable "smart_folder_name" {
  description = "Smart folder name for the baseline"
  type        = string
  default     = "GCP Check Cost Control Policies"
}

variable "smart_folder_description" {
  description = "Enter a description for the smart folder"
  type        = string
  default     = "Defines sets of policies for the AWS cost control baseline"
}

variable "smart_folder_parent_resource" {
  description = "Enter the resource ID or AKA for the parent of the smart folder"
  type        = string
  default     = "tmod:@turbot/turbot#/"
}

variable "enable_compute_engine_active_policies" {
  type        = bool
  description = "Enable the Compute Engine policies for baseline"
  default     = true
}

variable "enable_network_approved_policies" {
  type        = bool
  description = "Enable the GCP Network address Network Tier policies for baseline"
  default     = true
}

variable "enable_compute_engine_schedule_policies" {
  type        = bool
  description = "Enable the compute engine schedule policies for compute instances"
  default     = true
}
