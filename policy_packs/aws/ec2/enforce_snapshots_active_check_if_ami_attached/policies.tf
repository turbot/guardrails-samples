# AWS > EC2 > Snapshot > Active (Multi-query Calculated Policy)
#
# Logic:
# - The first query gets the SnapshotId of the current snapshot resource.
# - The second query searches for any AMI (Amazon Machine Image) resources
#   where any BlockDeviceMappings[].Ebs.SnapshotId matches this snapshot's ID.
#   (This is found in the AMI's data block, e.g.:
#     BlockDeviceMappings:
#       - DeviceName: /dev/xvda
#         Ebs:
#           SnapshotId: snap-03f6d591f26abd4f4
#           ...)
# - If any AMIs reference this snapshot, the policy returns 'Check: Active'
#   (meaning the snapshot is still in use and should not be deleted).
# - If no AMIs reference this snapshot, the policy returns
#   'Enforce: Delete inactive with 30 days warning' (safe to clean up).
#
# This logic ensures that only snapshots not in use by any AMI are targeted for deletion.
resource "turbot_policy_setting" "aws_ec2_snapshot_active" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/aws-ec2#/policy/types/snapshotActive"
  template_input = <<-EOT
    - |
      {
        resource {
          snapshot_id: get(path: "SnapshotId")
        }
      }
    - |
      {
        resource {
          data
          snapshot_id: get(path: "SnapshotId")
        }
        images: resources(filter: "resourceType:'tmod:@turbot/aws-ec2#/resource/types/ami' $.BlockDeviceMappings.*.Ebs.SnapshotId:{{$.resource.snapshot_id}} limit:5000") {
          metadata {
            stats {
              total
            }
          }
        }
      }
    EOT
  template       = <<-EOT
    {%- if $.images.metadata.stats.total > 0 -%}
      "Check: Active"
    {%- else -%}
      "Enforce: Delete inactive with 30 days warning"
    {%- endif -%}
  EOT
}

# AWS > EC2 > Snapshot > Active > Age
resource "turbot_policy_setting" "aws_ec2_snapshot_active_age" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/snapshotActiveAge"
  value    = "Force inactive if age > 30 days"
}

# AWS > EC2 > Snapshot > Active > Budget
resource "turbot_policy_setting" "aws_ec2_snapshot_active_budget" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/snapshotActiveBudget"
  value    = "Skip"
}

# AWS > EC2 > Snapshot > Active > Last Modified
resource "turbot_policy_setting" "aws_ec2_snapshot_active_last_modified" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ec2#/policy/types/snapshotActiveLastModified"
  value    = "Skip"
}
