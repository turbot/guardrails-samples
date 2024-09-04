---
categories: ["cis", "compliance", "networking"]
primary_category: "compliance"
---

# GCP CIS v2.0.0 - Section 3 - Networking

This section covers recommendations addressing networking on Google Cloud Platform.

This [policy pack](https://turbot.com/guardrails/docs/concepts/policy-packs) can help you automate the enforcement of GCP CIS benchmark section 3 best practices.

**[Review policy settings →](https://hub.guardrails.turbot.com/policy-packs/gcp_cis_v200_section3/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)
- Guardrails mods:
  - [@turbot/gcp-dns](https://hub.guardrails.turbot.com/mods/gcp/mods/gcp-dns)
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
cd guardrails-samples/policy_packs/gcp/cis_v200/section3
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
resource "turbot_policy_setting" "gcp_network_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-network#/policy/types/networkApproved"
  note     = "GCP CIS v2.0.0 - Control: 3.1 and 3.2"
  # value    = "Check: Approved"
  value    = "Enforce: Delete unapproved if new"
}

resource "turbot_policy_setting" "gcp_dns_managed_zone_dnssec_configuration" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-dns#/policy/types/managedZoneDnssecConfiguration"
  note     = "GCP CIS v2.0.0 - Control: 3.3"
  # value    = "Check: Enabled"
  value    = "Enforce: Enabled"
}

resource "turbot_policy_setting" "gcp_dns_managed_zone_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-dns#/policy/types/managedZoneApproved"
  note     = "GCP CIS v2.0.0 - Control: 3.4 and 3.5"
  # value    = "Check: Approved"
  value    = "Enforce: Delete unapproved if new"
}

resource "turbot_policy_setting" "gcp_network_firewall_ingress_rules_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-network#/policy/types/firewallIngressRulesApproved"
  note     = "GCP CIS v2.0.0 - Control: 3.6 and 3.7"
  # value    = "Check: Approved"
  value    = "Enforce: Delete unapproved"
}

resource "turbot_policy_setting" "gcp_network_subnetwork_flow_log" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-network#/policy/types/subnetworkFlowLog"
  note     = "GCP CIS v2.0.0 - Control: 3.8"
  # value    = "Check: Enabled"
  value    = "Enforce: Enabled"
}

resource "turbot_policy_setting" "gcp_network_ssl_policy_minimum_tls_version" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-network#/policy/types/sslPolicyMinimumTlsVersion"
  note     = "GCP CIS v2.0.0 - Control: 3.9"
  # value    = "Check: TLS 1.2"
  value    = "Enforce: TLS 1.2"
}

resource "turbot_policy_setting" "gcp_network_ssl_policy_profile" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-network#/policy/types/sslPolicyProfile"
  note     = "GCP CIS v2.0.0 - Control: 3.9"
  # value    = "Check: Restricted"
  value    = "Enforce: Restricted"
}

resource "turbot_policy_setting" "gcp_network_firewall_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-network#/policy/types/firewallApproved"
  note     = "GCP CIS v2.0.0 - Control: 3.10"
  # value    = "Check: Approved"
  value    = "Enforce: Delete unapproved if new"
}

```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```
