---
categories: ["cis"]
---

# Azure CIS v2.0.0 - Section 9 - App Service

This section covers security recommendations for Azure App Service.

This policy pack can help you automate the enforcement of Azure CIS benchmark section 9 best practices.

**[Review policy settings →](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/policy-packs/azure/cis_v200/section9/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- Guardrails mods:
  - [@turbot/azure-appservice](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/azure/mods/azure-appservice)

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
cd guardrails-samples/policy_packs/azure/cis_v200/section9
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
resource "turbot_policy_setting" "azure_appservice_webapp_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-appservice#/policy/types/webAppApproved"
  note     = "Azure CIS v2.0.0 - Control: 9.1, 9.6, 9,7 and 9.8"
  # value    = "Check: Approved"
  value    = "Enforce: Delete unapproved if new"
}

resource "turbot_policy_setting" "azure_appservice_web_app_https_only" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-appservice#/policy/types/webAppHttpsOnly"
  note     = "Azure CIS v2.0.0 - Control: 9.2"
  # value    = "Check: Enabled"
  value    = "Enforce: Enabled"
}

resource "turbot_policy_setting" "azure_appservice_web_app_minimum_tls_version" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-appservice#/policy/types/webAppMinimumTlsVersion"
  note     = "Azure CIS v2.0.0 - Control: 9.3"
  # value    = "Check: TLS 1.2"
  value    = "Enforce: TLS 1.2"
}

resource "turbot_policy_setting" "azure_appservice_web_app_client_cert_mode" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-appservice#/policy/types/webAppClientCertMode"
  note     = "Azure CIS v2.0.0 - Control: 9.4"
  # value    = "Check: Require"
  value    = "Enforce: Require"
}

resource "turbot_policy_setting" "azure_appservice_web_app_system_assigned_identity" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-appservice#/policy/types/webAppSystemAssignedIdentity"
  note     = "Azure CIS v2.0.0 - Control: 9.5"
  # value    = "Check: Enabled"
  value    = "Enforce: Enabled"
}

resource "turbot_policy_setting" "azure_appservice_web_app_http20_enabled" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-appservice#/policy/types/webAppHttp20Enabled"
  note     = "Azure CIS v2.0.0 - Control: 9.9"
  # value    = "Check: Enabled"
  value    = "Enforce: Enabled"
}

resource "turbot_policy_setting" "azure_appservice_web_app_ftps_state" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/azure-appservice#/policy/types/webAppFtpsState"
  note     = "Azure CIS v2.0.0 - Control: 9.10"
  # value    = "Check: FTPS only"
  value    = "Enforce: FTPS only"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```
