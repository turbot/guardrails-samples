variable "turbot_profile" {
  type        = string
  description = "Enter the profile to connect to the correct Turbot workspace"
}

variable "target_resource" {
  type        = string
  description = "Enter the resource ID or AKA for the resource to apply the calculated policy"
}

variable "public_access_block_settings_skip_list" {
  type        = list(string)
  description = <<DESC
  The Public Access Block settings for the S3 bucket.

  If a `check-*` is passed in as a setting for the Public Access Block then the calculated policy will configure 
  Turbot to enabled the setting. 

  If a `uncheck-*` is passed in as a setting for the Public Access Block then the calculated policy will configure 
  Turbot to disabled the setting. 

  If a neither value passed in as a setting for the Public Access Block then the calculated policy will configure 
  Turbot to use the current value of the bucket.

  Possible values are:
    - check_block_public_acls
    - uncheck_block_public_acls
    - check_block_public_bucket_policies
    - uncheck_block_public_bucket_policies
    - check_ignore_public_acls
    - uncheck_ignore_public_acls
    - check_restrict_public_bucket_policies
    - uncheck_restrict_public_bucket_policies
  DESC
  default     = []
}

variable "public_access_block_settings" {
  type        = string
  description = <<DESC
  Controls the Public Access Block settings
  Possible values are:
    - skip
    - check
    - enforce

  Details:
    skip:     Skip
    check:    Check: Per `Public Access Block  > Settings`
    enforce:  Enforce: Per `Public Access Block  > Settings`
  DESC
  default     = "skip"
}


variable "smart_folder_title" {
  type        = string
  description = "Enter a title for the smart folder"
  default     = "S3 Bucket Public Access Skip Settings"
}

variable "smart_folder_description" {
  description = "Enter a description for the smart folder"
  type        = string
  default     = <<DESC
  The policy AWS > S3 > Bucket > Public Access Block > Settings will currently either set each setting to enabled or 
  disabled. 
  
  This calculated policy is for the case where we want to leave a specific setting unchanged in the Public Access Block.
  
  This is to allow for backward compatibility to V3 where each setting could be customised to be either enabled, 
  disabled or skipped.
  DESC
}

variable "smart_folder_parent_resource" {
  description = "Enter the resource ID or AKA for the parent of the smart folder"
  type        = string
  default     = "tmod:@turbot/turbot#/"
}
