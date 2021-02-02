# GCP > Compute Engine > Instance > Block Project Wide SSH Keys
resource "turbot_policy_setting" "instance_block_project_wide_ssh_keys" {
  resource = turbot_smart_folder.gcp_public_access.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/instanceBlockProjectWideSshKeys"
  value    = "Check: Enabled"
          # "Skip"
          # "Check: Disabled"
          # "Check: Enabled"
          # "Enforce: Disabled"
          # "Enforce: Enabled"
}

# GCP > Compute Engine > Instance > External IP Addresses
resource "turbot_policy_setting" "instance_external_ip_addresses" {
  resource = turbot_smart_folder.gcp_public_access.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/instanceExternalIpAddresses"
  value    = "Check: None"
          # "Skip"
          # "Check: None"
          # "Enforce: None"
}

# GCP > Compute Engine > Instance > Serial Port Access
resource "turbot_policy_setting" "instance_serial_port_access" {
  resource = turbot_smart_folder.gcp_public_access.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/instanceSerialPortAccess"
  value    = "Check: Enabled"
          # "Skip"
          # "Check: Disabled"
          # "Check: Enabled"
          # "Enforce: Disabled"
          # "Enforce: Enabled"
}