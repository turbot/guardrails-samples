variable "enable_configuration_recording" {
  type        = bool
  description = "Enable the Configuration Recording policies for baseline"
  default     = false
}

variable "enable_aws_vpc_flowlogging" {
  type        = bool
  description = "Enable the Configuration Recording policies for baseline"
  default     = false
}

variable "enable_cloudtrail_trail_log_validation" {
  type        = bool
  description = "Enable the Cloudtrail logfile validation policies for baseline"
  default     = true
}

variable "enable_cloudtrail_trail_status" {
  type        = bool
  description = "Enable the Cloudtrail status policies for baseline"
  default     = true
}

variable "enable_cloudtrail_trail_encryption" {
  type        = bool
  description = "Enable the Cloudtrail trail encryption policies for baseline"
  default     = true
}

variable "enable_alb_access_logging" {
  type        = bool
  description = "Enable the Application loadbalancer access logging policies for baseline"
  default     = true
}

variable "enable_elb_access_logging" {
  type        = bool
  description = "Enable the Classic loadbalancer access logging policies for baseline"
  default     = true
}

variable "enable_nlb_access_logging" {
  type        = bool
  description = "Enable the Network loadbalancer access logging policies for baseline"
  default     = true
}

variable "enable_redshift_cluster_access_logging" {
  type        = bool
  description = "Enable the Redshift cluster access logging policies for baseline"
  default     = false
}

variable "enable_redshift_cluster_user_logging" {
  type        = bool
  description = "Enable the Redshift cluster access logging policies for baseline"
  default     = false
}

variable "enable_aws_s3_bucket_access_logging" {
  type        = bool
  description = "Enable the Redshift cluster access logging policies for baseline"
  default     = false
}

# Optional Common Baseline Configuration

variable "turbot_profile" {
  description = "Enter profile matching your turbot cli credentials."
}

variable "smart_folder_name" {
  description = "Smart folder name for the baseline"
  type        = string
  default     = "AWS Check Logging Policies"
}

variable "smart_folder_description" {
  description = "Enter a description for the smart folder"
  type        = string
  default     = "Defines sets of policies for the AWS check logging baseline"
}

variable "smart_folder_parent_resource" {
  description = "Enter the resource ID or AKA for the parent of the smart folder"
  type        = string
  default     = "tmod:@turbot/turbot#/"
}
