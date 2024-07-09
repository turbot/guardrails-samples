---
categories: ["cis"]
---

# Enforce GCP CIS v2.0.0 - Section 4 - Virtual Machines

This section covers recommendations addressing virtual machines on Google Cloud Platform.

This policy pack can help you automate enforcement of GCP CIS benchmark section 4 best practices.

**[Review policy settings →](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/policy-packs/gcp/cis_v200/section4/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/install-cli)
- Guardrails mods:
  - [@turbot/gcp-computeengine](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/gcp/mods/gcp-computeengine)

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
> Clone:

```sh
git clone https://github.com/turbot/guardrails-samples.git
cd guardrails-samples/policy_packs/gcp/cis_v200/section4
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
> By default, the policies are set to `Check` in the pack's policy settings. To enable automated enforcements, you can switch these policies settings by adding a comment to the `Check` setting and removing the comment from one of the listed enforcement options:

```hcl
resource "turbot_policy_setting" "gcp_computeengine_instance_block_project_wide_ssh_keys" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/instanceBlockProjectWideSshKeys"
  note     = "GCP CIS v2.0.0 - Control: 4.3"
  # value    = "Check: Enabled"
  value    = "Enforce: Enabled"
}

resource "turbot_policy_setting" "gcp_computeengine_project_os_login_enabled" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/osLoginEnabled"
  note     = "GCP CIS v2.0.0 - Control: 4.4"
  # value    = "Check: Enabled"
  value    = "Enforce: Enabled"
}

resource "turbot_policy_setting" "gcp_computeengine_instance_serial_port_access" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/instanceSerialPortAccess"
  note     = "GCP CIS v2.0.0 - Control: 4.5"
  # value    = "Check: Disabled"
  value    = "Enforce: Disabled"
}

resource "turbot_policy_setting" "gcp_computeengine_instance_approved" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/instanceApproved"
  note     = "GCP CIS v2.0.0 - Control: 4.1, 4.2, 4.6, 4.11"
  # value    = "Check: Approved"
  value    = "Enforce: Delete unapproved if new"
  # value    = "Enforce: Stop unapproved if new"
  # value    = "Enforce: Stop unapproved"
}

resource "turbot_policy_setting" "gcp_computeengine_instance_approved_ip_forwarding" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/instanceApprovedIpForwarding"
  note     = "GCP CIS v2.0.0 - Control: 4.6"
  value    = "Approved if disabled"
}

resource "turbot_policy_setting" "gcp_computeengine_disk_approved" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/diskApproved"
  note     = "GCP CIS v2.0.0 - Control: 4.7"
  # value    = "Check: Approved"
  value    = "Enforce: Delete unapproved if new"
}

resource "turbot_policy_setting" "gcp_computeengine_instance_shielded_vm_enabled" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/shieldedVMEnabled"
  note     = "GCP CIS v2.0.0 - Control: 4.8"
  # value    = "Check: Enabled"
  value    = "Enforce: Enabled"
}

resource "turbot_policy_setting" "gcp_computeengine_instance_external_ip_addresses" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/instanceExternalIpAddresses"
  note     = "GCP CIS v2.0.0 - Control: 4.9"
  # value    = "Check: None"
  value    = "Enforce: None"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```
