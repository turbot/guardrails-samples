# ServiceNow-GCP Mods Installation

Turbot provides numerous ServiceNow-GCP mods, covering a wide range of GCP resources with thousands of policies and controls. By default, mods are installed with the top Turbot resource as the parent, meaning administrators must have Turbot/Owner permissions at the Turbot resource level to install, uninstall, or update mods in the environment.

## Documentation

- **[Review Mods Documentation →](https://turbot.com/guardrails/docs/mods)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)
- The following Guardrails mods need to be installed:

  - [@turbot/servicenow](https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow)
  - The corresponding GCP mod for each ServiceNow mod you wish to enable. For example:

    - If using [@turbot/servicenow-gcp-computeengine](https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-gcp-computeengine), ensure [@turbot/gcp-computeengine](https://hub.guardrails.turbot.com/mods/gcp/mods/gcp-computeengine) is installed.
    - If using [@turbot/servicenow-gcp-storage](https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-gcp-storage), ensure [@turbot/gcp-storage](https://hub.guardrails.turbot.com/mods/gcp/mods/gcp-storage) is installed.

### Credentials

To install ServiceNow-GCP mods using Terraform:

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

1. Navigate to the `servicenow_gcp_mods` folder.
2. Run the command:

```sh
terraform init
```

### Install

After initializing Terraform, you can apply the mods in one of two ways, depending on your needs:

#### 1. Using an Input Variable File

By default, the `default.tfvars` file is configured to install all the mods necessary for CIS (Center for Internet Security) compliance. You can further customize this file to include additional mods as needed. To apply the mods using this specific input variable file, run the following command:

```sh
terraform apply --var-file=default.tfvars -parallelism=1
```

#### 2. Without an Input Variable File

If you choose not to use an input variable file, the command will install **all** available GCP mods. To proceed with this option, run:

```sh
terraform apply -parallelism=1
```

### Destroy

You can destroy the mods in one of two ways:

#### 1. Using an Input Variable File

Run the following command to destroy the mods using a specific input variable file:

```sh
terraform destroy --var-file=default.tfvars -parallelism=1
```

#### 2. Without an Input Variable File

Run the following command to destroy the mods without using an input variable file:

```sh
terraform destroy -parallelism=1
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
