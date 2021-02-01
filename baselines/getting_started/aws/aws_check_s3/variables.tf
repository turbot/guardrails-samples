variable "turbot_profile" {
  description = "Enter profile matching your turbot cli credentials."
  default     = "default"
}

variable "trusted_accounts" {
  type    = list(string)
  default = []
}

variable "smart_folder_name" {
  type        = string
  description = "Smart folder name for the baseline"
  default     = "AWS Check S3 Policies"
}

variable "enable_s3_access_logging_policies" {
  type        = bool
  description = "Enable the S3 access logging policies for baseline"
  default     = true
}

variable "enable_s3_active_policies" {
  type        = bool
  description = "Enable the S3 active policies for baseline"
  default     = true
}

variable "enable_s3_approved_policies" {
  type        = bool
  description = "Enable the S3 approved policies for baseline"
  default     = true
}

variable "enable_s3_enabled_policies" {
  type        = bool
  description = "Enable the S3 enabled policies for baseline"
  default     = true
}

variable "enable_s3_encryption_policies" {
  type        = bool
  description = "Enable the S3 encryption policies for baseline"
  default     = true
}

variable "enable_s3_permission_policies" {
  type        = bool
  description = "Enable the S3 permission policies for baseline"
  default     = true
}

variable "enable_s3_public_access_policies" {
  type        = bool
  description = "Enable the S3 public access policies for baseline"
  default     = true
}

variable "enable_s3_tag_policies" {
  type        = bool
  description = "Enable the S3 tag policies for baseline"
  default     = true
}

variable "enable_s3_trusted_access_policies" {
  type        = bool
  description = "Enable the S3 trusted access policies for baseline"
  default     = true
}

variable "use_simple_s3_bucket_versioning" {
  type        = bool
  description = "Enable the S3 versioning policies for baseline"
  default     = true
}
