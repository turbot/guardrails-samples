# AWS EC2 Instance - restrict Instance Image to local AMI

## Use case

Use this policy if you would like to restrict the usage of EC2 Instance Images to local account AMI Images only.

## Implementation Details

Calculated policy for policy `AWS > EC2 > Instance > Approved > Usage`.
Approval policy that will limit running EC2 Instances to only use local EC2 Instance Images.
If an EC2 instance Image is not owned by the account that the Instance is running on, then the approved usage
policy will be set to `Not approved` otherwise it will be set to `Approved`.

### Template Input (GraphQL)

GraphQL query that will check if a Instance has accounts with restore access.
If the query returns an array of zero items, then the Instance Image is not a local AMI.

```graphql
- {
  item: resource {
    imageId: get(path: "ImageId")
    turbot {
      custom
    }
  }
}
- {
  resources (filter: "resourceType:'tmod:@turbot/aws-ec2#/resource/types/Ami' $.ImageId:'{{$.item.imageId}}' $.OwnerId:'{{$.item.turbot.custom.aws.accountId}}'") {
    metadata {
      stats {
        total
      }
    }
  }
}
```

### Template (Nunjucks)

Approval logic for EC2 Instance Image local AMI.


```nunjucks
{% if $.resources.metadata.stats.total %}
  Approved
{% else %}
  Not approved
{% endif %}
```

The template itself is a [Nunjucks formatted template](https://mozilla.github.io/nunjucks/templating.html).

## Prerequisites

To create the smart folder, you must have:

- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://github.com/turbotio/terraform-provider-turbot)
- Credentials Configured to connect to your Turbot workspace

## Running the Example

Scripts can be run in the folder that contains the script.

### Configure the script

Update [default.tfvars](default.tfvars) or create a new Terraform configuration file.

Variables that are exposed by this script are:

- smart_folder_title
- target_resource

Open the file [variables.tf](variables.tf) for further details.

### Initialize Terraform

If not previously run then initialize Terraform to get all necessary providers.

Command: `terraform init`

### Apply using default configuration

If seeking to apply the configuration using the configuration file [defaults.tfvars](defaults.tfvars).

Command: `terraform apply -var-file=default.tfvars`

### Apply using custom configuration

If seeking to apply the configuration using a custom configuration file `<custom_filename>.tfvars`.

Command: `terraform apply -var-file=<custom_filename>.tfvars`

### Destroy using default configuration

If seeking to apply the configuration using the configuration file [defaults.tfvars](defaults.tfvars).

Command: `terraform destroy -var-file=default.tfvars`

### Destroy using custom configuration

If seeking to apply the configuration using a custom configuration file `<custom_filename>.tfvars`.

Command: `terraform destroy -var-file=<custom_filename>.tfvars`
