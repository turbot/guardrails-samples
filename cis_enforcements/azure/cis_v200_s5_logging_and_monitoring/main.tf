terraform {
  required_providers {
    turbot = {
      source = "turbot/turbot"
    }
  }
}

provider "turbot" {
}

variable "monitor_action_group_name_5_2" {
  type        = string
  description = "The name of the monitor action group."
  default     = ""
}

variable "monitor_action_group_email_reciever_name_5_2" {
  description = "The name of the email receiver in the monitor action group."
  type        = string
  default     = ""
}

variable "monitor_action_group_email_address_5_2" {
  description = "The email address where alerts from the monitor action group will be sent."
  type        = string
  default     = ""
}

variable "monitor_log_alert_name_5_2_1" {
  description = "The name of the monitor log alert for control 5.2.1."
  type        = string
  default     = ""
}

variable "monitor_log_alert_name_5_2_2" {
  description = "The name of the monitor log alert for control 5.2.2."
  type        = string
  default     = ""
}

variable "monitor_log_alert_name_5_2_3" {
  description = "The name of the monitor log alert for control 5.2.3."
  type        = string
  default     = ""
}

variable "monitor_log_alert_name_5_2_4" {
  description = "The name of the monitor log alert for control 5.2.4."
  type        = string
  default     = ""
}

variable "monitor_log_alert_name_5_2_5" {
  description = "The name of the monitor log alert for control 5.2.5."
  type        = string
  default     = ""
}

variable "monitor_log_alert_name_5_2_6" {
  description = "The name of the monitor log alert for control 5.2.6."
  type        = string
  default     = ""
}

variable "monitor_log_alert_name_5_2_7" {
  description = "The name of the monitor log alert for control 5.2.7."
  type        = string
  default     = ""
}

variable "monitor_log_alert_name_5_2_8" {
  description = "The name of the monitor log alert for control 5.2.8."
  type        = string
  default     = ""
}

variable "monitor_log_alert_name_5_2_9" {
  description = "The name of the monitor log alert for control 5.2.9."
  type        = string
  default     = ""
}

variable "monitor_log_alert_name_5_2_10" {
  description = "The name of the monitor log alert for control 5.2.10."
  type        = string
  default     = ""
}

