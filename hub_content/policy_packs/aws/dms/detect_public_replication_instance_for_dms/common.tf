# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Detect public replication instances for AWS DMS"
  description = "Detect whether replication instances for AWS database migration service are public"
  parent      = "tmod:@turbot/turbot#/"
}

# AWS > DMS > Enabled
resource "turbot_policy_setting" "aws_dms_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-dms#/policy/types/dmsEnabled"
  value    = "Enabled"
}
