#!/bin/bash


#
# Usage and help
#

function log_usage {
  cat << EOF

usage: turbot-aws [options] <aws-command> <aws-subcommand> [aws-parameters]
help:  turbot-aws --help

EOF

}

function log_help {

  cat << EOF

NAME
       turbot-aws

DESCRIPTION
       Easily use the AWS Command Line Interface with multiple Turbot accounts.

SYNOPSIS

       turbot-aws [options] <aws-command> <aws-subcommand> [aws-parameters]

       Use aws command help for information on a  specific  command.  Use  aws
       help topics to view a list of available help topics.

OPTIONS

       --host=<host>

       Use the Turbot cluster at <host> (e.g. turbot.example.com). This is the
       host and port only (e.g. custom.example.com:8443), and does NOT include
       the scheme or path (i.e. DO NOT use https://custom.example.com:8443/).

       May also be set with the TURBOT_HOST environment variable, or set
       in the AWS config file as default.turbot_host (recommended).

       --access-key-id=<accessKeyId>

       The Turbot Access Key ID <accessKeyId> that will be used to connect to
       the Turbot API at <host> to obtain AWS credentials.

       May also be set with the TURBOT_ACCESS_KEY_ID environment variable, or
       set in the AWS config file as default.turbot_access_key_id (recommended).

       --secret-access-key=<secretAccessKey>

       The Turbot Secret Access Key <secretAccessKey> that will be used to
       connect to the Turbot API at <host> to obtain AWS credentials.

       May also be set with the TURBOT_SECRET_ACCESS_KEY environment variable,
       or set in the AWS config file as default.turbot_secret_access_key
       (recommended).

       --account-id=<accountId>
       -a <accountId>

       Use Turbot account <accountId> (e.g. abc) for the AWS CLI command.

       May also be set with the TURBOT_ACCOUNT_ID environment variable, or set
       in the AWS config file as default.turbot_account_id.

       --user-id=<userId>
       -u <userId>

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

       --refresh

       turbot-aws caches AWS credentials in the AWS config file. These are
       automatically refreshed on expiration, but --refresh can be used to
       force an immediate refresh of the AWS credentials.

       --delete

       turbot-aws caches AWS credentials in the AWS config file. Use --delete
       to clear this information.

       --verbose
       -v
       -vv

       Output detailed information about the actions of turbot-aws, providing
       insight into actions and errors. -vv is used for more detailed debug
       information.

CONFIGURATION

       Similar to the AWS CLI, turbot-aws is configured with Turbot API Access
       keys. These Turbot credentials are then used for Turbot API calls to
       retrieve various AWS credentials for different users in different AWS
       accounts.

       Per the options above, turbot-aws supports command line, environment
       variables and the AWS config file for settings. It's recommended to
       establish base Turbot API credentials in the AWS config file before using
       turbot-aws.

       aws configure set default.turbot_host turbot.example.com
       aws configure set default.turbot_access_key_id 44829bc4-c682-4f3d-b14c-af77b8728bcb
       aws configure set default.turbot_secret_access_key 1d1cc2ce-c0ba-4997-9b28-fd850fe51f7c
       aws configure set default.turbot_user_id jane@example.com

       If you are usually accessing the same account (e.g. abc) for AWS CLI
       commands, you can also set the default account:

       aws configure set default.turbot_account_id abc

EXAMPLES

       turbot-aws is a simple wrapper around the AWS CLI. All AWS CLI commands
       can be used, turbot-aws simply creates credentials for the following
       command.

       These examples assume the configuration above has been setup.

       # List S3 buckets in the default account
       turbot-aws s3 ls

       # List S3 buckets in account abb
       turbot-aws --account-id=abb s3 ls

       # List EC2 instances in eu-west-1 of the default account
       turbot-aws ec2 describe-instances --region eu-west-1

       # Inspect details of the turbot-aws command
       turbot-aws -vv s3 ls

       # Set the account ID using an environment variable
       TURBOT_ACCOUNT_ID=abb turbot-aws s3 ls

EOF

}

#
# Logging
#

function log_debug {
  if [ "$TURBOT_LOG" -ge 4 ]; then
    echo "Turbot: DEBUG: $@"
  fi
}

function log_info {
  if [ "$TURBOT_LOG" -ge 3 ]; then
    echo "Turbot: INFO: $@"
  fi
}

function log_error {
  if [ "$TURBOT_LOG" -ge 1 ]; then
    echo "Turbot: ERROR: $@" 1>&2
  fi
}


#
# Parse arguments to turbot-aws
#
# Turbot configuration is defined in:
#  1. Command line options (e.g. --access-key-id)
#  2. Environment variables (e.g. TURBOT_ACCESS_KEY_ID)
#  3. AWS config file (e.g. turbot_access_key_id in ~/.aws/config)

# Capture the original parameters for logging output before
# we consume them setting Turbot options.
TURBOT_PARAMS=$@

while [ "$#" -gt 0 ]; do
  case "$1" in

    --account-id=*)
      TURBOT_ACCOUNT_ID="${1#*=}"
      shift 1
      ;;

    -a)
      TURBOT_ACCOUNT_ID="$2"
      shift 2
      ;;

    --user-id=*)
      TURBOT_USER_ID="${1#*=}"
      shift 1
      ;;

    -u)
      TURBOT_USER_ID="$2"
      shift 2
      ;;

    --host=*)
      TURBOT_HOST="${1#*=}"
      shift 1
      ;;

    --access-key-id=*)
      TURBOT_ACCESS_KEY_ID="${1#*=}"
      shift 1
      ;;

    --secret-access-key=*)
      TURBOT_SECRET_ACCESS_KEY="${1#*=}"
      shift 1
      ;;

    --delete)
      TURBOT_DELETE=true
      shift 1
      ;;

    --refresh)
      TURBOT_FORCE_REFRESH=true
      shift 1
      ;;

    --verbose)
      TURBOT_LOG=3
      shift 1
      ;;

    -v)
      TURBOT_LOG=3
      shift 1
      ;;

    -vv)
      TURBOT_LOG=4
      shift 1
      ;;

    --help)
      TURBOT_HELP=true
      shift 1
      ;;

    -h)
      TURBOT_HELP=true
      shift 1
      ;;

    *) break;

  esac
done

TURBOT_LOG=${TURBOT_LOG:-1}
log_info "Log Level: ${TURBOT_LOG} (0=None, 1=Error, 2=Warn, 3=Info, 4=Debug)"

log_info "Program: $0"
log_info "Parameters: $TURBOT_PARAMS"
log_info "Parameters left for aws after turbot-aws config: $@"



#
# Ensure that the AWS CLI is installed
#

command -v aws >/dev/null 2>&1
if [ $? -ne 0 ]; then
  log_error "turbot-aws requires the AWS CLI (aws) to be installed."
  log_usage
  exit $?
fi


if [ "$TURBOT_HELP" = true ]; then
  log_help
  exit 0
fi


#
# Get the Turbot profile from AWS config
#

TURBOT_ACCOUNT_ID=${TURBOT_ACCOUNT_ID:-`aws configure get default.turbot_account_id 2>/dev/null | tr -d '\r'`}
log_info "Account ID: ${TURBOT_ACCOUNT_ID}"

if [ ! "$TURBOT_ACCOUNT_ID" ]; then
  log_error "A Turbot Account ID must be specified for turbot-aws."
  log_usage
  exit 1
fi

TURBOT_USER_ID=${TURBOT_USER_ID:-`aws configure get default.turbot_user_id 2>/dev/null | tr -d '\r'`}
log_info "User ID: ${TURBOT_USER_ID}"

if [ ! "$TURBOT_USER_ID" ]; then
  TURBOT_PROFILE=turbot__${TURBOT_ACCOUNT_ID}
else
  TURBOT_PROFILE=turbot__${TURBOT_ACCOUNT_ID}__${TURBOT_USER_ID}
fi
log_info "Using AWS config profile: ${TURBOT_PROFILE}"



#
# Refresh AWS credentials (if required)
#

TURBOT_FORCE_REFRESH=${TURBOT_FORCE_REFRESH:-false}
log_info "Force refresh of AWS credentials: ${TURBOT_FORCE_REFRESH}"

# By default, we don't refresh the credentials
TURBOT_REFRESH=false

if [ "$TURBOT_FORCE_REFRESH" = true ]; then
  # Refresh explicitly forced
  TURBOT_REFRESH=true
  log_debug "AWS credentials will be refreshed: Forced by --refresh"
else

  # Get the expiration time for these credentials from the AWS config file. If
  # these credentials are new this returns an empty string which works fine with
  # the comparison test below.
  # Suppress errors in this case since the profile may not be defined and produces
  # an ugly error message.
  TS_EXP=`aws configure --profile $TURBOT_PROFILE get aws_expire_time 2>/dev/null | tr -d '\r'`
  log_debug "Current AWS credentials for $TURBOT_PROFILE expire at: $TS_EXP"

  # Get the current time, in a Javascript compatible ISO8601 format
  TS_NOW=`date -u +%FT%T.000Z`
  log_debug "Current time is: $TS_NOW"

  if [[ "$TS_EXP" < "$TS_NOW" ]]; then
    TURBOT_REFRESH=true
    log_debug "AWS credentials will be refreshed: Cached credentials expired at $TS_EXP"
  fi

fi

if [ "$TURBOT_REFRESH" = true ]; then

  log_debug "Refreshing AWS credentials for profile: $TURBOT_PROFILE"

  TURBOT_HOST=${TURBOT_HOST:-`aws configure get default.turbot_host 2>/dev/null | tr -d '\r'`}
  log_info "Host: ${TURBOT_HOST}"

  if [ ! "$TURBOT_HOST" ]; then
    log_error "A Turbot Host must be specified for turbot-aws."
    log_usage
    exit 1
  fi

  TURBOT_URL="${TURBOT_URL:-https://$TURBOT_HOST}"
  log_info "URL: ${TURBOT_URL}"

  TURBOT_ACCESS_KEY_ID=${TURBOT_ACCESS_KEY_ID:-`aws configure get default.turbot_access_key_id 2>/dev/null | tr -d '\r'`}
  log_info "Access Key ID: ${TURBOT_ACCESS_KEY_ID}"

  if [ ! "$TURBOT_ACCESS_KEY_ID" ]; then
    log_error "A Turbot Access Key ID must be specified for turbot-aws."
    log_usage
    exit 1
  fi

  TURBOT_SECRET_ACCESS_KEY=${TURBOT_SECRET_ACCESS_KEY:-`aws configure get default.turbot_secret_access_key 2>/dev/null | tr -d '\r'`}
  log_info "Secret Access Key: ********-****-****-****-********${TURBOT_SECRET_ACCESS_KEY:(-4)}"

  if [ ! "$TURBOT_SECRET_ACCESS_KEY" ]; then
    log_error "A Turbot Secret Access Key must be specified for turbot-aws."
    log_usage
    exit 1
  fi

  # If the access keys belong to a directory profile, then we can get the response immediately
  TURBOT_CREDS_URL="${TURBOT_URL}/api/v5/graphql"
  TURBOT_USER="$TURBOT_ACCESS_KEY_ID:$TURBOT_SECRET_ACCESS_KEY"
  TURBOT_DATA='{"query":"{\n    aws {\n      userCredentials(account: \"arn:aws:::'$TURBOT_ACCOUNT_ID'\", user: \"'$TURBOT_USER_ID'\") {\n        accessKeyId\n        secretAccessKey\n        sessionToken\n        expiration\n      }\n    }\n} ","variables":{}}'
  log_debug "Retrieving AWS credentials for Profile $TURBOT_ACCOUNT_ID from: $TURBOT_CREDS_URL"
  TURBOT_CREDS_JSON=`curl --fail --silent --insecure --request POST "$TURBOT_CREDS_URL" --user "$TURBOT_USER" --header "Content-Type: application/json" --data-raw "$TURBOT_DATA"`

  if [ $? -eq 0 ]; then
    log_debug "AWS credentials from Turbot: $TURBOT_CREDS_JSON"
  else

    log_debug "Failed to retrieve AWS credentials for Profile in $TURBOT_ACCOUNT_ID: $TURBOT_CREDS_JSON"
    # Output the actual failure for debugging purposes. We need --fail above to
    # detect the problem, but that suppresses the error information. Run again
    # capturing it.
    TURBOT_CREDS_JSON=`curl --silent --insecure --request POST "$TURBOT_CREDS_URL" --user "$TURBOT_USER" --header "Content-Type: application/json" --data-raw "$TURBOT_DATA"`

    log_error $TURBOT_CREDS_JSON
    log_usage
    exit $?
  fi

  AWS_ACCESS_KEY_ID=`echo $TURBOT_CREDS_JSON | sed 's/.*"accessKeyId":"\([^"]*\)".*/\1/g'`
  log_debug "AWS Access Key ID: $AWS_ACCESS_KEY_ID"
  AWS_SECRET_ACCESS_KEY=`echo $TURBOT_CREDS_JSON | sed 's/.*"secretAccessKey":"\([^"]*\)".*/\1/g'`
  log_debug "AWS Secret Access Key: $AWS_SECRET_ACCESS_KEY"
  AWS_SESSION_TOKEN=`echo $TURBOT_CREDS_JSON | sed 's/.*"sessionToken":"\([^"]*\)".*/\1/g'`
  log_debug "AWS Session Token: $AWS_SESSION_TOKEN"
  AWS_EXPIRE_TIME=`echo $TURBOT_CREDS_JSON | sed 's/.*"expiration":"\([^"]*\)".*/\1/g'`
  log_debug "AWS Expire Time: $AWS_EXPIRE_TIME"

  aws configure --profile $TURBOT_PROFILE set aws_access_key_id $AWS_ACCESS_KEY_ID
  aws configure --profile $TURBOT_PROFILE set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
  aws configure --profile $TURBOT_PROFILE set aws_session_token $AWS_SESSION_TOKEN
  aws configure --profile $TURBOT_PROFILE set aws_expire_time $AWS_EXPIRE_TIME

else

  log_debug "Using cached AWS credentials for profile: $TURBOT_PROFILE"

fi



#
# Run the aws command
#

log_info "Running aws command: aws --profile $TURBOT_PROFILE $@"
aws --profile $TURBOT_PROFILE $@


#
# Delete the credentials (if requested)
#

TURBOT_DELETE=${TURBOT_DELETE:-false}
log_info "Delete AWS credentials: ${TURBOT_DELETE}"

if [ "$TURBOT_DELETE" = true ]; then

  aws configure --profile $TURBOT_PROFILE set aws_access_key_id ""
  aws configure --profile $TURBOT_PROFILE set aws_secret_access_key ""
  aws configure --profile $TURBOT_PROFILE set aws_session_token ""
  aws configure --profile $TURBOT_PROFILE set aws_expire_time ""

fi
