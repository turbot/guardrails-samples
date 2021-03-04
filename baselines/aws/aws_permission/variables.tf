variable "local_directory_name" {
  description = "Enter the name for the local directory to be created:"
  type        = string
}

variable "user_details" {
  description = "Enter the user details (`<example@domain.com>`=`<firstname lastname>`):"
  type        = map(string)
}

# It is the turbot id of turbot folder or resource.
# The Admin and Owner grants will be activated at this level
variable "grant_scope_id" {
  type        = string
  default     = "tmod:@turbot/turbot#/"
}
