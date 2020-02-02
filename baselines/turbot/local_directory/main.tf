##########  Local Directory Creation    ##########
resource "turbot_local_directory" "test_dir" {
  parent              = "tmod:@turbot/turbot#/"
  title               = var.local_directory_name
  description         = var.local_directory_name
  profile_id_template = "{{profile.email}}"
}


##########  User Creation    ##########
resource "turbot_local_directory_user" "create_user" {
  count        = length(var.user_details)
  title        = var.user_details[keys(var.user_details)[count.index]]
  email        = keys(var.user_details)[count.index]
  display_name = var.user_details[keys(var.user_details)[count.index]]
  parent       = turbot_local_directory.test_dir.id
}

##########  User Profile Creation    ##########
resource "turbot_profile" "create_user_profile" {
  count        = length(var.user_details)
  title        = turbot_local_directory_user.create_user[count.index].title
  email        = keys(var.user_details)[count.index]
  status       = "Active"
  given_name   = split(" ", var.user_details[keys(var.user_details)[count.index]])[0]
  family_name  = split(" ", var.user_details[keys(var.user_details)[count.index]])[1]
  display_name = var.user_details[keys(var.user_details)[count.index]]
  parent       = turbot_local_directory.test_dir.id
  profile_id   = keys(var.user_details)[count.index]
}

##########  Grant Creation    ##########

# Create Turbot/Admin grant
resource "turbot_grant" "grant_admin" {
  count    = length(var.user_details)
  resource = "tmod:@turbot/turbot#/"
  type     = "tmod:@turbot/turbot-iam#/permission/types/turbot"
  level    = "tmod:@turbot/turbot-iam#/permission/levels/admin"
  identity = turbot_profile.create_user_profile[count.index].id
}

# Create Turbot/Owner grant
resource "turbot_grant" "grant_owner" {
  count    = length(var.user_details)
  resource = "tmod:@turbot/turbot#/"
  type     = "tmod:@turbot/turbot-iam#/permission/types/turbot"
  level    = "tmod:@turbot/turbot-iam#/permission/levels/owner"
  identity = turbot_profile.create_user_profile[count.index].id
}

##########  Grant Activation    ##########

# Activate Turbot/Admin grant
resource "turbot_grant_activation" "activate_admin_grant" {
  count    = length(var.user_details)
  resource = var.grant_scope_id
  grant    = turbot_grant.grant_admin[count.index].id
}

# Activate Turbot/Owner grant
resource "turbot_grant_activation" "activate_owner_grant" {
  count    = length(var.user_details)
  resource = var.grant_scope_id
  grant    = turbot_grant.grant_owner[count.index].id
}

