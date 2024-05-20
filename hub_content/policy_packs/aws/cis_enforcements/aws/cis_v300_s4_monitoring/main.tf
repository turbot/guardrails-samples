terraform {
  required_providers {
    turbot = {
      source = "turbot/turbot"
    }
  }
}

provider "turbot" {
}

variable "sns_topic" {
  type        = string
  description = "The name of the SNS topic to which the CloudWatch Alarm actions will be delivered."
  default     = ""
}

variable "log_metric_filter_name_4_1" {
  type        = string
  description = "The name of the Log Metric Filter for control 4.1."
  default     = ""
}

variable "log_metric_alarm_name_4_1" {
  type        = string
  description = "The name of the Metric Alarm for control 4.1."
  default     = ""
}

variable "log_metric_filter_name_4_2" {
  type        = string
  description = "The name of the Log Metric Filter for control 4.2."
  default     = ""
}

variable "log_metric_alarm_name_4_2" {
  type        = string
  description = "The name of the Metric Alarm for control 4.2."
  default     = ""
}

variable "log_metric_filter_name_4_3" {
  type        = string
  description = "The name of the Log Metric Filter for control 4.3."
  default     = ""
}

variable "log_metric_alarm_name_4_3" {
  type        = string
  description = "The name of the Metric Alarm for control 4.3."
  default     = ""
}

variable "log_metric_filter_name_4_4" {
  type        = string
  description = "The name of the Log Metric Filter for control 4.4."
  default     = ""
}

variable "log_metric_alarm_name_4_4" {
  type        = string
  description = "The name of the Metric Alarm for control 4.4."
  default     = ""
}

variable "log_metric_filter_name_4_5" {
  type        = string
  description = "The name of the Log Metric Filter for control 4.5."
  default     = ""
}

variable "log_metric_alarm_name_4_5" {
  type        = string
  description = "The name of the Metric Alarm for control 4.5."
  default     = ""
}

variable "log_metric_filter_name_4_6" {
  type        = string
  description = "The name of the Log Metric Filter for control 4.6."
  default     = ""
}

variable "log_metric_alarm_name_4_6" {
  type        = string
  description = "The name of the Metric Alarm for control 4.6."
  default     = ""
}

variable "log_metric_filter_name_4_7" {
  type        = string
  description = "The name of the Log Metric Filter for control 4.7."
  default     = ""
}

variable "log_metric_alarm_name_4_7" {
  type        = string
  description = "The name of the Metric Alarm for control 4.7."
  default     = ""
}

variable "log_metric_filter_name_4_8" {
  type        = string
  description = "The name of the Log Metric Filter for control 4.8."
  default     = ""
}

variable "log_metric_alarm_name_4_8" {
  type        = string
  description = "The name of the Metric Alarm for control 4.8."
  default     = ""
}

variable "log_metric_filter_name_4_9" {
  type        = string
  description = "The name of the Log Metric Filter for control 4.9."
  default     = ""
}

variable "log_metric_alarm_name_4_9" {
  type        = string
  description = "The name of the Metric Alarm for control 4.9."
  default     = ""
}

variable "log_metric_filter_name_4_10" {
  type        = string
  description = "The name of the Log Metric Filter for control 4.10."
  default     = ""
}

variable "log_metric_alarm_name_4_10" {
  type        = string
  description = "The name of the Metric Alarm for control 4.10."
  default     = ""
}

variable "log_metric_filter_name_4_11" {
  type        = string
  description = "The name of the Log Metric Filter for control 4.11."
  default     = ""
}

variable "log_metric_alarm_name_4_11" {
  type        = string
  description = "The name of the Metric Alarm for control 4.11."
  default     = ""
}

variable "log_metric_filter_name_4_12" {
  type        = string
  description = "The name of the Log Metric Filter for control 4.12."
  default     = ""
}

variable "log_metric_alarm_name_4_12" {
  type        = string
  description = "The name of the Metric Alarm for control 4.12."
  default     = ""
}

variable "log_metric_filter_name_4_13" {
  type        = string
  description = "The name of the Log Metric Filter for control 4.13."
  default     = ""
}

variable "log_metric_alarm_name_4_13" {
  type        = string
  description = "The name of the Metric Alarm for control 4.13."
  default     = ""
}

variable "log_metric_filter_name_4_14" {
  type        = string
  description = "The name of the Log Metric Filter for control 4.14."
  default     = ""
}

variable "log_metric_alarm_name_4_14" {
  type        = string
  description = "The name of the Metric Alarm for control 4.14."
  default     = ""
}

variable "log_metric_filter_name_4_15" {
  type        = string
  description = "The name of the Log Metric Filter for control 4.15."
  default     = ""
}

variable "log_metric_alarm_name_4_15" {
  type        = string
  description = "The name of the Metric Alarm for control 4.15."
  default     = ""
}
