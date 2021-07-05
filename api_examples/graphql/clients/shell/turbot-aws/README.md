# Turbot AWS

Easily use the AWS Command Line Interface with multiple Turbot accounts.

## Synopsis

```
turbot-aws [options] <aws-command> <aws-subcommand> [aws-parameters]
```

Use aws command help for information on a  specific  command.  Use  aws
help topics to view a list of available help topics.

## Options

```
--host=<host>
```

Use the Turbot cluster at <host> (e.g. turbot.example.com). This is the
host and port only (e.g. custom.example.com:8443), and does NOT include
the scheme or path (i.e. DO NOT use https://custom.example.com:8443/).

May also be set with the TURBOT_HOST environment variable, or set
in the AWS config file as default.turbot_host (recommended).

```
--access-key-id=<accessKeyId>
```

The Turbot Access Key ID <accessKeyId> that will be used to connect to
the Turbot API at <host> to obtain AWS credentials.

May also be set with the TURBOT_ACCESS_KEY_ID environment variable, or
set in the AWS config file as default.turbot_access_key_id (recommended).

```
--secret-access-key=<secretAccessKey>
```

The Turbot Secret Access Key <secretAccessKey> that will be used to
connect to the Turbot API at <host> to obtain AWS credentials.

May also be set with the TURBOT_SECRET_ACCESS_KEY environment variable,
or set in the AWS config file as default.turbot_secret_access_key
(recommended).

```
--account-id=<accountId>
-a <accountId>
```

Use Turbot account <accountId> (e.g. abc) for the AWS CLI command.

May also be set with the TURBOT_ACCOUNT_ID environment variable, or set
in the AWS config file as default.turbot_account_id.

```
--user-id=<userId>
-u <userId>
```

DEPRECATED - Turbot Classic users (v1.x) ONLY. Not supported by
Directory Profiles introduced in v2.x.

The user (e.g. joe@example.com) whose AWS credentials will be used for
access to the AWS account. That is, login to the AWS account connected
to Turbot account <accountId> using credentials for the Turbot user
<userId>.

May also be set with the TURBOT_USER_ID environment variable, or set
in the AWS config file as default.turbot_user_id.

Note: The <userId> for AWS access can be different to the Turbot user
requesting access. For example, AWS/SuperUser jane@example.com can
use turbot-aws to request and use AWS credentials to impersonate
joe@example.com. In that case, the Turbot <accessKeyId> and <secretKeyId>
below are Jane's, while the <userId> for the request is joe@example.com.

```
--refresh
```

turbot-aws caches AWS credentials in the AWS config file. These are
automatically refreshed on expiration, but --refresh can be used to
force an immediate refresh of the AWS credentials.

```
--delete
```

turbot-aws caches AWS credentials in the AWS config file. Use --delete
to clear this information.

```
--verbose
-v
-vv
```

Output detailed information about the actions of turbot-aws, providing
insight into actions and errors. -vv is used for more detailed debug
information.

## Configuration

Similar to the AWS CLI, turbot-aws is configured with Turbot API Access
keys. These Turbot credentials are then used for Turbot API calls to
retrieve various AWS credentials for different users in different AWS
accounts.

Per the options above, turbot-aws supports command line, environment
variables and the AWS config file for settings. It's recommended to
establish base Turbot API credentials in the AWS config file before using
turbot-aws.

```
aws configure set default.turbot_host turbot.example.com
aws configure set default.turbot_access_key_id 44829bc4-c682-4f3d-b14c-af77b8728bcb
aws configure set default.turbot_secret_access_key 1d1cc2ce-c0ba-4997-9b28-fd850fe51f7c
aws configure set default.turbot_user_id jane@example.com
```

If you are usually accessing the same account (e.g. abc) for AWS CLI
commands, you can also set the default account:

aws configure set default.turbot_account_id abc

## Examples

turbot-aws is a simple wrapper around the AWS CLI. All AWS CLI commands
can be used, turbot-aws simply creates credentials for the following
command.

These examples assume the configuration above has been setup.

### List S3 buckets in the default account

turbot-aws s3 ls

### List S3 buckets in account abb

turbot-aws --account-id=abb s3 ls

### List EC2 instances in eu-west-1 of the default account

turbot-aws ec2 describe-instances --region eu-west-1

### Inspect details of the turbot-aws command

turbot-aws -vv s3 ls

### Set the account ID using an environment variable

TURBOT_ACCOUNT_ID=abb turbot-aws s3 ls
