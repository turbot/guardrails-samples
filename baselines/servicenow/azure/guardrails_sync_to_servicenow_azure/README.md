# Guardrails Sync to ServiceNow [Azure]

This Terraform module enables **ServiceNow Table, Configuration Item, and Relationship Policies** for selected Azure Guardrails mods. It allows users to configure **Guardrails sync to ServiceNow** dynamically based on the installed mods and selected resource types.

## Documentation

- **[Review Policies Documentation →](https://hub.guardrails.turbot.com/mods/servicenow/mods?q=azure)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)
- The following Guardrails mods need to be installed:

  - [@turbot/servicenow](https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow)
  - The corresponding Azure mod for each ServiceNow mod you wish to enable. For example:

    - If using [@turbot/servicenow-azure-compute](https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-azure-compute), ensure [@turbot/azure-compute](https://hub.guardrails.turbot.com/mods/azure/mods/azure-compute) is installed.
    - If using [@turbot/servicenow-azure-storage](https://hub.guardrails.turbot.com/mods/servicenow/mods/servicenow-azure-storage), ensure [@turbot/azure-storage](https://hub.guardrails.turbot.com/mods/azure/mods/azure-storage) is installed.

### Credentials

To create **Guardrails Sync to ServiceNow** policy pack through Terraform:

- Ensure you have `Turbot/Admin` permissions (or higher) in Guardrails.
- [Create access keys](https://turbot.com/guardrails/docs/guides/iam/access-keys#generate-a-new-guardrails-api-access-key) in Guardrails.

Set your credentials:

```sh
export TURBOT_WORKSPACE=myworkspace.acme.com
export TURBOT_ACCESS_KEY=acce6ac5-access-key-here
export TURBOT_SECRET_KEY=a8af61ec-secret-key-here
```

Please see [Turbot Guardrails Provider authentication](https://registry.terraform.io/providers/turbot/turbot/latest/docs#authentication) for additional authentication methods.

## Usage

### Install Policy Pack

> [!NOTE]
> By default, installed policy packs are not attached to any resources.
>
> Policy packs must be attached to resources in order for their policy settings to take effect.

1. Navigate to the guardrails_sync_to_servicenow_azure folder.
2. Run the command:

Run the Terraform to create the policy pack in your workspace:

```sh
terraform init
terraform plan
```

Then apply the changes:

```sh
terraform apply
```

### Apply Policy Pack

Log into your Guardrails workspace and [attach the policy pack to a resource](https://turbot.com/guardrails/docs/guides/configuring-guardrails/policy-packs/attach-policy-pack-to-resource).

If this policy pack is attached to a Guardrails folder, its policies will be applied to all accounts and resources in that folder. The policy pack can also be attached to multiple resources.

For more information, please see [Policy Packs](https://turbot.com/guardrails/docs/concepts/policy-packs).
