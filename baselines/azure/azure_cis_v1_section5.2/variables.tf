variable "resource_group_name" {
  description = "Enter the resource_group_name where resources will be created"
  type        = string
}

variable "scopes" {
  description = "Enter a list of scope"
  type        = list(string)
}
