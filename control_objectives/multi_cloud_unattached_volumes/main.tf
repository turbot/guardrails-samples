# Smart Folder Definition
resource "turbot_smart_folder" "unattached_volumes" {
  title       = var.smart_folder_title
  description = var.smart_folder_description
  parent      = var.smart_folder_parent_resource
}

# Below examples assumes all available Active Volume and Active Disk Attached policies across multi-cloud
# To get started, the baseline assumes a Check: mode to start
# Edit the template below to meet your requirements.

### AWS ###
# AWS > EC2 > Volume > Active
# AWS > EC2 > Volume > Active > Attached
resource "turbot_policy_setting" "aws_ec2_volume_active" {
  resource = turbot_smart_folder.unattached_volumes.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/volumeActive"
  value    = "Check: Active"
          # Skip
          # Check: Active
          # Enforce: Detach, snapshot and delete inactive with 1 day warning
          # Enforce: Detach, snapshot and delete inactive with 3 days warning
          # Enforce: Detach, snapshot and delete inactive with 7 days warning
          # Enforce: Detach, snapshot and delete inactive with 14 days warning
          # Enforce: Detach, snapshot and delete inactive with 30 days warning
          # Enforce: Detach, snapshot and delete inactive with 60 days warning
          # Enforce: Detach, snapshot and delete inactive with 90 days warning
          # Enforce: Detach, snapshot and delete inactive with 180 days warning
          # Enforce: Detach, snapshot and delete inactive with 365 days warning
}

resource "turbot_policy_setting" "aws_ec2_volume_active_attached" {
  resource = turbot_smart_folder.unattached_volumes.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/volumeActiveAttached"
  value    = "Force inactive if unattached"
          # Skip
          # Active if attached
          # Force active if attached
          # Force inactive if unattached
}


### Azure ###
# Azure > Compute > Disk > Active
# Azure > Compute > Disk > Active > Attached
resource "turbot_policy_setting" "azure_compute_disk_active" {
  resource = turbot_smart_folder.unattached_volumes.id
  type     = "tmod:@turbot/azure-compute#/policy/types/diskActive"
  value    = "Check: Active"
          # Skip
          # Check: Active
          # Enforce: Delete inactive with 1 day warning
          # Enforce: Delete inactive with 3 days warning
          # Enforce: Delete inactive with 7 days warning
          # Enforce: Delete inactive with 14 days warning
          # Enforce: Delete inactive with 30 days warning
          # Enforce: Delete inactive with 60 days warning
          # Enforce: Delete inactive with 90 days warning
          # Enforce: Delete inactive with 180 days warning
          # Enforce: Delete inactive with 365 days warning
}

resource "turbot_policy_setting" "azure_compute_disk_active_attached" {
  resource = turbot_smart_folder.unattached_volumes.id
  type     = "tmod:@turbot/azure-compute#/policy/types/diskActiveAttached"
  value    = "Force inactive if unattached"
          # Skip
          # Active if attached
          # Force active if attached
          # Force inactive if unattached
}

### GCP ###
# GCP > Compute Engine > Disk > Active
# GCP > Compute Engine > Disk > Active > Attached
resource "turbot_policy_setting" "gcp_compute_disk_active" {
  resource = turbot_smart_folder.unattached_volumes.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/diskActive"
  value    = "Check: Active"
          # Skip
          # Check: Active
          # Enforce: Delete inactive with 1 day warning
          # Enforce: Delete inactive with 3 days warning
          # Enforce: Delete inactive with 7 days warning
          # Enforce: Delete inactive with 14 days warning
          # Enforce: Delete inactive with 30 days warning
          # Enforce: Delete inactive with 60 days warning
          # Enforce: Delete inactive with 90 days warning
          # Enforce: Delete inactive with 180 days warning
          # Enforce: Delete inactive with 365 days warning
}

resource "turbot_policy_setting" "gcp_compute_disk_active_attached" {
  resource = turbot_smart_folder.unattached_volumes.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/diskActiveAttached"
  value    = "Force inactive if unattached"
          # Skip
          # Active if attached
          # Force active if attached
          # Force inactive if unattached
}