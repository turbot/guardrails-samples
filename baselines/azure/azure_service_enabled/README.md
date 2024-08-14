# Azure Service Enabled Policies

The Azure Baseline Policies provide a minimal set of example policies and services to get started with Azure in Turbot Guardrails. These policies focus on enabling essential services and APIs.

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)

### Credentials

To install Azure mods using Terraform:

- Ensure you have `Turbot/Owner` permissions (or higher) in Guardrails.
- [Create access keys](https://turbot.com/guardrails/docs/guides/iam/access-keys#generate-a-new-guardrails-api-access-key) in Guardrails.

Then set your credentials:

```sh
export TURBOT_WORKSPACE=myworkspace.acme.com
export TURBOT_ACCESS_KEY=acce6ac5-access-key-here
export TURBOT_SECRET_KEY=a8af61ec-secret-key-here
```

Please see [Turbot Guardrails Provider authentication](https://registry.terraform.io/providers/turbot/turbot/latest/docs#authentication) for additional authentication methods.

## Usage

### Initialize Terraform

1. Navigate to the `azure_service_enabled` folder.
2. Run the command:

   ```sh
   terraform init
   ```

### Deploying Default Example

1. Navigate to the `azure_service_enabled` folder.
2. Initialize Terraform.
3. Apply the installation using the default input variable file [default.tfvars](default.tfvars).

On the terminal, this will look like:

```sh
cd <mod_install_folder>
terraform init
terraform apply --var-file=default.tfvars
```

### Input Variable Files

Input variable files allow users to configure settings for multiple environments in different files.

This script comes with an example input variable file called [default.tfvars](default.tfvars).

The variables that can be overridden by the input variable files (e.g., [default.tfvars](default.tfvars)) are defined in the [variables.tf](variables.tf) file.

For more details, see the official [Terraform documentation](https://www.terraform.io/docs/language/values/variables.html).

### Apply Installation Using Input Variable Files

If you want to apply the installation using an input variable file, such as [default.tfvars](default.tfvars):

1. Navigate to the folder containing the installation configuration.
2. Run the command:

   ```sh
   terraform apply --var-file=default.tfvars
   ```

### Apply Installation Without Input Variable File

The installation can also be applied without an input variable file.

1. Ensure Terraform initialization is done as mentioned above.
2. Optionally, check the outcome by running `terraform plan`.
3. Apply the Terraform configuration:

   ```sh
   cd <mod_install_folder>
   terraform plan
   terraform apply
   ```

### Destroy Installation Without Input Variable File

To destroy the installation without using an input variable file:

1. Navigate to the folder containing the installation configuration.
2. Run the command:

   ```sh
   terraform destroy
   ```

### Destroy Using Input Variable Files

If you want to destroy the installation configuration using an input variable file, such as [default.tfvars](default.tfvars):

1. Navigate to the folder containing the installation configuration.
2. Run the command:

   ```sh
   terraform destroy --var-file=default.tfvars
   ```

## Commenting Strategy

All Turbot policies used in the installation include links to the official Turbot Mods documentation.

These links provide further details about:

- The purpose of the policy
- Policy URI name
- Parent information
- Category information
- Target information
- All valid values
