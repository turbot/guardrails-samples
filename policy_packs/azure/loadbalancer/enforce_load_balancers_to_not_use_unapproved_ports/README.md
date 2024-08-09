---
categories: ["networking", "security"]
primary_category: "networking"
---

# Enforce Azure Load Balancer to Use Only Approved Ports

Enforcing that Azure Load Balancers do not use unapproved ports is essential for maintaining a secure network environment. This measure ensures that only approved and necessary ports are used, reducing the risk of unauthorized access and potential attacks, and enhancing overall security and compliance with best practices and regulatory requirements.

This [policy pack](https://turbot.com/guardrails/docs/concepts/policy-packs) can help you configure the following settings for load balancers:

- Set a list of unapproved ports
- Delete load balancers that use unapproved ports

## Documentation

- **[Review policy settings →](https://hub.guardrails.turbot.com/policy-packs/azure_loadbalancer_enforce_load_balancers_to_not_use_unapproved_ports/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)
- Guardrails mods:
  - [@turbot/azure-loadbalancer](https://hub.guardrails.turbot.com/mods/azure/mods/azure-loadbalancer)

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
cd guardrails-samples/policy_packs/azure/loadbalancer/enforce_load_balancers_to_not_use_unapproved_ports
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

For more information, please see [Policy Packs](https://turbot.com/guardrails/docs/concepts/policy-packs).

### Enable Enforcement

> [!TIP]
> You can also update the policy settings in this policy pack directly in the Guardrails console.
>
> Please note your Terraform state file will then become out of sync and the policy settings should then only be managed in the console.

By default, the policies are set to `Check` in the pack's policy settings. To enable automated enforcements, you can switch these policies settings by adding a comment to the `Check` setting and removing the comment from one of the listed enforcement options:

```hcl
resource "turbot_policy_setting" "azure_loadbalancerservice_loadbalancer_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-loadbalancer#/policy/types/loadBalancerApproved"
  # value    = "Check: Approved"
  value    = "Enforce: Delete unapproved if new"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```
