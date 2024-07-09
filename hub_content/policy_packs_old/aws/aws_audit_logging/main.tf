/* Configure the Turbot CloudTrail stack.
The Turbot Audit Trail provides a mechanism for configuring a CloudTrail to record API calls to your AWS accounts.
AWS > Turbot > Audit Trail */

resource "turbot_smart_folder" "turbot_audit_trail" {
  title         = var.smart_folder_title
  description   = "Create a smart folder to apply the Turbot Trail policy settings"
  parent        = "tmod:@turbot/turbot#/"
}

resource "turbot_policy_setting" "turbot_trail_configured" {
    resource = turbot_smart_folder.turbot_audit_trail.id
    type = "tmod:@turbot/aws#/policy/types/auditTrail"
    value = "Enforce: Configured"
}

# The desired state of the CloudTrail.  When disabled, a CloudTrail does not log any events.

resource "turbot_policy_setting" "turbot_trail_enabled" {
    resource = turbot_smart_folder.turbot_audit_trail.id
    type = "tmod:@turbot/aws#/policy/types/trailEnabled"
    value = "Enabled"
  
}

/* The region in that will host the Turbot Trail when configured to use a multi-region trail.
AWS > Turbot > Audit Trail > CloudTrail > Trail > Global Region */

resource "turbot_policy_setting" "turbot_trail_configured_globalregion" {
    resource = turbot_smart_folder.turbot_audit_trail.id
    type = "tmod:@turbot/aws#/policy/types/trailGlobalRegion"
    value = "us-east-1"
}