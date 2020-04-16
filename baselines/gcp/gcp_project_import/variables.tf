variable "gcp_project_id" {
  description = "Enter the GCP Project Id that you wish to import: Note that you must set your AWS credentials for this account either in your environment variables or default profile:"
  type        = string
}

variable "client_email" {
  description = "Enter the GCP service account email id: "
  type        = string
}

variable "private_key" {
  # description =  "Enter the private key. (Must match pattern ^<<EOT -----BEGIN( RSA)? PRIVATE KEY-----\s+.+ EOT) "
  type = string
}

variable "parent_resource" {
  description = "Enter the Turbot Resource ID for the folder into which to import the AWS account, or `tmod:@turbot/turbot#/` to import at the Turbot root:"
  type        = string
  default     = "tmod:@turbot/turbot#/"
}
