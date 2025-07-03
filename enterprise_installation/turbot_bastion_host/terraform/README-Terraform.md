# Turbot Bastion Host (Terraform)

This Terraform configuration deploys a Turbot Bastion Host in your AWS environment. 

Turbot Bastion Host is used to connect to the resources like RDS Host living in the Turbot Enterprise for basic toubleshooting purposes.
It leverages AWS EC2 instance(s) managed by [Session Manager](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager.html) and can be accessed only through the browser-based interface i.e, [Systems Manager Console](https://console.aws.amazon.com/systems-manager/). Below are the key benefits that Turbot Bastion host offers.

- Eliminates the need for IAM users and SSH keys.
- Eliminates the need for Inbound Security Group rules over port 22.
- Grabs the latest Amazon Linux 2023 AMI using SSM Parameters.
- Gives the ability to use custom configurations for AMIs and IAM Roles.
- Self-destructs after the desired number of hours.
- Comes with psql v15.x and redis-cli v6.x

In addition to the above, it also compliments the Session Manager capabilities such as

- Sessions are secured using an AWS Key Management Service key.
- You can log session commands and details in an Amazon S3 bucket or CloudWatch Logs log group.

## 1. Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed
- AWS CLI installed and configured (`aws configure`)
- IAM permissions to deploy infrastructure and use Systems Manager
- A public subnet ID for deployment

## 2. Deployment Instructions

### Step 1: Prepare Terraform variables

Create a `terraform.tfvars` file and define the required variables. Below is an example:

```hcl
# Required variables
bastion_host_name       = "turbot-bastion-host"
region                  = "us-east-1"
public_subnet_id        = "subnet-xxxxx"
latest_ami_ssm_param    = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"

# Optional variables
bastion_instance_type   = "t3.large"
root_volume_size        = 100
lifetime_hours          = 6
alternative_iam_role    = ""
```

> Replace `public_subnet_id` with the subnet-id of the public subnet you want to deploy the bastion into. 

> Replace `region` with the AWS Region code you're deploying the bastion in. 

Alternatively, if you're good with the default values for the other variables, you can skip creating the `terraform.tfvars` file and instead provide the `public-subnet-id` and `region` values on the command-line:

```bash
terraform plan \
  -var="public_subnet_id=subnet-0c9196c716c39a909" \
  -var="region=us-east-1"
```

### Step 2: Initialize Terraform

```bash
terraform init
```

### Step 3: Review the plan

```bash
terraform plan
```

### Step 4: Apply the configuration

```bash
terraform apply
```

## 3. Variable Reference

| Variable Name           | Required | Default                                                                 | Description                                                                 |
|------------------------|----------|-------------------------------------------------------------------------|-----------------------------------------------------------------------------|
| `public_subnet_id`      | Yes      |                                                                         | Subnet ID to deploy the Bastion Host into (must be a public subnet).        |
| `region`                | Yes      |                                                                         | AWS region for deployment.                                                  |
| `alternative_iam_role`  | No       | `""`                                                                    | Optional IAM role name to attach instead of creating a new role.            |
| `bastion_host_name`     | No       | `t3.large`                                                              | The name for the Bastion Host resources. Will be sanitized.                 |
| `bastion_instance_type` | No       | `t3.large`                                                              | EC2 instance type.                                                          |
| `latest_ami_ssm_param`  | No       | `/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64` | SSM parameter name for the AMI.                                             |
| `lifetime_hours`        | No       | `6`                                                                     | Time in hours before the Bastion Host shuts itself down.                    |
| `public_ipv4_address`   | No       | `True`                                                                  | Determines whether the bastion host is assigned a public IPv4 address.      |
| `root_volume_size`      | No       | `100`                                                                   | Root EBS volume size in GB.                                                 |


## 4. Connect to Bastion

You can connect to the Bastion Host using AWS Systems Manager Session Manager.

### Retrieve the Bastion Instance ID

You can use the AWS CLI to retrieve the instance ID of your Bastion Host by its name tag:

```bash
aws ec2 describe-instances \
  --filters \
    "Name=tag:Name,Values=turbot-bastion-host" \
    "Name=instance-state-name,Values=running" \
  --query "Reservations[*].Instances[*].InstanceId" \
  --output text
```

> Replace `turbot-bastion-host` with the value of your `bastion_host_name` variable if different.

### Start a session using AWS CLI

Once you have the instance ID:

```bash
aws ssm start-session --target i-xxxxxxxxxxxxxxxxx
```

> Replace `i-xxxxxxxxxxxxxxxxx` with your actual instance ID.

Make sure you have the necessary IAM permissions and that SSM Agent is running on the instance.

## 5. Notes

- The Bastion Host is automatically shut down after `lifetime_hours`.
- The instance uses Amazon Linux 2 with SSM Agent pre-installed.
- You must have `ssm:StartSession`, `ssm:DescribeSessions`, and `ec2:DescribeInstances` permissions to connect.

## 6. FAQ

### Why is the Bastion Host not connecting?

Ensure the following:

- The instance is in a public subnet.
- The instance has internet access (via IGW).
- SSM Agent is running.
- Proper IAM permissions are attached.

### Can I override the IAM role?

Yes. Use the `alternative_iam_role` variable to attach an existing IAM role instead of creating a new one.

### Are spaces allowed in `bastion_host_name`?

No. Terraform will sanitize the name by replacing unsupported characters with `-`.

### How do I connect to my RDS Instance?
    
The `db-connect.sh` script provides a list of RDS instances in a given region and makes it easy to connect.
**db-connect.sh**
```shell
sh-5.2$ db-connect.sh
AWS region could not be detected. Please enter the AWS region: us-east-2
Available RDS Instances in region us-east-2:
lancer-hubble   lancer-pluto
Enter the DBInstanceIdentifier you want to connect to: lancer-pluto
Using RDS host: lancer-pluto.abcdefghij.us-east-2.rds.amazonaws.com
Connecting to the database using psql...
psql (15.8, server 13.16)
SSL connection (protocol: TLSv1.2, cipher: ECDHE-RSA-AES256-GCM-SHA384, compression: off)
Type "help" for help.
turbot=>
```

If `db-connect.sh` doesn't work for some reason, the steps can be carried out manually as shown below. 
**manually**
```bash
aws rds describe-db-instances --query 'DBInstances[*].DBInstanceIdentifier'
aws rds describe-db-instances --db-instance-identifier <DBInstanceIdentifier> --query 'DBInstances[0].Endpoint.Address'

export RDSHOST=<Enter the RDS endpoint, example: turbot-boltzman.cpnkkknwkny9.us-east-2.rds.amazonaws.com>
export PGPASSWORD="$(aws rds generate-db-auth-token --hostname $RDSHOST --port 5432 --region <AWS region of the DB, example: us-east-1> --username turbot )"
psql -h $RDSHOST  -d turbot -U turbot
```

### How do I connect to my Redis Cluster?

<!-- - Capture the Redis user password from AWS SSM Parameters Store with parameter name /<prefix>/hive/<hive_name>/redisUser -->

```bash
aws elasticache describe-cache-clusters --show-cache-node-info --query 'CacheClusters[?Engine==`redis`].CacheNodes[*].Endpoint' --output text

redis-cli -h <Redis Primary endpoint example: master.turbot-hive-cache-cluster.xyzxyz.use2.cache.amazonaws.com> --tls -p 6379
AUTH <password>
```
Please note the primary endpoint above should not include the port number.

### Why does my session timeout every 20 min?

Session Manager enables you to specify the amount of time to allow a user to be inactive before a session ends. By default, sessions time out after 20 minutes of inactivity. You can [modify this](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-preferences-timeout.html) setting to specify that a session times out between 1 and 60 minutes of inactivity.

### I want to make use of Private IPv4 address but I do not have a dedicated network to AWS, is there an alternative?

Yes, it is possible by using PrivateLink. PrivateLink [costs](https://aws.amazon.com/privatelink/pricing/) per endpoint. For more details please refer to https://docs.aws.amazon.com/systems-manager/latest/userguide/setup-create-vpc.html

###  Where can I see the session activity logs?

Please refer to https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager-logging.html

### Are the sessions encrypted?

Session Manager exchanges data between a client and a managed instance over a secure channel that is encrypted using TLS 1.2
Please follow this [link](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager.html#what-is-a-session) for more details.

### How can I enable AWS KMS CMK encryption of the session data ?

Please follow the steps included in this [link](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-preferences-enable-encryption.html).

### I have enabled the KMS Encryption for the Session Manager and I get this error when I am trying to connect to the Turbot Bastion Host?

Error: `"Encountered error while initiating handshake. Fetching data key failed"`.

Update the CFN template parameter `KMSEncryptionKeyArn` under the CFN label "Session Manager Preferences" with the KMS Key ARN used in the Session Manager KMS encryption.
After which you should be able to login to the session and should see a welcome message that says `This session is encrypted using AWS KMS`.

### I want to manage the keys for my CloudWatch LogGroup used for Session Manager.

Please refer to this [link](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/encrypt-log-data-kms.html).

NOTE: CloudWatch Logs supports only symmetric CMKs. Do not use an associate an asymmetric CMK with your log group. For more information, see [Using Symmetric and Asymmetric Keys](https://docs.aws.amazon.com/kms/latest/developerguide/symmetric-asymmetric.html).

### While associating the KMS CMK Key to the CloudWatch Loggroup, I get the error:

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

---

This `README-Terraform.md` corresponds to the Terraform-based deployment of the Turbot Bastion Host and mirrors the capabilities of the original CloudFormation-based deployment.
