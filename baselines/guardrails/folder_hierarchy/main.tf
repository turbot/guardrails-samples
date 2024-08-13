data "turbot_policy_value" "example" {
  type     = "tmod:@turbot/turbot#/policy/types/workspaceUrl"
  resource = "tmod:@turbot/turbot#/"
}

# Base folder (Turbot > workspacename)
resource "turbot_folder" "workspace_base_folder" {
  parent      = "tmod:@turbot/turbot#/"
  title       = element(split(".", element(split("/", data.turbot_policy_value.example.value), 2)), 0)
  description = "Base folder for the workspace"
  akas        = ["workspace_base_folder"]
}

# AWS Base folder (Turbot > workspacename > AWS)
resource "turbot_folder" "aws_base_folder" {
  parent      = turbot_folder.workspace_base_folder.id
  title       = "AWS"
  description = "Base folder for AWS Resources"
}

# Azure Base folder (Turbot > workspacename > Azure)
resource "turbot_folder" "azure_base_folder" {
  parent      = turbot_folder.workspace_base_folder.id
  title       = "Azure"
  description = "Base folder for Azure Resources"
}

# GCP Base folder (Turbot > workspacename > GCP)
resource "turbot_folder" "gcp_base_folder" {
  parent      = turbot_folder.workspace_base_folder.id
  title       = "GCP"
  description = "Base folder for GCP Resources"
}
