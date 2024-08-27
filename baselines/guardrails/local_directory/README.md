# Local Directory Installation

This script sets up a local directory "Turbot Support Team Login" within Turbot Guardrails and creates two users: **Guardrails Admin** and **Guardrails Support**. The Guardrails Admin user is granted `Turbot/Owner` permissions, and the Guardrails Support user is granted `Turbot/Operator` permissions. These roles ensure that the necessary administrative and support tasks can be performed within the Turbot environment.

## Documentation

- **[Review Local Directory Documentation →](https://turbot.com/guardrails/docs/guides/directories/local)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)

### Credentials

To create a local directory and users using Terraform:

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

1. Navigate to the `local_directory` folder.
2. Run the command:

```sh
terraform init
```

### Install

After initializing Terraform, you can apply the configuration to set up the local directory and users:

```sh
terraform apply
```

### Destroy

You can remove the local directory setup in one of two ways:

```sh
terraform destroy
```

## Overview of Local Directory Configuration

This setup creates a local directory within Turbot Guardrails and adds two users with distinct roles:

### 1. Guardrails Admin

- **User Details**:
  - Email: `admin@turbot.com`
  - Role: Guardrails Admin
- **Permissions**: Granted `Turbot/Owner` permissions, enabling full control over the Turbot environment.

### 2. Guardrails Support

- **User Details**:
  - Email: `support@turbot.com`
  - Role: Guardrails Support
- **Permissions**: Granted `Turbot/Operator` permissions, allowing for operational tasks within the Turbot environment.

This structure ensures that both administrative and support functions are covered with appropriate access levels.
