variable "local_directory_name" {
  description = "Enter the name for the local directory to be created:"
  type    = string
}

variable "user_details" {
  type    = map(string)
}

# It should be the turbot id of turbot, folder or resource
# The Admin and Owner grants will be activated at this level
variable "grant_scope_id" {
  type    = string
  default = "tmod:@turbot/turbot#/"
}