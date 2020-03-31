# Variable definitions are defined in variables.tf
aws_account_id = "<12 digit aws account id to be imported>"

parent_resource = "<15 digit tubot folder id under which the aws account to be imported>"

turbot_account_id = "<12 digit master account id>"

turbot_external_id = "<8 digit sts:ExternalId>"

aws_region = "<AWS region to run the script>"

aws_profile = "<Optional - AWS Profile to use otherwise leave blank to use default profile>"

role_name = "turbot_service_role"
