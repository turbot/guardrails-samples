# Ensure encryption on RDS instances and clusters
# Commented out since these services are not associated to the initial mod install list

# ## RDS Instances
# resource "turbot_policy_setting" "db_instancce_approved" {
#   resource = turbot_smart_folder.aws_encryption.id
#   type     = "tmod:@turbot/aws-rds#/policy/types/dbInstanceApproved"
#   value    = "Check: Approved"
# }

# resource "turbot_policy_setting" "db_instance_approved_encryption" {
#   resource = turbot_smart_folder.aws_encryption.id
#   type     = "tmod:@turbot/aws-rds#/policy/types/dbInstanceEncryptionAtRest"
#   value    = "AWS managed key or higher"
# }

# ## Manual Snapshots
# resource "turbot_policy_setting" "db_snapshot_approved" {
#   resource = turbot_smart_folder.aws_encryption.id
#   type     = "tmod:@turbot/aws-rds#/policy/types/dbSnapshotManualApproved"
#   value    = "Check: Approved"
# }

# resource "turbot_policy_setting" "db_snapshot_approved_encryption" {
#   resource = turbot_smart_folder.aws_encryption.id
#   type     = "tmod:@turbot/aws-rds#/policy/types/dbSnapshotManualEncryptionAtRest"
#   value    = "AWS managed key or higher"
# }

