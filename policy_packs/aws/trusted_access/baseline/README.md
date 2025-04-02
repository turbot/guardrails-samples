---
categories:
  - aws
  - security
  - compliance
primary_category: aws
---

# Baseline for AWS Trusted Access Exception Management

This policy pack provides a comprehensive approach to managing exceptions for AWS Trusted Access controls. It enables centralized configuration of trusted accounts across your AWS environment while supporting account-specific exceptions where needed.

The policy pack implements a flexible, map-based configuration that allows you to:
- Define which AWS resource types should have trusted access controls enabled
- Set policy enforcement levels (Skip, Check, Enforce) for each resource type
- Configure baseline trusted accounts that apply organization-wide
- Define account-specific exceptions for special use cases

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

### Configure Trusted Access Controls

This policy pack uses a centralized configuration approach. Copy the `terraform.tfvars.example` file to `terraform.tfvars` and customize it for your environment.

The configuration has two main components:

1. **trusted_access_controls**: Map that defines which resource types to enable trusted access for and at what enforcement level
   ```hcl
   trusted_access_controls = {
     "ec2-ami"                  = "check"
     "s3-bucketPolicy"          = "enforce"
     "iam-rolePolicy"           = "check"
     # Add or remove resource types as needed
   }
   ```

2. **trusted_access_exceptions**: Configuration for baseline and account-specific trusted accounts
   ```hcl
   trusted_access_exceptions = {
     # Baseline trusted accounts applied to all AWS accounts
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

Apply to a resource in your Guardrails workspace:

```bash
terraform plan
terraform apply
```

## How It Works

This policy pack uses a combination of standard and calculated policies with an internal resource mapping:

1. **policy_map**: A local variable that contains the mapping between resource types and their service names, policy types, and values
   - This is defined as a local variable to prevent accidental modification

2. **trusted_access_policy**: Sets the enforcement level (skip, check, enforce) for each resource type

3. **trusted_access_accounts_policy**: Uses a calculated policy to dynamically determine the list of trusted accounts for each AWS account by:
   - Starting with the baseline trusted accounts
   - Adding any account-specific exceptions for the current AWS account
   - Applying the combined list to the trusted access policy

4. **trusted_access_exceptions**: Stores the configuration in a Guardrails file resource that can be referenced by calculated policies

This approach provides:
- Consistent baseline security across your AWS environment
- Flexibility to handle legitimate exceptions on a per-account basis
- Clear documentation of approved exceptions
- Simplified management through centralized configuration

## Customizing the Policy Pack

To customize this policy pack for your environment:

1. Review and update the `trusted_access_controls` map to include only the resource types you want to manage
2. Set appropriate enforcement levels based on your security requirements (skip, check, enforce)
3. Configure your baseline trusted accounts that should apply organization-wide
4. Add account-specific exceptions only where absolutely necessary

The internal `policy_map` contains the mapping of resource types to their service and resource names in the Guardrails schema. This is defined as a local variable in the code and should not be modified.