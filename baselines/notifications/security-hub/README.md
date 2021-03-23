# Turbot Firehouse to Security Hub

Security Hub gives account owners and engineers a single point of contact to view their security and compliance posture.  Architects and engineers without access to the Turbot console can use this integration to receive up-to-date information about Turbot controls for their account.

## Required Reading
- [Firehose Guide](https://turbot.com/v5/docs/guides/firehose): Provides an overview of what kind of information Turbot can deliver overall.  This integration is restricted to `control_updated` notifications.

## Architecture
The next few sections describe the overall architecture and components of the Turbot+SecurityHub Integration.

### Services Used

- Turbot
- Turbot Firehose
- SNS
- SQS
- Lambda
- Elasticache Memcached
- Cloudwatch Logs
- VPC

### Connectivity Requirements

The Security Hub Lambda must be able to talk to the following services:
- AWS Security Hub Regional Endpoints
- Memcached (inside VPC)
- SNS
- SQS
- STS
  
Customers are free to use a VPC with NAT/IGWs or transit gateways. Either approach that has internet access will
work.  The provided Terraform will create a new VPC with NAT/IGWs.


### Client -> Server Relationships
- Firehose SNS Topic -> SQS
- SQS -> Security Hub Lambda
- Security Hub Lambda -> Memcached
- Security Hub Lambda -> Cloudwatch Logs
- Security Hub Lambda -> Security Hub API Endpoints
- Security Hub Lambda -> STS API Endpoints


### Data Flow for a Notification

1. AWS Managed Account -- (events) -> Turbot (Controls are updated here)
2. Turbot -- (`control_udpated` notifications as defined by Watches) -> Turbot Firehose mod
3. Turbot Firehose mod --> Firehose SNS topic
4. Firehose SNS topic --> Security Hub Queue
5. Security Hub Queue --> Security Hub Lambda
6. Security Hub Lambda -- (data transform to ASFF formatting) --> Security Hub

### Fatal Errors

There are a number of circumstances where this integration will discard a notification. The below conditions are
considered as terminal errors.  **Any finding that encounters one of the below problems will be discarded.** 

- *Access Denied* to the target account. Typically, this is when the integration cannot assume into the specified role. 
- *Invalid Access* to the target account. If Security Hub is not enabled for this account, then findings cannot be
  submitted.
- *Turbot Findings are not enabled*. This happens when Security Hub is enabled, but Turbot findings are not enabled.
  This integration will not submit findings into the `default` product.

## Limitations of this Integration

- The Turbot firehose is an event-based stream of data. As events flow into Turbot, notifications flow out through the
  Firehose. If Turbot doesn't receive an event, the Firehose will never emit a notification. The implication is that
  very old alarms on unchanged resources will not appear in Security Hub. Controls resulting from updated resources or
  new policy settings will appear in Security Hub. Customers wishing a snapshot view of all controls should investigate
  a batch-processing approach using the Turbot GraphQL API.
- Turbot Firehose emits a `control_updated` notification only when a control changes state. If a resource is updated,
  but the control still stays in alarm, then no control notification will be generated.
    - `ok` to `alarm`: A `control_updated` notification will be generated.
    - `alarm` to `alarm`: No notification will be generated.
- Security Hub is focused exclusively on security findings. It is not a CMDB. As such, the Turbot+SecurityHub
  integration will only process `control_updated` notifications. All other notification types will be discarded.
- All Security Hub findings will expire after 90 days. This integration will not refresh those findings.
- Security Hub Insights are not addressed.
- This integration will not enable/disable Turbot findings in Security Hub.

### Where to Deploy

Any account can host the Security Hub integration if it meets the following requirements:
- Assume permissions into a role in each managed account to import and update findings.
- Access to the SQS queue feed by the Firehose SNS topic.

*Enterprise customers*: It is most convenient to deploy this integration, and the Turbot Firehose in the Turbot Master account.
The `turbot_superuser` role that Turbot uses to manage an account can be reused for importing Security Hub findings.

*SaaS customers*: Deploying this integration will have to be done in a separate account. Customers can choose between
creating a new Security Hub specific role or reusing the `turbot_superuser` role. Either approach is valid and depends
on each customer's individual situation.  Deploying in the same account as the Firehose SNS is most convenient.

### Role Configuration in Managed Accounts
A role must exist in each managed account with sufficient permissions to import and update findings in Security Hub.
The role must also allow `sts:AssumeRole` by the Security Hub integration lambda. This integration assumes a uniform role name for all managed accounts.  The specified role is appended to the arn, like so: `arn:aws:iam::{account_id}:role/{role_id}`.

Note: For customers with multiple Turbot environments hosted in separate accounts, it is possible, perhaps desirable, to send all Security Hub findings through a single integration point.  Such a configuration is supported with the requirement that cross-account access be granted to the integration. Assuming the reuse of the `turbot_superuser` role, cross-account access is typically only granted to a single Turbot Master account.  If this integration is servicing multiple Turbot Masters, the `turbot_superuser` role would require additional trust configuration. 

Below are the minimum permissions required to work with findings in Security Hub.

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "SecurityHub Submission Permissions",
      "Effect": "Allow",
      "Action": [
        "securityhub:UpdateFindings",
        "securityhub:GetFindings",
        "securityhub:BatchUpdateFindings",
        "securityhub:BatchImportFindings"
      ],
      "Resource": "*"
    },
    {
      "Sid": "Assume Role",
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "arn:aws:iam::{account_hosting_sechub_integration}:root"
        ]
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "StringEquals": {
          "sts:ExternalId": "{somecleverexternalidgoeshere}"
        }
      }
    }
  ]
}
```
External IDs are recommended but not required. Customers are free to make the Principal more specific.  The above policy tries to strike a balance between usability and security, emphasizing ease of setup.

## Installation

The provided terraform assumes that no configuration of any kind has been done for Firehose or the SecurityHub
integration. It also assumes that no infrastructure of any kind has been deployed in the AWS account (ie, no VPC, no
subnets, etc) that will host the Turbot+SecurityHub integration. As such, customers with a configured Firehose and network infrastructure will need to adapt the Terraform to their environment.

### Permissions Required for Integration Deployment
The user or role that deploys should have read/write permissions to the following AWS services:
- IAM
  - Create User: Required for firehose configuration
  - Create Role: Required for Security Hub Lambda configuration
  - Create/Attach policy
- SNS
- SQS
- VPC
- Elasticache (memcached)
- Lambda
- Cloudwatch Logs

The user that deploys should have read/write permissions to the target Turbot workspace:
- Turbot/Admin: Required to set the Firehose policies and create the watch.

### Watches

The default watch included in this integration looks for all `control_updated` notifications from AWS, Azure, GCP and Turbot. The
integration will filter out notifications for non-AWS platforms. For additional information about creating
Watches, see the [Turbot Notifications Guide](https://turbot.com/v5/docs/guides/firehose).

If using multiple watches in a single workspace, ensure that each watch is performing as expected.  Avoid duplication in watches where possible.

From `create-watch-mutation-input.json`, we see the watch definition.

```json
{
  "input": {
    "resource": "tmod:@turbot/turbot#/",
    "action": "tmod:@turbot/firehose-aws-sns#/action/types/router",
    "filters": [
      "level:self,descendant notificationType:control_updated"
    ]
  }
}
```

### Deployment Instructions
The provided terraform utilizes AWS and Turbot credentials.  Ensure that Python 3.7+, the AWS CLI and Turbot CLI tools are installed. The following steps were tested on a Linux workstation using Python 3.7 and 3.8.

1. Configure your aws cli credentials
```shell
aws configure
```

2. Configure your Turbot API credentials according to the [directions](https://turbot.com/v5/docs/guides/iam/access-keys)
```shell
turbot configure --profile {profile}
```

3. Adapt the provided terraform to meet environmental needs. 
   
4. Initialize Terraform
```shell
terraform init
```

5. Create and populate a `.tfvars` file with the appropriate values.

6.  Generate a TF plan 
```shell
terraform plan -var-file={environment}.tfvars 
```
Check the plan to ensure proper deployment.

7. Deploy
```shell
terraform apply -var-file={environment}.tfvars
```
The default TF will deploy the AWS resources then set the appropriate Turbot policies.

8. Test the setup by altering controls in Turbot then checking in Security Hub for the findings to arrive.  Be aware there will be some latency between when Turbot updates a control and when it shows up in Security Hub.  In quiet environments, latency of 30 to 90 seconds is normal.  High load on Turbot may introduce additional delay in delivery of Firehose notifications. 

### Deploying Updated Lambda code
Should you need to update the Lambda code but leave all other infrastructure intact, you can deploy a code update using the AWS CLI.  From the [AWS Lambda Docs](https://docs.aws.amazon.com/lambda/latest/dg/python-package-update.html), use the following to update the Lambda code with whatever changes you've made.
```shell
package-lambda.sh
aws lambda update-function-code --function-name turbot-firehose-to-sec-hub-write-to-security-hub --zip-file fileb://deployment-package.zip
```


### Decommission

1. Destroy the TF setup
```shell
terraform destroy -var-file={environment}.tfvars
```

## Monitoring
Watch the Cloudwatch logs and Function Monitoring for the integration lambda `turbot-firehose-to-sec-hub-write-to-security-hub`. 

## Troubleshooting
Refer to the [Data Flow Path](#data-flow-for-a-notification) to track down which part of the path has broken down.
