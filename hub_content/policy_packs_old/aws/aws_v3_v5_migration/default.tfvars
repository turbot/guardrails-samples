# These variables are intended to be run in a migration scenario moving from v3 to v5.  See README.md for more detail.

# Set to `true` if you don't have a logging solution already.
logging_buckets = true

# The bucket naming conventions between v3 and v5 are sufficiently different that there shouldn't be any name collisions.  
# If you need to change the bucket prefix for some reason, here's the parameter:

# Optional - Customised prefix
# logging_bucket_prefix = "turbot5-"

# Set to `true` if you want Turbot to manage service logging for you.  This policy will deploy auxiliary IAM roles into the accounts.
service_roles = false

# Set to `true` if you want to use Turbot CloudTrails.  
# If you already have CloudTrail configured, then turning this on is just extra cost.
turbot_cloudtrails = true

# Optional - Customised prefix
# turbot_cloudtrails_prefix = "turbot_"

# Set to `true` if you want to deploy the Event Handlers.
# By default, there will be name collisions between the v3 and v5 event handlers. The provided prefix avoids this problem.
event_handlers_enabled = true

# Optional - Customised prefix
# event_handlers_prefix  = "turbot5_"

aws_approved_regions = [
  "us-east-2",
  "us-east-1",
  "us-west-1",
  "us-west-2",
  "ap-south-1",
  "ap-northeast-3",
  "ap-northeast-2",
  "ap-southeast-1",
  "ap-southeast-2",
  "ap-northeast-1",
  "ca-central-1",
  "eu-central-1",
  "eu-west-1",
  "eu-west-2",
  "eu-west-3",
  "eu-north-1",
  "sa-east-1"
]

