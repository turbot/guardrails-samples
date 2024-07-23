variable "smart_folder_title" {
  description = "Enter a title for the smart folder"
  type        = string
  default     = "ECR Repository Scan on Push"
}

variable "smart_folder_description" {
  description = "Enter a description for the smart folder"
  type        = string
  default     = "Automate Scan on Push AWS ECR Repository configurations to ensure images are scanned for vulnerabilities"
}

variable "smart_folder_parent_resource" {
  description = "Enter the resource ID or AKA for the parent of the smart folder"
  type        = string
  default     = "tmod:@turbot/turbot#/"
}