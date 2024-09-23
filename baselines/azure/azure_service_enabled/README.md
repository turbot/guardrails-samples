# Azure Service Enabled Policies

The Azure Baseline Policies provide a minimal set of example policies and services to get started with Microsoft Azure in Turbot Guardrails. These policies focus on enabling essential services and APIs.

## Documentation

- **[Review Policies Documentation →](https://hub.guardrails.turbot.com/mods/azure/policies)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)
- [Guardrails Azure mods](../azure_mods/)

### Credentials

To create Azure Service Enabled Baseline policy pack through Terraform:

- Ensure you have `Turbot/Admin` permissions (or higher) in Guardrails.
- [Create access keys](https://turbot.com/guardrails/docs/guides/iam/access-keys#generate-a-new-guardrails-api-access-key) in Guardrails.

And then set your credentials:

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

### Install

After initializing Terraform, you can apply the Enabled policies in one of two ways, depending on your needs:

#### 1. Using an Input Variable File

By default, the `default.tfvars` file is configured to install all the Enabled policies for the mods necessary for CIS (Center for Internet Security) compliance. You can further customize this file to include additional services as needed provided the mods are installed prior. To apply the Enabled policies using this specific input variable file, run the following command:

```sh
terraform apply --var-file=default.tfvars 
```

#### 2. Without an Input Variable File

If you choose not to use an input variable file, the command will install **all** available Enabled policies. Please ensure, you have installed the necessary mods for this. To proceed with this option, run:

```sh
terraform apply
```

### Destroy 

You can destroy the mods in one of two ways:

#### 1. Using an Input Variable File

Run the following command to destroy the mods using a specific input variable file:

```sh
terraform destroy --var-file=default.tfvars
```

#### 2. Without an Input Variable File

Run the following command to destroy the mods without using an input variable file:

```sh
terraform destroy
```

### Apply Policy Pack

By default, this Policy Pack is attached to the Base Folder created as part of [Folder Hierarchy](../../guardrails/folder_hierarchy/). If you wish to attach to a different resource, then log into your Guardrails workspace and [attach the policy pack to a resource](https://turbot.com/guardrails/docs/guides/policy-packs#attach-a-policy-pack-to-a-resource).

If this policy pack is attached to a Guardrails folder, its policies will be applied to all accounts and resources in that folder. The policy pack can also be attached to multiple resources.

For more information, please see [Policy Packs](https://turbot.com/guardrails/docs/concepts/policy-packs).
