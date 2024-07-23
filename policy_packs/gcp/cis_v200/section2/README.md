---
categories: ["cis", "compliance", "logging", "networking"]
primary_category: "compliance"
---

# GCP CIS v2.0.0 - Section 2 - Logging and Monitoring

This section covers recommendations addressing Logging and Monitoring on Google Cloud Platform.

This [policy pack](https://turbot.com/guardrails/docs/concepts/policy-packs) can help you automate the enforcement of GCP CIS benchmark section 2 best practices.

**[Review policy settings →](https://hub.guardrails.turbot.com/policy-packs/gcp_cis_v200_section2/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)
- Guardrails mods:
  - [@turbot/gcp](https://hub.guardrails.turbot.com/mods/gcp/mods/gcp)
  - [@turbot/gcp-dns](https://hub.guardrails.turbot.com/mods/gcp/mods/gcp-dns)
  - [@turbot/gcp-network](https://hub.guardrails.turbot.com/mods/gcp/mods/gcp-network)
  - [@turbot/gcp-storage](https://hub.guardrails.turbot.com/mods/gcp/mods/gcp-storage)

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
cd guardrails-samples/policy_packs/gcp/cis_v200/section2
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
resource "turbot_policy_setting" "gcp_turbot_event_handler_logging" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp#/policy/types/eventHandlersLogging"
  note     = "GCP CIS v2.0.0 - Control: 2.1"
  # value    = "Check: Configured"
  value    = "Enforce: Configured"
}

resource "turbot_policy_setting" "gcp_turbot_event_handler_pubsub" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp#/policy/types/eventHandlersPubSub"
  note     = "GCP CIS v2.0.0 - Control: 2.2"
  # value    = "Check: Configured"
  value    = "Enforce: Configured"
}

resource "turbot_policy_setting" "gcp_storage_bucket_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-storage#/policy/types/bucketApproved"
  note     = "GCP CIS v2.0.0 - Control: 2.3"
  # value    = "Check: Approved"
  value    = "Enforce: Delete unapproved if new"
}

resource "turbot_policy_setting" "gcp_project_stack" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp#/policy/types/projectStack"
  note     = "GCP CIS v2.0.0 - Controls: 2.4, 2.5, 2.6, 2.7, 2.8, 2.9, 2.10 and 2.11"
  # value    = "Check: Configured"
  value    = "Enforce: Configured"
}

resource "turbot_policy_setting" "gcp_dns_dns_policy_logging" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-dns#/policy/types/dnsPolicyLogging"
  note     = "GCP CIS v2.0.0 - Control: 2.12"
  # value    = "Check: Enabled"
  value    = "Enforce: Enabled"
}

resource "turbot_policy_setting" "gcp_network_backend_service_logging" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-network#/policy/types/backendServiceLogging"
  note     = "GCP CIS v2.0.0 - Control: 2.16"
  # value    = "Check: Enabled"
  value    = "Enforce: Enabled"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```
