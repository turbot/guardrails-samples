# Baselines

Turbot Guardrails Baselines provide best-practice configurations and examples for setting Turbot Guardrails policies. Baselines are implemented with [Terraform](https://www.terraform.io), allowing you to manage and provision Turbot Guardrails with a repeatable, idempotent, versioned infrastructure-as-code approach.

## Current Baselines

| Baseline              | Path                                                   | Description                                                                      |
|-----------------------|--------------------------------------------------------|----------------------------------------------------------------------------------|
| AWS Mods              | [aws_mods](./aws/aws_mods)                             | A common list of AWS mods to install                                             |
| AWS Service Enabled   | [aws_service_enabled](./aws/aws_service_enabled)       | Enable or disable AWS services in Guardrails                                     |
| Azure Mods            | [azure_mods](./azure/azure_mods)                       | A common list of Azure mods to install                                           |
| Azure Service Enabled | [azure_service_enabled](./azure/azure_service_enabled) | Enable or disable Azure services in Guardrails; register or deregister Azure providers |
| GCP Mods              | [gcp_mods](./gcp/gcp_mods)                             | A common list of Google Cloud Platform (GCP) mods to install                     |
| GCP Service Enabled   | [gcp_service_enabled](./gcp/gcp_service_enabled)       | Enable or disable GCP services in Guardrails; enable or disable GCP Service APIs |
| Folder Hierarchy      | [folder_hierarchy](./guardrails/folder_hierarchy)      | Create a folder hierarchy in your workspace                                      |
| Guardrails Mods       | [guardrails_mods](./guardrails/guardrails_mods)        | A common list of Guardrails mods to install                                      |
| Local Directory       | [local_directory](./guardrails/local_directory)        | Create a local directory and users in your workspace                             |
| Turbot Directory      | [turbot_directory](./guardrails/turbot_profiles)       | Create Turbot directory and profiles in your workspace                           |
| Workspace Settings    | [workspace_settings](./guardrails/workspace_settings)  | Apply a common set of policies for better management of your workspace           |

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)

### Credentials

To create a policy pack through Terraform:

- Ensure you have `Turbot/Admin` permissions (or higher) in Guardrails
- [Create access keys](https://turbot.com/guardrails/docs/guides/iam/access-keys#generate-a-new-guardrails-api-access-key) in Guardrails

And then set your credentials:

```sh
export TURBOT_WORKSPACE=myworkspace.acme.com
export TURBOT_ACCESS_KEY=acce6ac5-access-key-here
export TURBOT_SECRET_KEY=a8af61ec-secret-key-here
```

Please see [Turbot Guardrails Provider authentication](https://registry.terraform.io/providers/turbot/turbot/latest/docs#authentication) for additional authentication methods.

## Usage

### Install Baseline

Clone:

```sh
git clone https://github.com/turbot/guardrails-samples.git
cd guardrails-samples/baselines/aws/aws_mods
```

Run the Terraform to create the policy pack in your workspace:

```sh
terraform init
terraform plan
```

Then apply the changes:

```sh
terraform apply
```
