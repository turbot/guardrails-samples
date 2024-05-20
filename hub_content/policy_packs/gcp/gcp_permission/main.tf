resource "turbot_local_directory" "test_dir" {
	parent              = var.grant_scope_id
	title               = var.local_directory_name
	description         = "Enter the name for the local directory to be created:"
	profile_id_template = "{{profile.email}}"
}

resource "turbot_local_directory_user" "test_user" {
  count               = length(var.user_details)
  title               = var.user_details[keys(var.user_details)[count.index]]
  email               = keys(var.user_details)[count.index]
  display_name        = var.user_details[keys(var.user_details)[count.index]]
  parent              = turbot_local_directory.test_dir.id
}

resource "turbot_profile" "test_user_profile" {
  count               = length(var.user_details)
  title               = turbot_local_directory_user.test_user[count.index].title
  email               = keys(var.user_details)[count.index]
  status              = "Active"
  given_name          = split(" ", var.user_details[keys(var.user_details)[count.index]])[0]
  family_name         = split(" ", var.user_details[keys(var.user_details)[count.index]])[1]
  display_name        = var.user_details[keys(var.user_details)[count.index]]
  parent              = turbot_local_directory.test_dir.id
  profile_id          = keys(var.user_details)[count.index]
}

resource "turbot_grant" "test" {
	count               = length(var.user_details)
	resource            = var.grant_scope_id
	type                = "tmod:@turbot/gcp#/permission/types/gcp"
	level               = "tmod:@turbot/turbot-iam#/permission/levels/superuser"
	identity            = turbot_profile.test_user_profile[count.index].id
}

resource "turbot_grant_activation" "activate_admin_grant" {
  count               = length(var.user_details)
  resource            = var.grant_scope_id
  grant               = turbot_grant.test[count.index].id
}