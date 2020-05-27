variable "smart_folder_title" {
  description = "Enter a title for the smart folder"
  type        = string
}

variable "target_resource" {
  description = "Enter a target_resource to attach the smart folder and apply its policies."
  type        = string
}

variable "detector_master_account" {
  description = "Enter a Master Account allowed to own other GuardDuty account members."
  type        = string
}
