# Baselines

Turbot Baselines provide best-practice configurations and examples for setting Turbot policies. Baselines are implemented with [Terraform](https://www.terraform.io), allowing you to manage and provision Turbot with a repeatable, idempotent, versioned infrastructure-as-code approach.

## Current Baselines

| Baseline                    | Path                                                               | Description                                                                                             |
| --------------------------- | ------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------- |
| Local Directory             | [local_directory](./turbot/local_directory)                        | Create local directory and users in your workspace                                                      |
| AWS Setup                   | [aws_setup](./aws/aws_setup)                                       | Common quickstart setup for AWS - prepare your environment to import an AWS account                     |
| AWS Account Import          | [aws_account_import](./aws/aws_account_import)                     | Import an AWS Account into Turbot                                                                       |
| AWS Services                | [aws_services](./aws/aws_services)                                 | Enable/Disable AWS Services in Turbot                                                                   |
| GCP Setup                   | [gcp_setup](./gcp/gcp_setup)                                       | Common quickstart setup for GCP - prepare your environment to import GCP Projects                       |
| GCP Services                | [gcp_services](./gcp/gcp_services)                                 | Enable/Disable GCP Services in Turbot & also enforce api enabled policy based on service Enable/Disable |
| Azure Subscription Import   | [azure_sub_import](./azure/azure_sub_import)                       | Import an Azure subscription into Turbot                                                                |
| Azure Subscription Readonly | [azure_sub_import_ro](./azure/azure_sub_create_then_import_ro)     | Import an Azure subscription into Turbot with event handler and readonly mode                           |
| Azure Services              | [azure_services](./azure/azure_services)                           | Enable/Disable Azure Services in Turbot                                                                 |
| Azure Provider Registration | [azure_provider_registration](./azure/azure_provider_registration) | Set the policy for Azure provider registration                                                          |

## Pre-requisites

To run Turbot baselines, you must install:

- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://turbot.com/v5/docs/reference/terraform/provider)

Additionally, You must set your config.tf or environment variables to connect to your Turbot workspace, as detail in the Turbot Terraform Provider [Installation Instructions](https://turbot.com/v5/docs/reference/terraform/provider)

## Running a baseline

To run a baseline:

1. Install and configure the [pre-requisites](#pre-requisites)
1. At the command line, go to the directory for the baseline, for example: `cd mod_install`
1. Run `terraform init` to initialize terraform in the directory
1. Edit any variables in the .tf file that you wish to change, or override with [environment variables](https://www.terraform.io/docs/commands/environment-variables.html) or [variable files](https://www.terraform.io/docs/configuration/variables.html#variable-definitions-tfvars-files)
1. Run `terraform plan -var-file="<fileName>.tfvars"` and inspect the changes
1. Run `terraform apply -var-file="<fileName>.tfvars"` to apply the configuration

## Contributing

### Structure

Baselines are implemented as independently deployable terraform configurations in a sub-directory of this repository.

Commonly changed parameters are implemented using variables. All variables have default values, but they may not be the settings that you want, you may change them as required.

The baseline mods contain an individual `README.md` file and follows a specified file structure containing the parameters and configurations. Each baseline mod contains:

- `Variables.tf` containing the variable definitions

- `main.tf` containing the terraform resources that creates the objects

- `outputs.tf` containing the return values defined. The file should be optionally created when there is an output block included in the configuration

- `default.tfvars` containing the defaults for the variables

```
Baseline
.
├── README.md
├── main.tf
├── variables.tf
├── outputs.tf
└── default.tfvar
```

### Style Guide

Our baselines adopts styling conventions provided by [Terraform](https://www.terraform.io/docs/configuration/style.html) like:

- Align the equal to signs for arguments appearing on consecutive lines with values.
- Variables should use snake case: `this_is_an_example`
- Use empty lines to separate logical groups of arguments within a block.

To maintain consistency between files and modules, we recommend adopting the below added styling conventions:

- For each baseline, include the variable definitions in the variables.tf file, the resources in main.tf file, and the output in outputs.tf file.
- For `turbot_policy_setting` and `turbot_policy_value` resources , include the policy type hierarchy in a comment before the resource. For example:

  ```terraform
  # AWS > Account > Turbot IAM Role > External ID
  resource "turbot_policy_setting" "turbotIamRoleExternalId" {
    resource    = turbot_resource.account_resource.id
    type        = "tmod:@turbot/aws#/policy/types/turbotIamRoleExternalId"
    value       = var.turbot_external_id
  }
  ```

- Use a single hash for comments that refer only to a single resource, immediately before the resource, for example:

  ```terraform
  # 1.4 Ensure access keys are rotated every 90 days or less (Scored)
  # AWS > IAM > Access Key > Active > Age
  # Setting value to "Force inactive if age > 90" days to meet remediation
  resource "turbot_policy_setting" "AWS_IAM_AccessKey_Active_Age" {
    resource    = var.target_resource
    type        = "tmod:@turbot/aws-iam#/policy/types/accessKeyActiveAge"
    value       = "Force inactive if age > 90 days"
  }
  ```

- Use 4 hashes for comments that describe a group of resources, or general behavior:

  ```terraform
  #### Set the credentials (Role, external id) for the account via Turbot policies
  ```

- All variables should have a description, and as a result should not require individual comments
- Most variables should have a reasonable default
- Where baselines apply policies, they generally should use a variable for the target resource

  - it should be called target_resource
  - it should default to "tmod:@turbot/turbot#/"
  - it should have a comment that states that it may be changes or overridden

  ```terraform
  variable "target_resource" {
      type    = "string"
      description = "Enter the target resource id or aka"
      default = "tmod:@turbot/turbot#/" # You may change/override this value to the id of target folder or resource
  }
  ```
