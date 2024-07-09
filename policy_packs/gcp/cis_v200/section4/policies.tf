# GCP > Compute Engine > Instance > Block Project Wide SSH Keys
resource "turbot_policy_setting" "gcp_computeengine_instance_block_project_wide_ssh_keys" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/instanceBlockProjectWideSshKeys"
  note     = "GCP CIS v2.0.0 - Control: 4.3"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}

# GCP > Compute Engine > Project > OS Login Enabled
resource "turbot_policy_setting" "gcp_computeengine_project_os_login_enabled" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/osLoginEnabled"
  note     = "GCP CIS v2.0.0 - Control: 4.4"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}

# GCP > Compute Engine > Instance > Serial Port Access
resource "turbot_policy_setting" "gcp_computeengine_instance_serial_port_access" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/instanceSerialPortAccess"
  note     = "GCP CIS v2.0.0 - Control: 4.5"
  value    = "Check: Disabled"
  # value    = "Enforce: Disabled"
}

# GCP > Compute Engine > Instance > Approved
resource "turbot_policy_setting" "gcp_computeengine_instance_approved" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/instanceApproved"
  note     = "GCP CIS v2.0.0 - Control: 4.1, 4.2, 4.6, 4.11"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
  # value    = "Enforce: Stop unapproved if new"
  # value    = "Enforce: Stop unapproved"
}

# GCP > Compute Engine > Instance > Approved > IP Forwarding
resource "turbot_policy_setting" "gcp_computeengine_instance_approved_ip_forwarding" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/instanceApprovedIpForwarding"
  note     = "GCP CIS v2.0.0 - Control: 4.6"
  value    = "Approved if disabled"
}

# GCP > Compute Engine > Disk > Approved
resource "turbot_policy_setting" "gcp_computeengine_disk_approved" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/diskApproved"
  note     = "GCP CIS v2.0.0 - Control: 4.7"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
}

# GCP > Compute Engine > Disk > Approved > Encryption at Rest
resource "turbot_policy_setting" "gcp_computeengine_disk_approved_encryption_at_rest" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/diskApprovedEncryptionAtRest"
  note     = "GCP CIS v2.0.0 - Control: 4.7"
  value    = "Customer supplied key"
}

# GCP > Compute Engine > Instance > Shielded VM
resource "turbot_policy_setting" "gcp_computeengine_instance_shielded_vm_enabled" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/shieldedVMEnabled"
  note     = "GCP CIS v2.0.0 - Control: 4.8"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}

# GCP > Compute Engine > Instance > External IP Addresses
resource "turbot_policy_setting" "gcp_computeengine_instance_external_ip_addresses" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/instanceExternalIpAddresses"
  note     = "GCP CIS v2.0.0 - Control: 4.9"
  value    = "Check: None"
  # value    = "Enforce: None"
}

# GCP > Compute Engine > Instance > Approved > Custom
resource "turbot_policy_setting" "gcp_computeengine_instance_approved_custom" {
  resource       = turbot_smart_folder.main.id
  type           = "tmod:@turbot/gcp-computeengine#/policy/types/instanceApprovedCustom"
  note           = "GCP CIS v2.0.0 - Control: 4.1, 4.2, 4.11"
  template_input = <<-EOT
    {
      item: instance {
        enableConfidentialCompute: get(path: "confidentialInstanceConfig.enableConfidentialCompute")
        labels: get(path: "labels")
        machineType: get(path: "machineType")
        instanceName: get(path: "name")
        serviceAccounts: get(path: "serviceAccounts")
      }

      project: project {
        projectNumber: get(path: "projectNumber")
      }
    }
  EOT
  template       = <<-EOT
    {%- set results = [] -%}
    {%- set projectNumber = $.project.projectNumber -%}
    {%- set enableConfidentialCompute = $.item.enableConfidentialCompute -%}
    {%- set machineType = $.item.machineType -%}
    {%- set type = machineType.split("/").pop() -%}

    {%- if enableConfidentialCompute and machineType and type.startsWith("n2d-") -%}
      {%- set data = {
          "title": "Confidential Computing Enabled",
          "result": "Approved",
          "message": "Instance has Confidential Computing enabled"
      } -%}
    {%- elif not enableConfidentialCompute -%}
      {%- set data = {
          "title": "Confidential Computing Enabled",
          "result": "Not approved",
          "message": "Instance has Confidential Computing disabled"
      } -%}
    {%- else -%}
      {%- set data = {
          "title": "Confidential Computing Enabled",
          "result": "Skip",
          "message": "No data available for Confidential Computing yet"
      } -%}
    {%- endif -%}

    {%- set results = results.concat(data) -%}

    {%- set instanceName = $.item.instanceName -%}
    {%- set labels = $.item.labels -%}
    {%- set serviceAccounts = $.item.serviceAccounts | default([]) -%}
    {%- set defaultServiceAccount = projectNumber + "-compute@developer.gserviceaccount.com" -%}
    {%- set hasDefaultSA = false -%}
    {%- set hasFullAccess = false -%}
    {%- set instanceWithDefaultSA = {} -%}
    {%- set instanceWithFullAccess = {} -%}
    {%- set flag = true -%}

    {%- for item in serviceAccounts -%}
      {%- if flag -%}
        {%- set hasDefaultSA = item.email == defaultServiceAccount -%}

        {%- if hasDefaultSA -%}
          {%- set instanceWithDefaultSA = item -%}
          {%- set flag = false -%}
        {%- endif -%}
      {%- endif -%}
    {%- endfor -%}

    {%- set flag = true -%}

    {%- if instanceName.startsWith("gke-") and labels["goog-gke-node"] is not null -%}
      {%- set data = {
          "title": "Default Service Account",
          "result": "Skip",
          "message": "Instance is GKE managed"
      } -%}
    {%- elif instanceWithDefaultSA | length == 0 -%}
      {%- set data = {
          "title": "Default Service Account",
          "result": "Approved",
          "message": "Instance is not configured to use Default Service Account"
      } -%}
    {%- elif instanceWithDefaultSA | length > 0 -%}
      {%- set data = {
          "title": "Default Service Account",
          "result": "Not approved",
          "message": "Instance is configured to use Default Service Account"
      } -%}
    {%- else -%}
      {%- set data = {
          "title": "Default Service Account",
          "result": "Skip",
          "message": "No data available for Service Account yet"
      } -%}
    {%- endif -%}

    {%- set results = results.concat(data) -%}

    {%- for item in serviceAccounts -%}
      {%- if flag -%}
        {%- set hasDefaultSA = item.email == defaultServiceAccount -%}
        {%- set hasFullAccess = item.scopes.indexOf("https://www.googleapis.com/auth/cloud-platform") != -1 -%}

        {%- if hasDefaultSA and hasFullAccess -%}
          {%- set instanceWithFullAccess = item -%}
          {%- set flag = false -%}
        {%- endif -%}
      {%- endif -%}
    {%- endfor -%}

    {%- if instanceName.startsWith("gke-") and labels["goog-gke-node"] is not null -%}
      {%- set data = {
          "title": "Default Service Account with full API access",
          "result": "Skip",
          "message": "Instance is GKE managed"
      } -%}
    {%- elif instanceWithFullAccess | length == 0 -%}
      {%- set data = {
          "title": "Default Service Account with full API access",
          "result": "Approved",
          "message": "Instance is not configured to use Default Service Account with Full Access to all cloud APIs"
      } -%}
    {%- elif instanceWithFullAccess | length > 0 -%}
      {%- set data = {
          "title": "Default Service Account with full API access",
          "result": "Not approved",
          "message": "Instance is configured to use Default Service Account with Full Access to all cloud APIs"
      } -%}
    {%- else -%}
      {%- set data = {
          "title": "Default Service Account with full API access",
          "result": "Skip",
          "message": "No data available for Service Account yet"
      } -%}
    {%- endif -%}

    {%- set results = results.concat(data) -%}

    {{ results | json }}
  EOT
}
