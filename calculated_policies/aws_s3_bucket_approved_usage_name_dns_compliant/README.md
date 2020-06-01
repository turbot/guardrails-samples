# AWS S3 Bucket - restrict name to DNS compliant.

## Use case

Use this policy if you would like to restrict the name of S3 Bucket images to DNS compliant

## Implementation Details

Calculated policy for policy `AWS > S3 > Bucket > Approved > Usage`.
If a S3 Bucket name is not DNS compliant, then the approved usage policy will be set to `Not approved` otherwise
it will be set to `Approved`.

### Template Input (GraphQL)

GraphQL query that will get the instance image.

```graphql
{
  resource {
    name: get(path: "Name")
  }
}
```

### Template (Nunjucks)

Approval logic for S3 Bucket trusted AWS accounts AMIs.
If S3 Bucket name does not match DNS compliant regular expression, then it will return `Not approved`.


```nunjucks
{# Defined at http://docs.aws.amazon.com/AmazonS3/latest/dev/BucketRestrictions.html #}
{# Implemented based on http://stackoverflow.com/a/106223 #}
{% set dnsNameRegExp = r/^(([a-z0-9]|[a-z0-9][a-z0-9-]*[a-z0-9])\\.)*([a-z0-9]|[a-z0-9][a-z0-9-]*[a-z0-9])$/g %}
{% if $.resource.name | length >= 3 and
      $.resource.name | length <= 63 and
      dnsNameRegExp.test($.resource.name) %}
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
