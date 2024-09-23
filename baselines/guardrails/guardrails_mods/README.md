# Guardrails Mods Installation

Turbot Guardrails provides a set of mods that enforce best practices, security controls, and compliance frameworks across your cloud environment. This README guides you through the process of installing Guardrails mods using Terraform. The example provided installs the CIS (Center for Internet Security) mod, which is designed to help you achieve and maintain CIS compliance across your resources.

## Documentation

- **[Review Guardrails Mods Documentation →](https://hub.guardrails.turbot.com/mods/turbot/mods/cis)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)

### Credentials

To install Guardrails mods using Terraform:

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

1. Navigate to the `guardrails_mods` folder.
2. Run the command:

```sh
terraform init
```

### Install

After initializing Terraform, you can apply the Guardrails mod:

#### 1. Using an Input Variable File (If Applicable)

If you have customized a `default.tfvars` file with specific parameters for the CIS mod or additional mods, you can apply the configuration as follows:

```sh
terraform apply --var-file=default.tfvars -parallelism=1
```

#### 2. Without an Input Variable File

To install the guardrails mods mod without using an input variable file, run:

```sh
terraform apply -parallelism=1
```

### Destroy

You can remove the Guardrails mod in one of two ways:

#### 1. Using an Input Variable File

Run the following command to destroy the Guardrails mod configuration using a specific input variable file:

```sh
terraform destroy --var-file=default.tfvars -parallelism=1
```

#### 2. Without an Input Variable File

Run the following command to destroy the Guardrails mod configuration without using an input variable file:

```sh
terraform destroy -parallelism=1
```

## Overview of Guardrails Mods Configuration

This setup installs the CIS mod within your Turbot Guardrails environment:

### 1. CIS Mod Installation

- **Mod**: `turbot_mod.cis`
- **Description**: This mod applies CIS (Center for Internet Security) benchmarks to your cloud resources, ensuring they meet rigorous security and compliance standards.
- **Version**: `>=5.0.0`

This mod helps you automate compliance with the CIS benchmarks, providing continuous monitoring and enforcement across your AWS environment.

## Commenting Strategy

All Turbot policies and mods include links to the official Turbot Mods documentation.

These links provide further details about:

- The purpose of the policy or mod
- Policy URI name or Mod details
- Parent information
- Category information
- Target information
- All valid values
