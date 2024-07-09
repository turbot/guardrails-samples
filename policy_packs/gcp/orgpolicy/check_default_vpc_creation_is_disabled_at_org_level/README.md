---
categories: ["public cloud"]
---

# Check If Creation of Default VPC Network Is Disabled at the GCP Organization Level

Default VPC Network has a preconfigured network configuration and automatically generates the following insecure firewall rules that allows ingress connection on TCP, SSH, IDP and IPCM. Furthermore, the default network is an auto mode network, which means that its subnets use the same predefined range of IP addresses, and as a result, it's not possible to use Cloud VPN or VPC Network Peering with the default network.

This policy pack can help you configure the following settings for organizations:

- Checks if the project organization policy skips the creation of default network

**[Review policy settings →](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/policy-packs/check_default_vpc_creation_is_disabled_at_org_level/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/install-cli)
- Guardrails mods:
  - [@turbot/gcp-orgpolicy](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/gcp/mods/gcp-orgpolicy)

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
cd guardrails-samples/policy_packs/gcp/orgpolicy/check_default_vpc_creation_is_disabled_at_org_level
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

Log into your Guardrails workspace and [attach the policy pack to a resource](https://turbot.com/guardrails/docs/guides/working-with-folders/smart#attach-a-smart-folder-to-a-resource).

### Enable Enforcement

> [!TIP]
> You can also update the policy settings in this policy pack directly in the Guardrails console.
>
> Please note your Terraform state file will then become out of sync and the policy settings should then only be managed in the console.

By default, the policies are set to `Check` in the pack's policy settings. To enable automated enforcements, you can switch these policies settings by adding a comment to the `Check` setting and removing the comment from one of the listed enforcement options:

```hcl
resource "turbot_policy_setting" "gcp_org_policy_compute_skip_default_network_creation" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-orgpolicy#/policy/types/computeSkipDefaultNetworkCreation"
  value    = "Check: On, effective value"
  # value    = "Check: On, set on project"
  # value    = "Check: On, inherited"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```
