---
categories: ["security", "kubernetes"]
primary_category: "security"
type: "featured"
---

# Block Public Access for AWS EKS Clusters

Blocking public access for AWS EKS clusters enhances security by requiring private network connectivity for cluster management, reducing the attack surface by preventing unauthorized access from the public internet. This helps ensure that only authorized applications and users within your private network can access and manage the Kubernetes control plane.

This [policy pack](https://turbot.com/guardrails/docs/concepts/policy-packs) can help you configure the following settings for EKS clusters:

- Block EKS clusters with public endpoint access enabled
- Enforce private-only access to Kubernetes API servers

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

This policy pack uses the `AWS > EKS > Cluster > Approved > Custom` policy to evaluate whether EKS clusters have public endpoint access enabled. If a cluster has `endpointPublicAccess` set to `true`, the policy will mark it as "Not approved", triggering the action defined in the `AWS > EKS > Cluster > Approved` policy.

### AWS Best Practices

AWS recommends limiting public access to EKS clusters. For more details, see [Amazon EKS Security Best Practices](https://docs.aws.amazon.com/eks/latest/userguide/security-best-practices.html) in the AWS documentation.
