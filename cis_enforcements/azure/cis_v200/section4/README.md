---
categories: ["cis"]
---

# Enforce Azure CIS v2.0.0 - Section 4 - Database Services

This section covers security recommendations to follow to set general database services policies on an Azure Subscription. Subsections will address specific database types.

This policy pack can help you automate enforcement of Azure CIS benchmark section 4 best practices.

**[Review policy settings →](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/policy-packs/azure/cis_v200/section4/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- Guardrails mods:
  - [@turbot/azure-sql](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/azure/mods/azure-sql)
  - [@turbot/azure-mysql](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/azure/mods/azure-mysql)
  - [@turbot/azure-network](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/azure/mods/azure-network)
  - [@turbot/azure-postgresql](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/azure/mods/azure-postgresql)

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
cd guardrails-samples/policy_packs/azure/cis_v200/section4
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
resource "turbot_policy_setting" "azure_sql_server_auditing" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-sql#/policy/types/serverAuditing"
  note     = "Azure CIS v2.0.0 - Control: 4.1.1"
  # value  = "Check: Enabled"
  value    = "Enforce: Enabled"
}

resource "turbot_policy_setting" "azure_network_network_security_group_ingress_rules_approved" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-network#/policy/types/networkSecurityGroupIngressRulesApproved"
  note     = "Azure CIS v2.0.0 - Control: 4.1.2"
  # value  = "Check: Approved"
  value    = "Enforce: Delete unapproved if new"
}

resource "turbot_policy_setting" "azure_sql_database_encryption_at_rest" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-sql#/policy/types/databaseEncryptionAtRest"
  note     = "Azure CIS v2.0.0 - Control: 4.1.5"
  # value  = "Check: Enabled"
  value    = "Enforce: Enabled"
}

resource "turbot_policy_setting" "azure_sql_server_active_directory_administrator" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-sql#/policy/types/serverActiveDirectoryAdministrator"
  note     = "Azure CIS v2.0.0 - Control: 4.1.4"
  # value  = "Check: Enabled to Active Directory Administrator > Name"
  value    = "Enforce: Enabled to Active Directory Administrator > Name"
}

resource "turbot_policy_setting" "azure_sql_server_data_security" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-sql#/policy/types/serverDataSecurity"
  note     = "Azure CIS v2.0.0 - Control: 4.2.1"
  # value  = "Check: Enabled"
  value    = "Enforce: Enabled"
}

resource "turbot_policy_setting" "azure_postgresql_server_encryption_in_transit" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-postgresql#/policy/types/serverEncryptionInTransit"
  note     = "Azure CIS v2.0.0 - Control: 4.3.1"
  # value  = "Check: Enabled"
  value    = "Enforce: Enabled"
}

resource "turbot_policy_setting" "azure_postgresql_flexible_server_encryption_in_transit" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-postgresql#/policy/types/flexibleServerEncryptionInTransit"
  note     = "Azure CIS v2.0.0 - Control: 4.3.1"
  # value  = "Check: Enabled"
  value    = "Enforce: Enabled"
}

resource "turbot_policy_setting" "azure_postgresql_server_audit_logging" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-postgresql#/policy/types/serverAuditLogging"
  note     = "Azure CIS v2.0.0 - Control: 4.3.2"
  # value  = "Check: Audit Logging > *"
  value    = "Enforce: Audit Logging > *"
}

resource "turbot_policy_setting" "azure_postgresql_flexible_server_audit_logging" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-postgresql#/policy/types/flexibleServerAuditLogging"
  note     = "Azure CIS v2.0.0 - Control: 4.3.2"
  # value  = "Check: Audit Logging > *"
  value    = "Enforce: Audit Logging > *"
}

resource "turbot_policy_setting" "azure_postgresql_server_approved" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-postgresql#/policy/types/serverApproved"
  note     = "Azure CIS v2.0.0 - Control: 4.3.7 and 4.3.8"
  # value  = "Check: Approved"
  value    = "Enforce: Delete unapproved if new"
}

resource "turbot_policy_setting" "azure_mysql_server_encryption_in_transit" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-mysql#/policy/types/serverEncryptionInTransit"
  note     = "Azure CIS v2.0.0 - Control: 4.4.1"
  # value  = "Check: Enabled"
  value    = "Enforce: Enabled"
}

resource "turbot_policy_setting" "azure_mysql_flexible_server_encryption_in_transit" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-mysql#/policy/types/flexibleServerEncryptionInTransit"
  note     = "Azure CIS v2.0.0 - Control: 4.4.1"
  # value  = "Check: Enabled"
  value    = "Enforce: Enabled"
}

resource "turbot_policy_setting" "azure_mysql_flexible_server_minimum_tls_version" {
  resource = turbot_smart_folder.main.id
  type     = "tmod:@turbot/azure-mysql#/policy/types/flexibleServerMinimumTlsVersion"
  note     = "Azure CIS v2.0.0 - Control: 4.4.2"
  #value   = "Check: TLS 1.2"
  value    = "Enforce: TLS 1.2"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```
