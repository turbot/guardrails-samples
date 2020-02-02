################################        Variables        ###################################
variable "local_directory_name" {
  type        = string
  description = "Enter the name of local directory to be created"
}

# It should be the turbot id of turbot, folder or resource
# The Admin and Owner grants will be activated at this level
variable "grant_scope_id" {
  type    = string
  default = "tmod:@turbot/turbot#/"
}

############################## List of users with details to create  ###############
variable "user_details" {
  type        = map(string)
  description = "Enter the user details in (`<email>` = `<display name>`)"
}
