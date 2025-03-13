# AWS > IAM > Role > Active
resource "turbot_policy_setting" "role_active" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/roleActive"
  value    = "Check: Active"
  # value    = "Enforce: Quarantine inactive with 90 days warning"
  # Available enforcement options:
  # value    = "Enforce: Quarantine inactive with 1 day warning"
  # value    = "Enforce: Quarantine inactive with 3 days warning"
  # value    = "Enforce: Quarantine inactive with 7 days warning"
  # value    = "Enforce: Quarantine inactive with 14 days warning"
  # value    = "Enforce: Quarantine inactive with 30 days warning"
  # value    = "Enforce: Quarantine inactive with 60 days warning"
  # value    = "Enforce: Quarantine inactive with 90 days warning"
  # value    = "Enforce: Quarantine inactive with 180 days warning"
  # value    = "Enforce: Quarantine inactive with 365 days warning"
}

# AWS > IAM > Role > Active > Recently Used
resource "turbot_policy_setting" "role_active_recently_used" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/roleActiveRecentlyUsed"
  value    = "Force active if recently used <= 90 days"
  # Available options:
  # value    = "Force active if recently used <= 1 day"
  # value    = "Force active if recently used <= 3 days"
  # value    = "Force active if recently used <= 7 days"
  # value    = "Force active if recently used <= 14 days"
  # value    = "Force active if recently used <= 30 days"
  # value    = "Force active if recently used <= 60 days"
  # value    = "Force active if recently used <= 90 days"
  # value    = "Force active if recently used <= 180 days"
  # value    = "Force active if recently used <= 365 days"
}

# AWS > IAM > Role > Active > Last Modified
resource "turbot_policy_setting" "role_active_last_modified" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/roleActiveLastModified"
  value    = "Force active if last modified <= 90 days"
  # Available options:
  # value    = "Skip"
  # value    = "Force active if last modified <= 1 day"
  # value    = "Force active if last modified <= 3 days"
  # value    = "Force active if last modified <= 7 days"
  # value    = "Force active if last modified <= 14 days"
  # value    = "Force active if last modified <= 30 days"
  # value    = "Force active if last modified <= 60 days"
  # value    = "Force active if last modified <= 90 days"
  # value    = "Force active if last modified <= 180 days"
  # value    = "Force active if last modified <= 365 days"
}

# AWS > IAM > Role > Active > Quarantine Policy Name
resource "turbot_policy_setting" "role_active_quarantine_policy_name" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/roleActiveQuarantinePolicyName"
  value    = "AWSInactiveRoleQuarantinePolicy"
}
