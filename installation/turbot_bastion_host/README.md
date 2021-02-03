# Turbot Bastion Host

Turbot Bastion Host is used to connect to the resources like RDS Host living in the Turbot Enterprise for basic toubleshooting purposes.
It leverages AWS EC2 instance(s) managed by [Session Manager](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager.html) and can be accessed only through the browser-based interface i.e, [Systems Manager Console](https://console.aws.amazon.com/systems-manager/). Below are the key benefits that Turbot Bastion host offers.

- Eliminates the need for IAM users and SSH keys.
- Eliminates the need for Inbound Security Group rules over port 22.
- Grabs the latest Amazon Linux2 AMI using SSM Parameters.
- Gives the ability to use custom configurations for AMIs and IAM Roles.
- Self-destructs after the desired number of hours.
- Comes with postgresql11 client installed.

In addition to the above, it also compliments the Session Manager capabilities such as

- Sessions are secured using an AWS Key Management Service key.
- You can log session commands and details in an Amazon S3 bucket or CloudWatch Logs log group.

## Launch Turbot Bastion Host

1. In the AWS Console, navigate to the CloudFormation service in the alpha region.
2. Create a new stack, using the [Turbot Bastion Host CloudFormation Template](./turbot_bastion_host.yaml)
3. Enter the appropriate parameters:

- **Bastion Host Name:** The name of the EC2 instance.
- **Life Time (in hours):** The life time duration of the bastion host (in hours). The CloudFormation stack will be deleted after it's life time. You can choose not to delete the cloudformation stack (not recommended).
- **VPCId:** The ID of the Amazon Virtual Private Cloud (Amazon VPC) in which Turbot is hosted (e.g., vpc-1a2b3c4d or vpc-1234567890abcdef0).
- **PublicSubnetId:** The ID of the Public Subnet in which the bastion host will be launched (e.g., subnet-a0246dcd or subnet-1234567890abcdef0).
- **PublicIPv4Address:** The bastion host instance needs connectivity to the Gateway endpoints for Systems Manager. If your organization has a dedicated network connection to AWS, you can make use of Private IPv4 otherwise, use a Public IPv4 address.
- **LatestAmiId:** The AWS SSM Parameter Store [namespace](https://aws.amazon.com/blogs/compute/query-for-the-latest-amazon-linux-ami-ids-using-aws-systems-manager-parameter-store/) of the AMI. Defaults to Amazon Linux 2 distribution. Leave it as it is, incase if you want to use your golden AMIs.
- **BastionInstanceType:** AWS EC2 instance type for the bastion host.
- **RootVolumeSize:** The root volume size in GB for the bastion host. Should always be greater than the size of the AMI used. Is encrypted and makes use of gp3 volume type.
- **OSImageOverride:** In case if you want to use a custom golden AMI instead of the default Amazon Linux 2 AMIs, please enter the AMI ID (e.g., ami-1a2b3c4d or ami-1234567890abcdef0). Leave empty if no alternative configuration is needed.
- **AlternativeIAMRole:** The CloudFormation stack creates an IAM role with required permissions, in case if you want to attach an existing IAM role to the bastion host then please enter the IAM Role Name. (e.g., my_ssm_role). Leave empty if no alternative configuration is needed.
- **Environment variables:** A comma-separated list of environment variables for use in bootstrapping. Variables must be in the format KEY=VALUE. VALUE cannot contain commas. Use the variables RDSHOST, REDISHOST, REDISREPLICAHOST for RDS and Redis respectively. RDSPASSWORD is set by default. You need to run `source /etc/profile.d/environment` after the bastion boots up for these variables to reflect.
- **KMSEncryptionKeyArn:** Session Manager can be configured to use AWS Key Management Service (AWS KMS) key encryption to provide additional protection to the data transmitted between client machines and managed instances. Please check your `AWS Systems Manager > Session Manager > Preferences` settings to check if KMS encryption is enabled or disabled.
  If KMS Encryption is enabled then enter the KMS Key full ARN used in your AWS Systems Manager > Session Manager > Preferences. (e.g., "arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab").
  Leave empty if KMS Encryption is disabled.
- **CloudWatchLogGroupName:** Session Manager can be configured to create and send session history logs to an Amazon Simple Storage Service (Amazon S3) bucket or an Amazon CloudWatch Logs log group. Please check your `AWS Systems Manager > Session Manager > Preferences` settings to check if CloudWatch Logging is enabled or disabled.
  If Cloudwatch Logging is enabled, then enter the "CloudWatch log group" name from AWS Systems Manager > Session Manager > Preferences. (e.g., my-loggroup-for-sessionmanager-logs).
  Leave empty if CloudWatch Logging is disabled.
- **S3BucketWithPrefix:** Session Manager can be configured to create and send session history logs to an Amazon Simple Storage Service (Amazon S3) bucket or an Amazon CloudWatch Logs log group. Please check your `AWS Systems Manager > Session Manager > Preferences` settings to check if S3 Logging is enabled or disabled.
  If S3 Logging is enabled, then enter the "S3 bucket" followed by "S3 prefix" from AWS Systems Manager > Session Manager > Preferences. (e.g., my-s3bucket-for-sessionmanager-logs/dev-env/).
  Leave empty if S3 Logging is disabled.

4. Click through to review your changes and then launch the stack.
5. Verify that the stack completes successfully.
6. Navigate to the `Outputs` section of the stack for the Systems Manager Console URL.

## FAQ

- How do I connect to my RDS Instance?

  - If the environment variables are passed to the CFN template, then run the below commands.

    ```shell
      source /etc/profile.d/environment
      psql -h $RDSHOST  -d turbot -U turbot
    ```

  - If the environment variables are not passed to the CFN template or if you would like to update them, execute below commands.

    ```shell
      export RDSHOST=<Enter the RDS endpoint, should be something like turbot-boltzman.cpnkkknwkny9.us-east-2.rds.amazonaws.com>
      export PGPASSWORD="$(aws rds generate-db-auth-token --hostname $RDSHOST --port 5432 --region <AWS region of the DB, like us-east-1> --username turbot )"
      psql -h $RDSHOST  -d turbot -U turbot
    ```

- How do I connect to my Redis Cluster?

  <!-- - Capture the Redis user password from AWS SSM Parameters Store with parameter name /<prefix>/hive/<hive_name>/redisUser -->

  - If the environment variables are passed to the CFN template, then run the below commands.

    ```shell
      source /etc/profile.d/environment
      sudo netstat -tulnp | grep -i stunnel # Confirm that the tunnels started
      redis-cli -h localhost -p 6379 -a <password>
    ```

  - If the environment variables are not passed to the CFN template or if you would like to update them, execute below commands.

    ```shell
      sudo vi /etc/stunnel/redis-cli.conf # Update the connection string for master and replica
      sudo stunnel /etc/stunnel/redis-cli.conf # Start stunnel.
      sudo netstat -tulnp | grep -i stunnel # Confirm that the tunnels started
      redis-cli -h localhost -p 6379 -a <password>
    ```

- Why does my session timeout every 20 min?

  Session Manager enables you to specify the amount of time to allow a user to be inactive before a session ends. By default, sessions time out after 20 minutes of inactivity. You can [modify this](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-preferences-timeout.html) setting to specify that a session times out between 1 and 60 minutes of inactivity.

- I want to make use of Private IPv4 address but I do not have a dedicated network to AWS, is there an alternative?

  Yes, it is possible by using PrivateLink. PrivateLink [costs](https://aws.amazon.com/privatelink/pricing/) per endpoint. For more details please refer to https://docs.aws.amazon.com/systems-manager/latest/userguide/setup-create-vpc.html

- Where can I see the session activity logs?

  Please refer to https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-logging.html

- Are the sessions encrypted?

  Session Manager exchanges data between a client and a managed instance over a secure channel that is encrypted using TLS 1.2
  Please follow this [link](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager.html#what-is-a-session) for more details.

- How can I enable AWS KMS CMK encryption of the session data ?

  Please follow the steps included in this [link](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-preferences-enable-encryption.html).

- I have enabled the KMS Encryption for the Session Manager and I get this error when I am trying to connect to the Turbot Bastion Host?

  Error: `"Encountered error while initiating handshake. Fetching data key failed"`.

  Update the CFN template parameter `KMSEncryptionKeyArn` under the CFN label "Session Manager Preferences" with the KMS Key ARN used in the Session Manager KMS encryption.
  After which you should be able to login to the session and should see a welcome message that says `This session is encrypted using AWS KMS`.

- I want to manage the keys for my CloudWatch LogGroup used for Session Manager.
  Please refer to this [link](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/encrypt-log-data-kms.html).

  NOTE: CloudWatch Logs supports only symmetric CMKs. Do not use an associate an asymmetric CMK with your log group. For more information, see [Using Symmetric and Asymmetric Keys](https://docs.aws.amazon.com/kms/latest/developerguide/symmetric-asymmetric.html).

- While associating the KMS CMK Key to the CloudWatch Loggroup, I get the error:
  `The specified KMS key does not exist or is not allowed to be used with LogGroup 'arn:<partition>:logs:<region>:<account_id>:log-group:<log_group_name>'`

  The CloudWatch Log Group should be able to access the KMS CMK. Use can refer to the below Policy.

```json
{
  "Sid": "Allow CloudWatch Log Group for Session Manager to access the Key",
  "Effect": "Allow",
  "Principal": {
    "Service": "logs.<aws_region_like_us-east-1>.amazonaws.com"
  },
  "Action": [
    "kms:Encrypt*",
    "kms:Decrypt*",
    "kms:ReEncrypt*",
    "kms:GenerateDataKey*",
    "kms:Describe*"
  ],
  "Resource": "*",
  "Condition": {
    "ArnEquals": {
      "kms:EncryptionContext:aws:logs:arn": "arn:<partition>:logs:<aws_region>:<aws_account_id>:log-group:<loggroup_name_used>"
    }
  }
}
```

- Where can I get more Troubleshooting steps for Session Manager.

  https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-troubleshooting.html
