---
categories: ["security"]
primary_category: "security"
---

# Enforce Install Packages on AWS EC2 Instances Using AWS SSM Package Installer

Enforcing the installation of packages on EC2 instances using the AWS SSM Package Installer is crucial for maintaining a consistent, secure, and automated software deployment process. This measure ensures that all package installations are managed and logged through AWS Systems Manager, enhancing security, compliance, and operational efficiency by providing centralized control and monitoring of software installations.

This [policy pack](https://turbot.com/guardrails/docs/concepts/resources/smart-folders) is designed to allow package installation on instances with or without direct access to original package source and can help you configure the following settings for SSM documents:

- Set the region ARN where the SSM resources will be deployed
- Set the IAM role ARN to be used by SSM to run documents
- Create three SSM documents in the specified region
  - Turbot-LinuxPackageInstaller-PublicNetwork
  - Turbot-LinuxPackageInstaller-PrivateNetwork
  - Turbot-LinuxS3PackageInstaller

## Documentation

- **[Review Policy settings →](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/policy-packs/enforce_install_packages_on_ec2_instances_using_ssm_package_installer/settings)**
- Using the SSM documents
  - There are two entry point types:
    - Turbot-LinuxPackageInstaller-PublicNetwork
    - Turbot-LinuxPackageInstaller-PrivateNetwork

### Turbot-LinuxPackageInstaller-PublicNetwork

Use this entry point type when there is direct access to the package source.
Using this method, all that is required to the URL of the package to install.

### Turbot-LinuxPackageInstaller-PrivateNetwork

Use this entry point type when there is no direct access to the package source.
Using this method, it is required that the URL of the package to install and a valid S3 bucket which be used to cache the package.

### Turbot-LinuxS3PackageInstaller

This document should never be directly run but is a helper document to install the package.

### Current limitations

- Currently only Ubuntu is supported. Add support to more Linux flavours and Windows
- Handle package dependencies when installing through S3
- Test edge cases

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- Guardrails mods:
  - [@turbot/aws-ssm](https://hub-guardrails-turbot-com-git-development-turbot.vercel.app/aws/mods/aws-ssm)
- AWS resources to run the stack control:
  - S3 bucket to store packages
  - An IAM role for SSM document execution with the following configured permissions:

    ```json
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Action": [
            "ssm:DescribeInstanceInformation",
            "ssm:ListCommandInvocations",
            "ssm:ListCommands",
            "ssm:SendCommand"
          ],
          "Resource": "*"
        },
        {
          "Effect": "Allow",
          "Action": [
            "s3:PutObject"
          ],
          "Resource": "*"
        }
      ]
    }
    ```

  - An IAM role for the EC2 instance with the following configured permissions:

    ```json
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Action": [
            "ssm:DescribeInstanceInformation",
            "ssm:ListCommandInvocations",
            "ssm:ListCommands",
            "ssm:SendCommand"
          ],
          "Resource": "*"
        },
        {
          "Effect": "Allow",
          "Action": [
            "s3:PutObject"
          ],
          "Resource": "*"
        }
      ]
    }
    ```

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
cd guardrails-samples/policy_packs/aws/ssm/enforce_install_packages_on_ec2_instances_using_ssm_package_installer
```

Set the variable values:

```sh
cp default.tfvars.example default.tfvars
vi default.tfvars
```

```hcl
# Turbot Resource ARN for the AWS Region where SSM Documents will be placed. For example: 'arn:aws::us-east-1:123456789012'
region_arn = "<ssm_document_role_arn>"

# AWS IAM Role ARN to be used by SSM to run documents. For example: 'arn:aws:iam::999999999999:role AmazonSSMRoleForAutomationAssumeQuickSetup'
ssm_document_role_arn = "<ssm_document_role_arn>"
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

> [!IMPORTANT]
> Setting the policy to enforce mode will result in creation of resources in the target account. However, it is easy to remove those resources later, by setting the contents of the Stack's Source policy to `{}` (empty).

```hcl
resource "turbot_policy_setting" "aws_ssm_stack" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ssm#/policy/types/ssmStack"
  # value    = "Check: Configured"
  value    = "Enforce: Configured"
}
```

Then re-apply the changes:

```sh
terraform plan
terraform apply
```
