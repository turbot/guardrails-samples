# Required

variable "resource_approved_regions" {
  description = <<DESC
  Map of the list of approved regions controls.

  Possible values for the key of this map is found in locals.tf defined in the local variable policy_map.
  For example `aws-acm-certificate : "tmod:@turbot/aws-acm#/policy/types/certificateApproved"` has key `aws-acm-certificate`.

  The value of the map is one of these possible values:
    - "Skip"
    - "Check: Approved"
    - "Enforce: Delete unapproved if new"

  Check demo.tfvars for an example of how to set this value.
  DESC
  type        = map(string)
}

# variable "resource_approved_regions_region_list" {
#   description = <<DESC
#   The expected format is an array of regions names. You may use the '*' and '?' wildcard characters.
#   Example of values:
#     - us-east-1
#     - ap-northeast-1
#     - ca-central-1
#   DESC
#   type        = list(string)
# }

variable "resource_approved_regions_region_list" {
  description = <<DESC
  The expected format is an array of regions names. You may use the '*' and '?' wildcard characters.
  Example of values:
    - us-east-1
    - ap-northeast-1
    - ca-central-1
  DESC
  type        = list(string)
}


variable "turbot_profile" {
  description = "Enter profile matching your turbot cli credentials."
  default     = "default"
}

variable "smart_folder_name" {
  description = "Smart folder name for the baseline"
  type        = string
  default     = "AWS Check Regions Policies"
}

variable "smart_folder_description" {
  description = "Enter a description for the smart folder"
  type        = string
  default     = "Defines sets of policies for the baseline AWS check S3"
}

variable "smart_folder_parent_resource" {
  description = "Enter the resource ID or AKA for the parent of the smart folder"
  type        = string
  default     = "tmod:@turbot/turbot#/"
}
