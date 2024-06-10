# Policy Pack
resource "turbot_smart_folder" "pack" {
  title       = "Enforce AWS DMS relication instances to restrict public access"
  description = "Stop/Terminate AWS DMS replication instances if they are are publicly accessible."
  parent      = "tmod:@turbot/turbot#/"
}

# AWS > DMS > Enabled
resource "turbot_policy_setting" "aws_dms_enabled" {
  resource = turbot_smart_folder.pack.id
  type     = "tmod:@turbot/aws-dms#/policy/types/dmsEnabled"
  value    = "Enabled"
}
