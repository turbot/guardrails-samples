---
categories: ["networking", "security"]
primary_category: "networking"
---

# Check If OCI Networking Security Lists Reject SSH and RDP Inbound Access From the Internet

Security lists that allow ingress from `0.0.0.0/0` or `::/0` to port 22 (SSH) or port 3389 (RDP) expose remote administration to the whole internet. This is a common path for brute force and remote access attacks, and the CIS OCI Foundations Benchmark recommends against it. This pack alarms on any security list with a stateful or stateless ingress rule from the internet that covers port 22 or 3389 over TCP, UDP, or all protocols.

This [policy pack](https://turbot.com/guardrails/docs/concepts/policy-packs) can help you configure the following settings for networking security lists:

- Check and alarm if a security list allows SSH (22) or RDP (3389) ingress from `0.0.0.0/0` or `::/0`

**[Review policy settings →](https://hub.guardrails.turbot.com/policy-packs/oci_networking_check_security_lists_reject_ssh_and_rdp_inbound_access_from_internet/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)
- Guardrails mods:
  - [@turbot/oci-networking](https://hub.guardrails.turbot.com/mods/oci/mods/oci-networking)

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
cd guardrails-samples/policy_packs/oci/networking/check_security_lists_reject_ssh_and_rdp_inbound_access_from_internet
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
