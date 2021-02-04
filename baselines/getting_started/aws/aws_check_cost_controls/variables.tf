variable "turbot_profile" {
  description = "Enter profile matching your turbot cli credentials."
  default     = "default"
}

variable "smart_folder_name" {
  description = "Smart folder name for the baseline"
  type        = string
  default     = "AWS Check S3 Policies"
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

variable "set_resource_active_policies" {
  type        = bool
  description = "Set resource active policies for baseline"
  default     = true
}

variable "set_resource_age_policies" {
  type        = bool
  description = "Set resource age policies for baseline"
  default     = true
}

variable "aws_ec2_volume_active" {
  type        = bool
  description = "AWS EC2 volume active policies for baseline"
  default     = true
}

variable "aws_ec2_volume_active_attached" {
  type        = bool
  description = "AWS EC2 volume active attached policies for baseline"
  default     = true
}

variable "aws_ec2_instance_schedule" {
  type        = bool
  description = "AWS EC2 instance schedule policies for baseline"
  default     = true
}

variable "aws_ec2_instance_schedule_tag" {
  type        = bool
  description = "AWS EC2 instance schedule tag policies for baseline"
  default     = true
}

# variable "aws_rds_db_cluster_schedule" {
#   type        = bool
#   description = "AWS RDS DB Cluster Schedule policies for baseline"
#   default     = true
# }

# variable "aws_rds_cluster_schedule_tag" {
#   type        = bool
#   description = "AWS RDS DB Cluster Schedule Tag policies for baseline"
#   default     = true
# }

# variable "aws_rds_db_instance_schedule" {
#   type        = bool
#   description = "AWS RDS DB Instance Schedule policies for baseline"
#   default     = true
# }

# variable "aws_rds_instance_schedule_tag" {
#   type        = bool
#   description = "AWS RDS DB Instance Schedule Tag policies for baseline"
#   default     = true
# }

# variable "aws_redshift_cluster_schedule" {
#   type        = bool
#   description = "AWS Redshift Cluster Schedule policies for baseline"
#   default     = true
# }

# variable "aws_redshift_cluster_schedule_tag" {
#   type        = bool
#   description = "AWS Redshift Cluster Schedule Tag policies for baseline"
#   default     = true
# }

# variable "aws_workspace_schedule" {
#   type        = bool
#   description = "AWS Workspace Schedule policies for baseline"
#   default     = true
# }

# variable "aws_workspace_schedule_tag {
#   type        = bool
#   description = "AWS Workspace Schedule Tag policies for baseline"
#   default     = true
# }