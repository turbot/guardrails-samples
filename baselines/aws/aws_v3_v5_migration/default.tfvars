# These variables are intended to be run in a migration scenario moving from v3 to v5.  See README.md for more detail.

# Set to `true` if you don't have a logging solution already.
logging_buckets = true

# The bucket naming conventions between v3 and v5 are sufficiently different that there shouldn't be any name collisions.  If you need to change the bucket prefix for some reason, here's the parameter:
logging_bucket_prefix = "turbot5-"


# Set to `true` if you want Turbot to manage service logging for you.  This policy will deploy auxiliary IAM roles into the accounts.
service_roles = false

# Set to `true` if you want to use Turbot CloudTrails.  If you already have CloudTrail configured, then turning this on is just extra cost.
turbot_cloudtrails = true
turbot_cloudtrails_prefix = "turbot_"

# Set to `true` if you want to deploy the Event Handlers.
# By default, there will be name collisions between the v3 and v5 event handlers. The provided prefix avoids this problem.
event_handlers_enabled = true
event_handlers_prefix = "turbot5_"
