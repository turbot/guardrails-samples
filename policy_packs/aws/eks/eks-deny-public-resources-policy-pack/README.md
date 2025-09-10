---
categories: ["security", "compute"]
primary_category: "security"
---

# EKS Deny Public Resources Policy Pack

Enforcing private endpoint access for AWS EKS clusters is crucial because it prevents accidental public exposure of the Kubernetes API server, reducing the attack surface and maintaining security posture. This policy pack implements a custom approval mechanism that denies clusters with public endpoint access by default while providing an exception mechanism for legitimate use cases.

This [policy pack](https://turbot.com/guardrails/docs/concepts/policy-packs) can help you configure the following settings for EKS clusters:

- Deny EKS clusters that have public endpoint access enabled
- Allow exceptions through tagging for specific clusters that legitimately need public access
- Provide audit trail and clear messaging for policy decisions

## Documentation

- **[Review policy settings →](https://hub.guardrails.turbot.com/policy-packs/eks_deny_public_resources/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)
- Guardrails mods:
  - [@turbot/aws-eks](https://hub.guardrails.turbot.com/mods/aws/mods/aws-eks)

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
cd guardrails-samples/policy_packs/aws/eks/eks-deny-public-resources-policy-pack
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

### Policy Logic

The policy implements a three-tier decision process:

1. **Exception Check**: First checks if the EKS cluster has the tag:
   ```
   turbot:deny-public-resources:exception = "true"
   ```

2. **Public Access Check**: If no exception tag is present, checks the cluster's `endpointPublicAccess` setting.

3. **Decision Matrix**:

| Condition | Result | Message |
|-----------|--------|---------|
| Exception tag present | ✅ **Approved** | "EKS cluster is tagged to skip deny-public-resources control" |
| Public access = true, no exception | ❌ **Not Approved** | "EKS cluster {name} has public endpoint access" |
| Public access = false | ✅ **Approved** | "EKS cluster has private endpoint access" |

### Grant Exception

To allow a specific EKS cluster to have public access, add this tag:

```
turbot:deny-public-resources:exception = "true"
```

The tag value is case-insensitive and accepts `"true"`, `"True"`, `"TRUE"`, etc.

### Enable Enforcement

> [!TIP]
> You can also update the policy settings in this policy pack directly in the Guardrails console.
>
> Please note your Terraform state file will then become out of sync and the policy settings should then only be managed in the console.

By default, the policies are set to `Check` in the pack's policy settings. To enable automated enforcements, you can switch these policy settings by modifying the policy value in the `policies.tf` file.

The policy pack uses a custom approval policy that automatically evaluates and provides results. The enforcement behavior depends on the parent `AWS > EKS > Cluster > Approved` policy setting.

## Security Benefits

- **Prevents accidental public exposure** of EKS clusters
- **Maintains security posture** while allowing legitimate exceptions
- **Provides audit trail** through policy results and messages
- **Enforces least privilege** access patterns
- **Reduces attack surface** by limiting public API access
