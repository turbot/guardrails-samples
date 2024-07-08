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

# GCP > Compute Engine > Instance > Block Project Wide SSH Keys
resource "turbot_policy_setting" "gcp_computeengine_instance_block_project_wide_ssh_keys" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/instanceBlockProjectWideSshKeys"
  note     = "GCP CIS v2.0.0 - Control: 4.3"
  value    = "Check: Enabled"
  # value    = "Enforce: Enabled"
}
