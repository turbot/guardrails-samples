---
categories: ["compute", "security"]
primary_category: "security"
type: "featured"
---

# Enforce Azure Compute Virtual Machines to Use Approved AMIs from Trusted Publishers

Enforcing Azure compute instances to use approved AMIs from trusted publishers is vital for maintaining a secure and standardized environment. This practice ensures that only trusted, validated images are used, reducing the risk of security vulnerabilities and ensuring compliance with organizational policies and security standards.

This [policy pack](https://turbot.com/guardrails/docs/concepts/resources/policy-packs) can help you configure the following settings for Compute virtual machines:

- Stop/Terminate VMs that do not use approved AMIs from trusted publishers
- Set the image IDs that are approved for use

## Documentation

- **[Review policy settings →](https://hub.guardrails.turbot.com/policy-packs/azure_compute_enforce_approved_images_from_trusted_publishers_for_vms/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)
- Guardrails mods:
  - [@turbot/azure-compute](https://hub.guardrails.turbot.com/mods/azure/mods/azure-compute)

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

### Install Policy Pack

> [!NOTE]
> By default, installed policy packs are not attached to any resources.
>
> Policy packs must be attached to resources in order for their policy settings to take effect.

Clone:

```sh
git clone https://github.com/turbot/guardrails-samples.git
cd guardrails-samples/policy_packs/azure/compute/enforce_approved_amis_publishers_for_vms
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

### Apply Policy Pack

Log into your Guardrails workspace and [attach the policy pack to a resource](https://turbot.com/guardrails/docs/guides/policy-packs#attach-a-policy-pack-to-a-resource).

If this policy pack is attached to a Guardrails folder, its policies will be applied to all accounts and resources in that folder. The policy pack can also be attached to multiple resources.

For more information, please see [Policy Packs](https://turbot.com/guardrails/docs/concepts/resources/policy-packs).

### Enable Enforcement

> [!TIP]
> You can also update the policy settings in this policy pack directly in the Guardrails console.
>
> Please note your Terraform state file will then become out of sync and the policy settings should then only be managed in the console.

By default, the policies are set to `Check` in the pack's policy settings. To enable automated enforcements, you can switch these policies settings by adding a comment to the `Check` setting and removing the comment from one of the listed enforcement options:

```hcl
resource "turbot_policy_setting" "azure_compute_virtual_machine_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-compute#/policy/types/virtualMachineApproved"
  # value    = "Check: Approved"
  value    = "Enforce: Stop unapproved"
  # value    = "Enforce: Delete unapproved if new"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```
