---
categories: ["networking", "security"]
primary_category: "networking"
---

# Enforce Network Firewall Rules with Port Ranges to Not Allow Incoming Traffic

Ensure that your Google Cloud VPC network firewall rules don't have range of ports configured to allow inbound traffic, in order to protect associated virtual machine instances against Denial-of-Service (DoS) attacks or brute-force attacks. To follow cloud security best practices, it is strongly recommended to open only specific ports within your firewall rules, based on your application requirements.

This [policy pack](https://turbot.com/guardrails/docs/concepts/resources/smart-folders) can help you configure the following settings for Network firewalls:

- Revoke firewall rules that allow incoming traffic from all IP addresses
- Revoke firewall rules that have port range size of greater than 1

**[Review policy settings →](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/policy-packs/enforce_firewall_rules_with_port_ranges_to_not_allow_incoming_traffic/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/install-cli)
- Guardrails mods:
  - [@turbot/gcp-network](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/gcp/mods/gcp-network)

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
cd guardrails-samples/policy_packs/gcp/network/enforce_firewall_rules_with_port_ranges_to_not_allow_incoming_traffic
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

If this policy pack is attached to a Guardrails folder, its policies will be applied to all accounts and resources in that folder. The policy pack can also be attached to multiple resources.

For more information, please see [Policy Packs](https://turbot.com/guardrails/docs/concepts/resources/smart-folders).

### Enable Enforcement

> [!TIP]
> You can also update the policy settings in this policy pack directly in the Guardrails console.
>
> Please note your Terraform state file will then become out of sync and the policy settings should then only be managed in the console.

By default, the policies are set to `Check` in the pack's policy settings. To enable automated enforcements, you can switch these policies settings by adding a comment to the `Check` setting and removing the comment from one of the listed enforcement options:

```hcl
resource "turbot_policy_setting" "gcp_network_firewall_ingress_rules_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-network#/policy/types/firewallIngressRulesApproved"
  # value    = "Check: Approved"
  value  = "Enforce: Delete unapproved"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```
