---
categories: ["networking"] # "stacks"?? "landing zones" ???
primary_category: "networking"
---

# Deploy Landing Zone VPCs

A **Landing Zone VPC** is a pre-configured, user-defined standard network environment in AWS, designed to serve as the foundation for deploying and managing resources. It ensures consistency, governance, and compliance by implementing standard configurations, security controls, and policies. By centralizing management and adhering to best practices, a Landing Zone VPC minimizes risks, optimizes costs, and provides a solid framework for cloud operations from day one.

This [policy pack](https://turbot.com/guardrails/docs/concepts/policy-packs) helps you configure a landing zone VPC using the `AWS > VPC > Stack [Native]` control. You can customize the `Source`, but the example will create:
- A VPC
- An Internet Gateway
- 0 or more private subnets (default 2)
- 0 or more public subnets (default 2)
- 0 or more nat gateways (default 2)
- Routing tables and associations

The IP address assignments are read from the `ip_assignments` variable, which contains map of ip addresses to assign, by account-alias and region. *You must add entries to the map for your specific account aliases and regions*.  In this example, an entry isn't found in the map for a given account/region, it will not create any resource but the control will remain in OK state.


## Documentation

- **[Review Policy settings →](https://hub.guardrails.turbot.com/policy-packs/aws_vpc_stack_deploy_landing_zone_vpcs/settings)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)

- Guardrails mods:
  - [@turbot/aws-vpc](https://hub.guardrails.turbot.com/mods/aws/mods/aws-vpc)

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
cd guardrails-samples/policy_packs/aws/stack/deploy_landing_zone_vpc
```

In the `policies.tf` file, edit the `aws_vpc_stack_variables` to include the correct values for the `ip_assignments` variable.   This should contain a map of ip addresses to assign, by account-alias and region, for example:
```hcl
ip_assignments = {
    gnb-aaa-us-east-1 = "10.100.8.0/22"
    gnb-aaa-us-west-2 = "10.104.8.0/22"
    gnb-bbb-us-east-1 = "10.108.8.0/22"
    gnb-bbb-us-west-2 = "10.112.8.0/22"
    gnb-ccc-us-east-1 = "10.116.8.0/22"
    gnb-ccc-us-west-2 = "10.120.8.0/22"
    gnb-ddd-us-east-1 = "10.124.8.0/22"
    gnb-ddd-us-east-2 = "10.128.8.0/22"
}
```

The CIDR ranges may be any size.  The example `Source` will divide them evenly based on the number of subnets you choose to create.  By default, the policy pack will create 2 public subnets and 2 private subnets across 2 availability zones.  You can changes this by editing the `Variables` policy in the `policies.tf` file.

Of course, you can (and probably should) modify the `Source` policy to match you standards as well.  The source is contained in the `stack-source.hcl` file. 

When you are ready to install the policy pack, run the Terraform commands to create the policy pack in your workspace:

```sh
terraform init
terraform plan
```

Then apply the changes:

```sh
terraform apply
```

### Apply Policy Pack

> [!IMPORTANT]
> Attaching this policy pack in Guardrails will result in creation of resources in the target account. However, it is easy to remove those resources later, by setting the contents of the Stack's Source policy to `{}` (empty).

Log into your Guardrails workspace and [attach the policy pack to a resource](https://turbot.com/guardrails/docs/guides/policy-packs#attach-a-policy-pack-to-a-resource).

If this policy pack is attached to a Guardrails folder, its policies will be applied to all accounts and resources in that folder. The policy pack can also be attached to multiple resources.

For more information, please see [Policy Packs](https://turbot.com/guardrails/docs/concepts/policy-packs).

### Enable Enforcement

> [!TIP]
> You can also update the policy settings in this policy pack directly in the Guardrails console.
>
> Please note your Terraform state file will then become out of sync and the policy settings should then only be managed in the console.

By default, the policies are set to `Check` in the pack's policy settings. To enable automated enforcements, you can switch these policies settings by adding a comment to the `Check` setting and removing the comment from one of the listed enforcement options:

```hcl
resource "turbot_policy_setting" "aws_vpc_stack" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-vpc-core#/policy/types/vpcServiceStackNative"
  #value    = "Check: Configured"
  value    = "Enforce: Configured"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```