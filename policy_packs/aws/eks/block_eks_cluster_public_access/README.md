---
categories: ["security", "kubernetes"]
primary_category: "security"
type: "featured"
---

# Block Unrestricted Public Access for AWS EKS Clusters

This policy pack helps secure AWS EKS clusters by enforcing controlled public access configurations. It ensures that clusters either have public access disabled or restricted to specific CIDR ranges, preventing unrestricted public access (0.0.0.0/0) that could expose the Kubernetes API server to potential security risks.

This [policy pack](https://turbot.com/guardrails/docs/concepts/policy-packs) can help you configure the following settings for EKS clusters:

- Block EKS clusters with unrestricted public endpoint access (0.0.0.0/0)
- Allow EKS clusters with restricted public access (specific CIDR ranges)
- Allow EKS clusters with private-only access
- Monitor and enforce public access configurations

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
cd guardrails-samples/policy_packs/aws/eks/block_eks_cluster_public_access
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

### Implementation Details

This policy pack implements two policies:

1. `AWS > EKS > Cluster > Approved`

   - Controls enforcement actions for non-compliant clusters
   - Default: "Check: Approved" (monitoring mode)
   - Optional: "Enforce: Delete unapproved if new" (enforcement mode)

2. `AWS > EKS > Cluster > Approved > Custom`
   - Evaluates cluster public access configuration
   - Checks `endpointPublicAccess` and `publicAccessCidrs` settings
   - Approves clusters with:
     - Public access disabled
     - Public access restricted to specific CIDR ranges
   - Rejects clusters with unrestricted public access (0.0.0.0/0)

### Policy Results

The policy will report one of three results:

1. **Approved**

   - Public access is disabled
   - Public access is restricted to specific CIDR ranges

2. **Not Approved**

   - Public access is unrestricted (0.0.0.0/0)

3. **Skip**
   - No action needed. 

### AWS Best Practices

AWS recommends limiting public access to EKS clusters. When public access is required, it should be restricted to specific CIDR ranges. For more details, see:

- [Amazon EKS cluster endpoint access control](https://docs.aws.amazon.com/eks/latest/userguide/cluster-endpoint.html)
- [Amazon EKS Security Best Practices](https://docs.aws.amazon.com/eks/latest/userguide/security-best-practices.html)
