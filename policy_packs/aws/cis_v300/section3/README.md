---
categories: ["cis", "compliance", "logging", "networking", "security", "storage"]
primary_category: "compliance"
---

# AWS CIS v3.0.0 - Section 3 - Logging

This section contains recommendations for configuring AWS logging features.

This [policy pack](https://turbot.com/guardrails/docs/concepts/resources/smart-folders) can help you automate the enforcement of AWS CIS benchmark section 3 best practices.

**[Review policy settings →](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/policy-packs/aws/cis_v300/section3/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)
- Guardrails mods:
  - [@turbot/aws-cloudtrail](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/aws/mods/aws-cloudtrail)
  - [@turbot/aws-config](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/aws/mods/aws-config)
  - [@turbot/aws-kms](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/aws/mods/aws-kms)
  - [@turbot/aws-s3](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/aws/mods/aws-s3)
  - [@turbot/aws-vpc-core](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/aws/mods/aws-vpc-core)

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
cd guardrails-samples/policy_packs/aws/cis_v300/section3
```

Set the variable values:

```sh
cp section3.tfvars.example section3.tfvars
vi section3.tfvars
```

```hcl
# The alias of the KMS key that encrypts the logs delivered by CloudTrail. To be used for control 3.1.
kms_key_alias = "alias/turbot/default"

# The name of an S3 bucket to which the CloudTrail will deliver the logs. To be used for controls 3.1 and 3.4.
logging_bucket = "aws-cloudtrail-logs-123456789012-830c8976"
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

By default, the policies are set to `Check` in the pack's policy settings. To enable automated enforcements, you can switch these policies settings by adding a comment to the `Check` setting and removing the comment from one of the listed enforcement options:

```hcl
resource "turbot_policy_setting" "aws_audit_trail" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/auditTrail"
  note     = "AWS CIS v3.0.0 - Controls: 3.1"
  # value    = "Check: Configured"
  value    = "Enforce: Configured"
}

resource "turbot_policy_setting" "aws_logging_bucket" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/loggingBucket"
  note     = "AWS CIS v3.0.0 - Controls: 3.1"
  # value    = "Check: Configured"
  value    = "Enforce: Configured"
}

resource "turbot_policy_setting" "aws_cloudtrail_trail_log_file_validation" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-cloudtrail#/policy/types/trailLogFileValidation"
  note     = "AWS CIS v3.0.0 - Controls: 3.2"
  # value    = "Check: Enabled"
  value    = "Enforce: Enabled"
}

resource "turbot_policy_setting" "aws_config_configuration_recording" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-config#/policy/types/configurationRecording"
  note     = "AWS CIS v3.0.0 - Controls: 3.3"
  # value    = "Check: Configured"
  value    = "Enforce: Configured"
}

resource "turbot_policy_setting" "aws_s3_bucket_access_logging" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketAccessLogging"
  note     = "AWS CIS v3.0.0 - Controls: 3.4"
  # value    = "Check: Enabled to Access Logging > Bucket"
  value    = "Enforce: Enabled to Access Logging > Bucket"
}

resource "turbot_policy_setting" "aws_cloudtrail_trail_encryption_at_rest" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-cloudtrail#/policy/types/trailEncryptionAtRest"
  note     = "AWS CIS v3.0.0 - Controls: 3.5"
  # value    = "Check: Encryption at Rest > Customer Managed Key"
  value    = "Enforce: Encryption at Rest > Customer Managed Key"
}

resource "turbot_policy_setting" "aws_kms_key_rotation" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-kms#/policy/types/keyRotation"
  note     = "AWS CIS v3.0.0 - Controls: 3.6"
  # value    = "Check: Enabled"
  value    = "Enforce: Enabled"
}

resource "turbot_policy_setting" "aws_vpc_core_vpc_flow_logging" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-vpc-core#/policy/types/vpcFlowLogging"
  note     = "AWS CIS v3.0.0 - Controls: 3.7"
  # value    = "Check: Configured per `Flow Logging > *`"
  value    = "Enforce: Configured per `Flow Logging > *`"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```
