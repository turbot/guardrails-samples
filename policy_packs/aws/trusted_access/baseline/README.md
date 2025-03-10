---
categories:
  - aws
  - security
  - compliance
primary_category: aws
---

# Baseline for Trusted Access Exception Management

This policy pack provides a baseline for managing exceptions to Trusted Access controls in AWS. It enables you to standardize how exceptions are handled across your cloud resources, ensuring that proper governance and documentation are in place when trusted access policies need exceptions.

This policy pack can help you:
- Define a centralized configuration for trusted access exceptions
- Apply baseline trusted accounts across all AWS accounts
- Configure account-specific exceptions for different AWS accounts
- Automatically implement trusted access policies with calculated policies

For more information on Guardrails policy packs, see the [documentation](https://turbot.com/guardrails/docs) or [contact Guardrails support](https://turbot.com/guardrails/support).

## Getting Started

### Requirements

- Terraform >= 1.0.0
- [Guardrails Provider >= 1.0.0](https://turbot.com/guardrails/docs/reference/terraform/provider)
- [AWS Mod >= 5.43.0](https://turbot.com/guardrails/docs/mods/turbot/aws)

### Credentials

This provider requires credentials configured for the Guardrails provider.

```bash
export TURBOT_ACCESS_KEY=xxxxxxxxxxxx
export TURBOT_SECRET_KEY=xxxxxxxxxxxx
export TURBOT_WORKSPACE=https://guardrails.example.com
```

Credentials can be provided by either adding them to your terraform files or by setting environment variables.
Environment variables will override any terraform values set.

For further information on credentialing, refer to the [Guardrails provider documentation](https://turbot.com/guardrails/docs/reference/terraform/provider).

## Usage

### Install Policy Pack

Clone repository to a location on your local disk:

```bash
git clone https://github.com/turbot/guardrails-samples.git
cd guardrails-samples/policy_packs/aws/trusted_access/baseline
```

Initialize with Terraform:

```bash
terraform init
```

### Configure Trusted Access Exceptions

This policy pack uses a centralized configuration file to manage trusted access exceptions. Edit the `terraform.tfvars` file to configure:

1. **Baseline trusted accounts** - Applied to all AWS accounts
2. **Account-specific exceptions** - Additional trusted accounts for specific AWS accounts

Example configuration:

```hcl
trusted_access_exceptions_config = {
  # Baseline trusted account IDs applied to all accounts
  baseline = [
    "123456789012",  # Example Account 1
    "234567890123"   # Example Account 2
  ]
  
  # Account-specific trusted access configurations
  accounts = {
    "111122223333" = [  # AWS Account ID
      "345678901234"    # Additional trusted account for this specific account
    ]
  }
}
```

### Apply Policy Pack

Apply to all resources in a Guardrails resource:

```bash
terraform plan -var target_resource="tmod:@turbot/turbot#/"
terraform apply -var target_resource="tmod:@turbot/turbot#/"
```

Apply to a specific resource:

```bash
terraform plan -var target_resource="tmod:@turbot/turbot#/control/types/AWS/S3"
terraform apply -var target_resource="tmod:@turbot/turbot#/control/types/AWS/S3"
```

> [!NOTE]
> Use terraform plan before applying to review the proposed policy settings.

### Enable Enforcement

Policies are created in `Check` mode by default. To switch to `Enforce` mode, set the `policy_setting` variable to `Enforce`:

```bash
terraform plan -var policy_setting="Enforce" -var target_resource="tmod:@turbot/turbot#/"
terraform apply -var policy_setting="Enforce" -var target_resource="tmod:@turbot/turbot#/"
```

## How It Works

This policy pack uses calculated policies to dynamically determine which accounts should be trusted based on:

1. The baseline trusted accounts defined in the configuration
2. Any account-specific additional trusted accounts for the current AWS account

When evaluating trusted access for a resource, the policy will:
- Start with the baseline trusted accounts
- Add any account-specific exceptions for the current AWS account
- Apply the combined list to the trusted access policy

This enables consistent baseline security with the flexibility to handle legitimate exceptions on a per-account basis.