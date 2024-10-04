---
categories: ["logging", "networking"]
primary_category: "logging"
---

# Prepare to Disconnect AWS Account from Guardrails

The Guardrails Event Poller is an alternative to the Event Handlers, and is a polling mechanism for obtaining relevant events from AWS and updating CMDB.

This [policy pack](https://turbot.com/guardrails/docs/concepts/policy-packs) can help you configure the following settings for AWS Accounts in Guardrails:

- Decommission Guardrails-managed AWS IAM Permissions
- Decommission AWS Event Handlers
- Decommission AWS Global Event Hanlders
- Decommission Guardrails-managed CloudTrail
- Decommission Guardrails-managed S3 Logging Buckets
- Decommission Guardrails-managed IAM Service Roles

**[Review policy settings →](https://hub.guardrails.turbot.com/policy-packs/aws_guardrails_enable_event_poller/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)
- Guardrails mods:
  - [@turbot/aws](https://hub.guardrails.turbot.com/mods/aws/mods/aws)

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
cd guardrails-samples/policy_packs/aws/guardrails/disconnect_aws_account_prep
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
> Please note your Terraform state fi le will then become out of sync and the policy settings should then only be managed in the console.

By default, the policies are set to `Check` in the pack's policy settings. To enable automated enforcements, you can switch these policies settings by adding a comment to the `Check` setting and removing the comment from one of the listed enforcement options:

> [!IMPORTANT]
> Setting the policy in enforce mode will result in creation of resources in the target account. However, it is easy to restore those resources later, by setting the policy settings back to `Enforce: Configured`.
> 
```hcl
# AWS > Turbot > Logging Bucket
resource "turbot_policy_setting" "aws_logging_bucket" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/loggingBucket"
  # value    = "Check: Not configured"
  value    = "Enforce: Not configured"
}

# AWS > Turbot > Service Roles
resource "turbot_policy_setting" "aws_service_roles" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/serviceRoles"
  # value    = "Check: Not configured"
  value    = "Enforce: Not configured"
  note     = "Decommissions the Guardrails-managed Service Roles."
}

# AWS > Turbot > Event Handlers [Global]
resource "turbot_policy_setting" "aws_event_handlers_global" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/eventHandlersGlobal"
  # value    = "Check: Not configured"
  value    = "Enforce: Not configured"
  note     = "Decommissions Global Event Handlers."
}

# AWS > Turbot > Event Handlers
resource "turbot_policy_setting" "aws_event_handlers" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/eventHandlers"
  # value    = "Check: Not configured"
  value    = "Enforce: Not configured"
  note     = "Decommissions AWS Event Handlers."
}

# AWS > Turbot > Audit Trail
resource "turbot_policy_setting" "aws_audit_trail" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/auditTrail"
  #value    = "Check: Not configured"
  value    = "Enforce: Not configured"
  note     = "Decommissions Guardrails-managed CloudTrail trails. "
}

# AWS > IAM > Permissions
resource "turbot_policy_setting" "aws_iam_permissions" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/permissions"
  # value    = "Check: None"
  value    = "Enforce: None"
  note     = "Removes Guardrails-managed IAM users, groups and roles."
}
```

### Disable Event Pollers
After all the Guardrails-managed resources have been successfully decommissioned, the Event Pollers can be disabled.  

```hcl
# AWS > Turbot > Event Poller
resource "turbot_policy_setting" "aws_event_poller" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/eventPoller"
  # value    = "Enabled"
  value    = "Disabled"
  note     = "Set to disabled after all the other resources have been successfully decommissioned. Guardrails needs an event stream for the destroyed resources for proper and complete cleanup.  Event Pollers retrieve those destroy events. "
}
```

