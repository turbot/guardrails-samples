---
categories: ["cis", "compliance", "networking"]
primary_category: "compliance"
---

# GCP CIS v2.0.0 - Section 6 - Cloud SQL Database Services

This section covers security recommendations to follow to secure Cloud SQL database services.

This [policy pack](https://turbot.com/guardrails/docs/concepts/resources/smart-folders) can help you automate the enforcement of GCP CIS benchmark section 6 best practices.

**[Review policy settings →](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/policy-packs/gcp/cis_v200/section6/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/install-cli)
- Guardrails mods:
  - [@turbot/gcp-sql](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/gcp/mods/gcp-sql)

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
cd guardrails-samples/policy_packs/gcp/cis_v200/section6
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

By default, the policies are set to `Check` or `Skip` in the pack's policy settings. To enable automated enforcements, you can switch these policies settings by adding a comment to the `Check`/`Skip` setting and removing the comment from one of the listed enforcement options:

```hcl
resource "turbot_policy_setting" "gcp_sql_instance_database_flags" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-sql#/policy/types/instanceDatabaseFlags"
  note     = "GCP CIS v2.0.0 - Control: 6.1.2, 6.1.3, 6.2.1, 6.2.2, 6.2.3, 6.2.4, 6.2.5, 6.2.6, 6.2.7, 6.2.8, 6.3.1, 6.3.2, 6.3.3, 6.3.4, 6.3.5, 6.3.6 and 6.3.7"
  # value    = "Check: Database flags are correct"
  value    = "Enforce: Set Database flags"
}

resource "turbot_policy_setting" "gcp_sql_instance_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-sql#/policy/types/instanceApproved"
  note     = "GCP CIS v2.0.0 - Control: 6.2.9"
  # value    = "Check: Approved"
  value    = "Enforce: Delete unapproved if new"
}


resource "turbot_policy_setting" "gcp_sql_instance_encryption_in_transit" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-sql#/policy/types/instanceEncryptionInTransit"
  note     = "GCP CIS v2.0.0 - Control: 6.4"
  # value    = "Check: Enabled"
  # value    = "Check: Enabled with trusted client certificate"
  value    = "Enforce: Enabled"
  # value    = "Enforce: Enabled with trusted client certificate"
}

resource "turbot_policy_setting" "gcp_sql_instance_authorized_network_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-sql#/policy/types/instanceAuthorizedNetworkApproved"
  note     = "GCP CIS v2.0.0 - Control: 6.5"
  # value    = "Check: Approved"
  value    = "Enforce: Delete unapproved"
}

resource "turbot_policy_setting" "gcp_sql_instance_data_protection_managed_backups" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-sql#/policy/types/instanceDataProtectionManagedBackups"
  note     = "GCP CIS v2.0.0 - Control: 6.7"
  # value    = "Skip"
  value    = "Enforce: Manage snapshots, per Managed Backups > Schedule and Managed Backups > Minimum Schedule"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```
