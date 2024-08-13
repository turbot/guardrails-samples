# Turbot Local Directory Creation
resource "turbot_local_directory" "local_dir" {
  profile_id_template = "turbot.local.{{profile.email}}"
  title               = "Turbot Support Team Login"
  parent              = "tmod:@turbot/turbot#/"
  description         = "Turbot Support Team Login"
}

# User Creation
resource "turbot_local_directory_user" "support_user" {
  title        = "Guardrails Support"
  email        = "support@turbot.com"
  display_name = "Guardrails Support"
  given_name   = "Guardrails"
  family_name  = "Support"
  parent       = turbot_local_directory.local_dir.id
}

# Profile Creation
resource "turbot_profile" "support_user_profile" {
  title        = "Guardrails Support"
  email        = "support@turbot.com"
  status       = "Active"
  given_name   = "Guardrails"
  family_name  = "Support"
  display_name = "Guardrails Support"
  parent       = turbot_local_directory.local_dir.id
  profile_id   = "turbot.local.support@turbot.com"
}

# Grant Creation
resource "turbot_grant" "support_user_grant_turbot_operator" {
  depends_on = [turbot_profile.support_user_profile]
  resource   = "tmod:@turbot/turbot#/"
  type       = "tmod:@turbot/turbot-iam#/permission/types/turbot"
  level      = "tmod:@turbot/turbot-iam#/permission/levels/operator"
  identity   = turbot_profile.support_user_profile.id
}

# Grant Activation
resource "turbot_grant_activation" "support_user_owner_activation" {
  resource = "tmod:@turbot/turbot#/"
  grant    = turbot_grant.support_user_grant_turbot_operator.id
}

# User Creation
resource "turbot_local_directory_user" "guardrails_admin" {
  title        = "Guardrails Admin"
  email        = "admin@turbot.com"
  display_name = "Guardrails Admin"
  given_name   = "Guardrails"
  family_name  = "Admin"
  parent       = turbot_local_directory.local_dir.id
}

# Profile Creation
resource "turbot_profile" "guardrails_admin_profile" {
  title        = "Guardrails Admin"
  email        = "admin@turbot.com"
  status       = "Active"
  given_name   = "Guardrails"
  family_name  = "Admin"
  display_name = "Guardrails Admin"
  parent       = turbot_local_directory.local_dir.id
  profile_id   = "turbot.local.admin@turbot.com"
}

# Grant Creation
resource "turbot_grant" "guardrails_admin_grant_turbot_owner" {
  depends_on = [turbot_profile.guardrails_admin_profile]
  resource   = "tmod:@turbot/turbot#/"
  type       = "tmod:@turbot/turbot-iam#/permission/types/turbot"
  level      = "tmod:@turbot/turbot-iam#/permission/levels/owner"
  identity   = turbot_profile.guardrails_admin_profile.id
}

# Grant Activation
resource "turbot_grant_activation" "guardrails_admin_owner_activation" {
  resource = "tmod:@turbot/turbot#/"
  grant    = turbot_grant.guardrails_admin_grant_turbot_owner.id
}
