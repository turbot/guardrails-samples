variable "smart_folder_title" {
    type        = "string"
    description = "Enter a title for the smart folder"
}

variable "target_resource" {
  description = "Enter a target_resource to attach the smart folder and apply its policies."
  type        = string
}
