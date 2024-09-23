# Folder Hierarchy Installation

This script sets up a foundational folder hierarchy within Turbot Guardrails to organize your cloud resources across AWS, Azure, and GCP. By default, it creates a base folder for your workspace and subfolders for AWS, Azure, and GCP resources. This structure helps in managing policies, controls, and resources more efficiently within your Turbot environment.

## Documentation

- **[Review Folder Hierarchy Documentation →](https://turbot.com/guardrails/docs/concepts/resources/hierarchy)**

## Getting Started

### Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install)

### Credentials

To create a folder hierarchy using Terraform:

- Ensure you have `Turbot/Admin` permissions (or higher) in Guardrails.
- [Create access keys](https://turbot.com/guardrails/docs/guides/iam/access-keys#generate-a-new-guardrails-api-access-key) in Guardrails.

Then set your credentials:

```sh
export TURBOT_WORKSPACE=myworkspace.acme.com
export TURBOT_ACCESS_KEY=acce6ac5-access-key-here
export TURBOT_SECRET_KEY=a8af61ec-secret-key-here
```

Please see [Turbot Guardrails Provider authentication](https://registry.terraform.io/providers/turbot/turbot/latest/docs#authentication) for additional authentication methods.

## Usage

### Initialize Terraform

1. Navigate to the `folder_hierarchy` folder.
2. Run the command:

```sh
terraform init
```

### Install

After initializing Terraform, you can apply the folder hierarchy configuration:

```sh
terraform apply
```

### Destroy

You can destroy the folder hierarchy setup in one of two ways:

```sh
terraform destroy
```

## Folder Hierarchy Structure

The following folder structure will be created within your Turbot environment:

```
Turbot/
└── Company/
    │  
    ├── AWS/
    │   
    ├── Azure/
    │   
    └── GCP/
```

- **Base Folder (`Company`)**: The root folder for your workspace. Example: Acme
- **AWS**: A subfolder dedicated to organizing AWS resources.
- **Azure**: A subfolder dedicated to organizing Azure resources.
- **GCP**: A subfolder dedicated to organizing GCP resources.

This structure helps keep your cloud resources organized, allowing for easy management and application of policies across different cloud providers.
