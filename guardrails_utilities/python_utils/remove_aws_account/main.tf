terraform {
  required_version = ">= 0.13.0"
  required_providers {
    turbot = {
      source = "turbot/turbot"
    }
  }
}

provider "turbot" {
  ## Update with the name of the local Turbot Profile 
  ## that is configured to connect to your workspace.
  profile  = "demo"
}

data "turbot_resource" "deleteThisAwsAccount" {
  ## Update with aka of the account to delete
  id = "arn:aws:::337619943512"
}

## Delete turbot event handlers from the account
resource "turbot_policy_setting" "turbotChangeWindow" {
  resource = data.turbot_resource.deleteThisAwsAccount.id
  type     = "tmod:@turbot/aws#/policy/types/eventHandlers"
  value    = "Enforce: Not configured"
}


