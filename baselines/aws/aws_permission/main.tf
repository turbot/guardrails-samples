resource "turbot_local_directory" "test_dir" {
	parent              = "tmod:@turbot/turbot#/"
	title               = var.local_directory_name
	description         = "test Directory"
	profile_id_template = "{{profile.email}}"
}

resource "turbot_local_directory_user" "test_user" {
	count               = length(var.user_details)
	title               = var.user_details[keys(var.user_details)[count.index]]
	email               = keys(var.user_details)[count.index]
	display_name        = var.user_details[keys(var.user_details)[count.index]]
	parent              = turbot_local_directory.test_dir.id
}

resource "turbot_profile" "test_user" {
	count               = length(var.user_details)
	title               = var.user_details[keys(var.user_details)[count.index]]
	email               = keys(var.user_details)[count.index]
	directory_pool_id   = "dpi"
	given_name          = split(" ",var.user_details[keys(var.user_details)[count.index]],)[0]
	family_name         = split(" ",var.user_details[keys(var.user_details)[count.index]],)[1]
	display_name        = var.user_details[keys(var.user_details)[count.index]]
	parent              = turbot_local_directory.test_dir.id
	profile_id          = keys(var.user_details)[count.index]
}

resource "turbot_grant" "test" {
	count               = length(var.user_details)
	resource            = "tmod:@turbot/turbot#/"
	type                = "tmod:@turbot/aws#/permission/types/aws"
	level               = "tmod:@turbot/turbot-iam#/permission/levels/superuser"
	identity            = turbot_profile.test_user[count.index].id
}
