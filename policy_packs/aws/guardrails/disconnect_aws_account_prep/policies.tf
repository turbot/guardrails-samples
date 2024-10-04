# AWS > Turbot > Event Poller
resource "turbot_policy_setting" "aws_event_poller" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/eventPoller"
  value    = "Enabled"
  # value    = "Disabled"
  note     = "Set to disabled after all the other resources have been successfully decommissioned. Guardrails needs an event stream for the destroyed resources for proper and complete cleanup.  Event Pollers retrieve those destroy events. "
}

# AWS > Turbot > Logging Bucket
resource "turbot_policy_setting" "aws_logging_bucket" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/loggingBucket"
  value    = "Check: Not configured"
  # value    = "Enforce: Not configured"
  # value    = "Enforce: Configured"
  note     = "Decommissions the Guardrails-managed regional S3 logging buckets."
}

# AWS > Turbot > Service Roles
resource "turbot_policy_setting" "aws_service_roles" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/serviceRoles"
  value    = "Check: Not configured"
  # value    = "Enforce: Not configured"
  # value    = "Enforce: Configured"
  note     = "Decommissions the Guardrails-managed Service Roles."
}

# AWS > Turbot > Event Handlers [Global]
resource "turbot_policy_setting" "aws_event_handlers_global" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/eventHandlersGlobal"
  value    = "Check: Not configured"
  # value    = "Enforce: Not configured"
  # value    = "Enforce: Configured"
  note     = "Decommissions Global Event Handlers."
}

# AWS > Turbot > Event Handlers
resource "turbot_policy_setting" "aws_event_handlers" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/eventHandlers"
  value    = "Check: Not configured"
  # value    = "Enforce: Not configured"
  # value    = "Enforce: Configured"
  note     = "Decommissions AWS Event Handlers."
}

# AWS > Turbot > Audit Trail
resource "turbot_policy_setting" "aws_audit_trail" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/auditTrail"
  value    = "Check: Not configured"
  # value    = "Enforce: Not configured"
  # value    = "Enforce: Configured"
  note     = "Decommissions Guardrails-managed CloudTrail trails. "
}

# AWS > IAM > Permissions
resource "turbot_policy_setting" "aws_iam_permissions" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/permissions"
  value    = "Check: None"
  # value    = "Enforce: None"
  # value    = "Enforce: Configured"
  note     = "Removes Guardrails-managed IAM users, groups and roles."
}
