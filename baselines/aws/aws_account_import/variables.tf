variable "aws_account_id" {
    description =  "Enter the Account ID that you wish to import.  Note that you must set your AWS credentials for this account either in your environment variables or default profile:"
    type        = string
}

variable "parent_resource" {
    description = "Enter the Turbot Resource ID for the folder into which to import the AWS account, or `tmod:@turbot/turbot#/` to import at the Turbot root:"
    type        = string
    default     = "tmod:@turbot/turbot#/"
}

# By default, Turbot is installed with administrator access to enable full functionlity.  If you wish to install Turbot in readonly mode (plus limited admin access to set up event routing) change this value to `true`
variable "read_only_access" {
    default     = true
}

variable "role_name" {
    description = "Enter the name of the AWS role that will be created.  Turbot will use this role to connect to your AWS account:"
    type        = string
}

variable "turbot_account_id" {
    description = "Enter the AWS account id from which Turbot will connect - This will be added to the trust policy for the Turbot role.  Leave the default of'525041748188' for turbot-dev.com, or enter the account ID where you have installed Turbot if you are running Turbot Enterprise:"
    type        = string
}

variable "turbot_external_id" {
    description = "Enter the External ID to be used in the AWS Trust Policy for the Turbot role:"
    type        = string
}