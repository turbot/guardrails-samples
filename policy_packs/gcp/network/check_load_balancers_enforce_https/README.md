---
categories: ["networking", "security"]
primary_category: "networking"
---

# Check GCP Network Load Balancers Enforce HTTPS for Encrypted Web Traffic

Ensure that GCP Network Load Balancers are configured to use valid SSL/TLS certificates in order to handle encrypted web traffic. SSL certificate resources contain SSL certificate information that the load balancer uses to terminate SSL/TLS when HTTPS clients connect to it. This practice guarantees that data transmitted between clients and load-balanced applications is encrypted, protecting it from interception and unauthorized access, thereby enhancing security and compliance with regulatory requirements and best practices.

This [policy pack](https://turbot.com/guardrails/docs/concepts/policy-packs) can help you configure the following settings for network load balancers:

- Check and alarm if the URL map for load balancers is configured to use target https proxy

**[Review policy settings →](https://hub.guardrails.turbot.com/policy-packs/gcp_network_check_load_balancers_enforce_https/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)
- Guardrails mods:
  - [@turbot/gcp-network](https://hub.guardrails.turbot.com/mods/gcp/mods/gcp-network)

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
cd guardrails-samples/policy_packs/gcp/network/check_https_is_enforced_for_load_balancers
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
