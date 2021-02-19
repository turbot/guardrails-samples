# GCP > Compute Engine > Instance > Block Project Wide SSH Keys
# https://turbot.com/v5/mods/turbot/gcp-computeengine/inspect#/policy/types/instanceBlockProjectWideSshKeys
resource "turbot_policy_setting" "instance_block_project_wide_ssh_keys" {
  count    = var.enable_instance_block_project_wide_ssh_keys_policies ? 1 : 0
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
# https://turbot.com/v5/mods/turbot/gcp-computeenginxe/inspect#/policy/types/instanceExternalIpAddresses
resource "turbot_policy_setting" "instance_external_ip_addresses" {
  count    = var.enable_instance_external_ip_addresses_policies ? 1 : 0
  resource = turbot_smart_folder.gcp_public_access.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/instanceExternalIpAddresses"
  value    = "Check: None"
            # "Skip"
            # "Check: None"
            # "Enforce: None"
}

# GCP > Compute Engine > Instance > Serial Port Access
# https://turbot.com/v5/mods/turbot/gcp-computeengine/inspect#/policy/types/instanceSerialPortAccess
resource "turbot_policy_setting" "instance_serial_port_access" {
  count    = var.enable_instance_serial_port_access_policies ? 1 : 0
  resource = turbot_smart_folder.gcp_public_access.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/instanceSerialPortAccess"
  value    = "Check: Enabled"
            # "Skip"
            # "Check: Disabled"
            # "Check: Enabled"
            # "Enforce: Disabled"
            # "Enforce: Enabled"
}
