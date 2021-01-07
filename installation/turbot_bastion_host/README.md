# Turbot Bastion Host
Turbot Bastion Host is used to connect to the resources like RDS Host living in the Turbot Enterprise for basic toubleshooting purposes.
It leverages AWS EC2 instance(s) managed by [Session Manager](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager.html) and can be accessed only through the browser-based interface i.e, [Systems Manager Console](https://console.aws.amazon.com/systems-manager/). Below are the key benefits that Turbot Bastion host offers.

* Eliminates the need for IAM users and SSH keys.
* Eliminates the need for Inbound Security Group rules over port 22.
* Grabs the latest Amazon Linux2 AMI using SSM Parameters.
* Gives the ability to use custom configurations for AMIs and IAM Roles.
* Self-destructs after the desired number of hours.
* Comes with postgresql11 client installed.

In addition to the above, it also compliments the Session Manager capabilities such as
* Sessions are secured using an AWS Key Management Service key.
* You can log session commands and details in an Amazon S3 bucket or CloudWatch Logs log group.

## Launch Turbot Bastion Host

1. In the AWS Console, navigate to the CloudFormation service in the alpha region.
2. Create a new stack, using the [Turbot Bastion Host CloudFormation Template](./turbot_bastion_host.yaml)
3. Enter the appropriate parameters:
  * **Bastion Host Name:** The name of the EC2 instance.
  * **Life Time (in hours):** The life time duration of the bastion host (in hours). The CloudFormation stack will be deleted after it's life time. You can choose not to delete the cloudformation stack (not recommended).
  * **VPCId:** The ID of the Amazon Virtual Private Cloud (Amazon VPC) in which Turbot is hosted (e.g., vpc-1a2b3c4d or vpc-1234567890abcdef0).
  * **PublicSubnetId:** The ID of the Public Subnet in which the bastion host will be launched (e.g., subnet-a0246dcd or subnet-1234567890abcdef0).
  * **PublicIPv4Address:** The bastion host instance needs connectivity to the Gateway endpoints for Systems Manager. If your organization has a dedicated network connection to AWS, you can make use of Private IPv4 otherwise, use a Public IPv4 address.
  * **LatestAmiId:** The AWS SSM Parameter Store [namespace](https://aws.amazon.com/blogs/compute/query-for-the-latest-amazon-linux-ami-ids-using-aws-systems-manager-parameter-store/) of the AMI. Defaults to Amazon Linux 2 distribution. Leave it as it is, incase if you want to use your golden AMIs.
  * **BastionInstanceType:** AWS EC2 instance type for the bastion host.
  * **RootVolumeSize:** The root volume size in GB for the bastion host. Should always be greater than the size of the AMI used. Is encrypted and makes use of gp3 volume type.
  * **KMSEncryptionKeyArn:** Session Manager can be configured to use AWS Key Management Service (AWS KMS) key encryption to provide additional protection to the data transmitted between client machines and managed instances. Please check your `AWS Systems Manager > Session Manager > Preferences` settings to check if KMS encryption is enabled or disabled.
      If KMS Encryption is enabled then enter the KMS Key full ARN used in your AWS Systems Manager > Session Manager > Preferences. (e.g., "arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab").
      Leave empty if KMS Encryption is disabled.
  * **CloudWatchLogGroupName:** Session Manager can be configured to create and send session history logs to an Amazon Simple Storage Service (Amazon S3) bucket or an Amazon CloudWatch Logs log group. Please check your `AWS Systems Manager > Session Manager > Preferences` settings to check if CloudWatch Logging is enabled or disabled.
      If Cloudwatch Logging is enabled, then enter the "CloudWatch log group" name from AWS Systems Manager > Session Manager > Preferences. (e.g., my-loggroup-for-sessionmanager-logs).
      Leave empty if CloudWatch Logging is disabled.
  * **S3BucketWithPrefix:** Session Manager can be configured to create and send session history logs to an Amazon Simple Storage Service (Amazon S3) bucket or an Amazon CloudWatch Logs log group. Please check your `AWS Systems Manager > Session Manager > Preferences` settings to check if S3 Logging is enabled or disabled.
      If S3 Logging is enabled, then enter the "S3 bucket" followed by "S3 prefix" from AWS Systems Manager > Session Manager > Preferences. (e.g., my-s3bucket-for-sessionmanager-logs/dev-env/).
      Leave empty if S3 Logging is disabled.
  * **OSImageOverride:** In case if you want to use a custom golden AMI instead of the default Amazon Linux 2 AMIs, please enter the AMI ID (e.g., ami-1a2b3c4d or ami-1234567890abcdef0). Leave empty if no alternative configuration is needed.
  * **AlternativeIAMRole:** The CloudFormation stack creates an IAM role with required permissions, in case if you want to attach an existing IAM role to the bastion host then please enter the IAM Role Name. (e.g., my_ssm_role). Leave empty if no alternative configuration is needed.

4. Click through to review your changes and then launch the stack.
5. Verify that the stack completes successfully.
6. Navigate to the `Outputs` section of the stack for the Systems Manager Console URL.

## FAQ

* How do I connect to my RDS Instance?

  Execute the below steps in order to connect to the RDS.
  ```
  export RDSHOST=<Enter the RDS endpoint, should be something like turbot-boltzman.cpnkkknwkny9.us-east-2.rds.amazonaws.com>
  export PGPASSWORD="$(aws rds generate-db-auth-token --hostname $RDSHOST --port 5432 --region <AWS region of the DB, like us-east-1> --username turbot )"
  psql -h $RDSHOST  -d turbot -U turbot
  ```
* Why does my session timeout every 20 min?

  Session Manager enables you to specify the amount of time to allow a user to be inactive before a session ends. By default, sessions time out after 20 minutes of inactivity. You can [modify this](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-preferences-timeout.html) setting to specify that a session times out between 1 and 60 minutes of inactivity.

* I want to make use of Private IPv4 address but I do not have a dedicated network to AWS, is there an alternative?

  Yes, it is possible by using PrivateLink. PrivateLink [costs](https://aws.amazon.com/privatelink/pricing/) per endpoint. For more details please refer to https://docs.aws.amazon.com/systems-manager/latest/userguide/setup-create-vpc.html

* Where can I see the session activity logs?

  Please refer to https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-logging.html
