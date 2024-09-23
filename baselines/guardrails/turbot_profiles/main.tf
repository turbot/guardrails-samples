# Directory Creation 
resource "turbot_turbot_directory" "turbot_dir" {
  parent              = "tmod:@turbot/turbot#/"
  title               = "Turbot SAML"
  description         = "Allow login through turbot directory to turbot workspaces."
  profile_id_template = "turbot.directory.{{profile.$source.name}}"
  server              = "turbot.com"
}

# Creates profiles defined in terraform.tfvars
# Will grant the Turbot/Owner role to each profile at the Turbot root level
# Will activate each Turbot/Owner grant to each profile
resource "turbot_profile" "create_profile" {
  for_each     = var.user_profile
  parent       = turbot_turbot_directory.turbot_dir.id
  email        = each.value.email
  title        = each.value.name
  display_name = each.value.name
  given_name   = element(split(" ", each.value.name), 0)
  family_name  = element(split(" ", each.value.name), 1)
  status       = "Active"
  profile_id   = "turbot.directory.${each.key}"
}

resource "turbot_grant" "profile_grant_turbot_owner" {
  for_each = var.user_profile
  resource = "tmod:@turbot/turbot#/"
  type     = "tmod:@turbot/turbot-iam#/permission/types/turbot"
  level    = "tmod:@turbot/turbot-iam#/permission/levels/owner"
  identity = turbot_profile.create_profile[each.key].id
}

resource "turbot_grant_activation" "activate_turbot_owner_grant" {
  for_each = var.user_profile
  resource = "tmod:@turbot/turbot#/"
  grant    = turbot_grant.profile_grant_turbot_owner[each.key].id
}
