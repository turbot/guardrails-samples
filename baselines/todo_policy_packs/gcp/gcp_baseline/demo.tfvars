# List of services and providers to set as Enabled  
# Enabling all by default, can comment out the services and APIs to reduce scope
# Make sure you have the mods installed if enabling / registering.  The default mod install baseline assumes all

# For Service Status, change the options per service:
# "Enabled"
# "Disabled"

service_status = {
  gcp-iam     = "Enabled"
  gcp-logging = "Enabled" ### Enabled in Real-Time events if turned on
  gcp-pubsub  = "Enabled" ### Enabled in Real-Time events if turned on
  gcp-storage = "Enabled"
}

# Set up the demo to use event handling
use_event_polling = false
