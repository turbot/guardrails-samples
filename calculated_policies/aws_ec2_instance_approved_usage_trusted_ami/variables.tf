variable "target_resource" {
  description = "Enter the resource ID or AKA for the resource to apply the calculated policy"
  type        = string
}

variable "trusted_ami_list" {
  type    = list(string)
  description = "Enter a list of trusted AMIs. If a instance image is not in it then instance will be set to Not approved."
}

variable "smart_folder_title" {
  description = "Enter a title for the smart folder"
  type        = string
  default     = "AWS EC2 Instance Trusted AMIs"
}

variable "smart_folder_description" {
  description = "Enter a description for the smart folder"
  type        = string
  default     = "Restrict AWS EC2 Instance image to trusted AMIs"
}

variable "smart_folder_parent_resource" {
  description = "Enter the resource ID or AKA for the parent of the smart folder"
  type        = string
  default     = "tmod:@turbot/turbot#/"
}
