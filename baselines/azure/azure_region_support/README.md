# Azure Region Support

This smart folder is an example of how to add support for a new region across multiple Azure
region policies in Guardrails.

## Documentation

- **[Review Policies Documentation →](https://hub.guardrails.turbot.com/mods/azure/policies)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)
- [Guardrails Azure mods](../azure_mods/)

### Credentials

To create Azure Region Support policy pack through Terraform:

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

1. Navigate to the `azure_region_support` folder.
2. Run the command:

```sh
terraform init
```

### Install

After initializing Terraform, you can apply the Enabled policies: 

```sh
terraform apply
```

### Destroy 

You can destroy the policy pack if no longer needed:

```sh
terraform destroy
```

### Apply Policy Pack

By default, this Policy Pack is not attached to any part of [Folder Hierarchy](../../guardrails/folder_hierarchy/). If you wish to attach to a resource, then log into your Guardrails workspace and [attach the policy pack to a resource](https://turbot.com/guardrails/docs/guides/policy-packs#attach-a-policy-pack-to-a-resource).

If this policy pack is attached to a Guardrails folder, its policies will be applied to all subscriptions and resources in that folder. The policy pack can also be attached to multiple resources.

For more information, please see [Policy Packs](https://turbot.com/guardrails/docs/concepts/policy-packs).
