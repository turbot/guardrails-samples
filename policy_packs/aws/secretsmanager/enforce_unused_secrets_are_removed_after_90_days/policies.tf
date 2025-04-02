# AWS > Secrets Manager > Secret > Active
resource "turbot_policy_setting" "secret_active" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-secretsmanager#/policy/types/secretActive"
  value    = "Check: Active"
  # value    = "Enforce: Delete inactive with 90 days warning"
  # Available enforcement options:
  # value    = "Enforce: Delete inactive with 1 day warning"
  # value    = "Enforce: Delete inactive with 3 days warning"
  # value    = "Enforce: Delete inactive with 7 days warning"
  # value    = "Enforce: Delete inactive with 14 days warning"
  # value    = "Enforce: Delete inactive with 30 days warning"
  # value    = "Enforce: Delete inactive with 60 days warning"
  # value    = "Enforce: Delete inactive with 90 days warning"
  # value    = "Enforce: Delete inactive with 180 days warning"
  # value    = "Enforce: Delete inactive with 365 days warning"
}

# AWS > Secrets Manager > Secret > Active > Age
resource "turbot_policy_setting" "secret_active_age" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-secretsmanager#/policy/types/secretActiveAge"
  value    = "Force inactive if age > 90 days"
  # Available options:
  # value    = "Skip"
  # value    = "Force inactive if age > 1 day"
  # value    = "Force inactive if age > 3 days"
  # value    = "Force inactive if age > 7 days"
  # value    = "Force inactive if age > 14 days"
  # value    = "Force inactive if age > 30 days"
  # value    = "Force inactive if age > 60 days"
  # value    = "Force inactive if age > 90 days"
  # value    = "Force inactive if age > 180 days"
  # value    = "Force inactive if age > 365 days"
}

# AWS > Secrets Manager > Secret > Active > Last Modified
resource "turbot_policy_setting" "secret_active_last_modified" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-secretsmanager#/policy/types/secretActiveLastModified"
  value    = "Active if last modified <= 90 days"
  # Available options:
  # value    = "Skip"
  # value    = "Active if last modified <= 1 day"
  # value    = "Active if last modified <= 3 days"
  # value    = "Active if last modified <= 7 days"
  # value    = "Active if last modified <= 14 days"
  # value    = "Active if last modified <= 30 days"
  # value    = "Active if last modified <= 60 days"
  # value    = "Active if last modified <= 90 days"
}
