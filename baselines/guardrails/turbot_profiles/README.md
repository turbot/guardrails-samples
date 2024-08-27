# Turbot Directory Installation

This script sets up a new Turbot.com directory within Turbot Guardrails and adds additional profiles with `Turbot/Owner` permissions at the root level. This allows designated users to have full administrative access to the Turbot environment through the new SAML-integrated directory.

## Documentation

- **[Review Turbot Directory Documentation →](https://turbot.com/guardrails/docs/guides/directories/local#create-a-turbot-directory)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)

### Credentials

To create a Turbot.com directory and configure profiles using Terraform:

- Ensure you have `Turbot/Owner` permissions in Guardrails.
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

1. Navigate to the `turbot_directory` folder.
2. Run the command:

```sh
terraform init
```

### Install

After initializing Terraform, you can apply the configuration to set up the Turbot directory and profiles:

The `default.tfvars` file should be customized with the list of profiles to be created. Apply the configuration as follows:

```sh
terraform apply --var-file=default.tfvars
```

### Destroy

You can remove the Turbot directory and profiles setup in one of two ways:

Run the following command to destroy the Turbot directory configuration using a specific input variable file:

```sh
terraform destroy --var-file=default.tfvars
```

## Overview of Turbot Directory Configuration

This setup creates a new Turbot.com directory and configures profiles with `Turbot/Owner` permissions:

### 1. Directory Creation

- **Directory**: The script creates a new Turbot.com directory for SAML authentication. This allows users to log in to Turbot workspaces through the new directory.

### 2. Profile Creation

- **Profiles**: Profiles are created based on the entries in the `default.tfvars` file. Each profile is configured with:
  - **Name**: Full name of the user (e.g., "First Last").
  - **Email**: The email address associated with the Turbot.com account.

### 3. Permissions

- **Turbot/Owner Role**: Each profile is granted `Turbot/Owner` permissions, providing full administrative access to the Turbot environment.
- **Grant Activation**: The owner grants are activated for each profile, ensuring they have the necessary permissions to manage the Turbot environment.

## Example `default.tfvars` Configuration

Here's an example configuration in the `default.tfvars` file:

```hcl
user_profile = {
  "profileId1" = { name = "First Last", email = "email@email.com" },
  "profileId2" = { name = "First Last", email = "email@email.com" },
  "profileId3" = { name = "First Last", email = "email@email.com" }
}
```

Update this file with the list of profiles to be added.
