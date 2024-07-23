---
categories: ["cis", "compliance", "security"]
primary_category: "compliance"
---

# Azure CIS v2.0.0 - Section 2 - Microsoft Defender

This section covers recommendations to consider for tenant-wide security policies and plans related to Microsoft Defender. Please note that because Microsoft Defender products require additional licensing.

Microsoft Defender products addressed in this section include:

- Microsoft Defender for Cloud
- Microsoft Defender for IoT
- Microsoft Defender External Attack Surface Management

This [policy pack](https://turbot.com/guardrails/docs/concepts/resources/policy-packs) can help you automate the enforcement of Azure CIS benchmark section 2 best practices.

**[Review policy settings →](https://hub.guardrails.turbot.com/policy-packs/azure_cis_v200_section2/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)
- Guardrails mods:
  - [@turbot/azure-securitycenter](https://hub.guardrails.turbot.com/mods/azure/mods/azure-securitycenter)

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
cd guardrails-samples/policy_packs/azure/cis_v200/section2
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
resource "turbot_policy_setting" "azure_securitycenter_defender_plan" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-securitycenter#/policy/types/securityCenterDefenderPlan"
  note     = "Azure CIS v2.0.0 - Controls: 2.1.1, 2.1.2, 2.1.3, 2.1.4, 2.1.5, 2.1.6, 2.1.7, 2.1.8, 2.1.9, 2.1.10, 2.1.11 and 2.1.12"
  # value    = "Check: Defender Plan Enabled"
  value    = "Enforce: Defender Plan Enabled"
}

resource "turbot_policy_setting" "azure_securitycenter_auto_provisioning" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-securitycenter#/policy/types/securityCenterAutoProvisioning"
  note     = "Azure CIS v2.0.0 - Control: 2.1.15"
  # value    = "Check: Enabled"
  value    = "Enforce: Enabled"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```
