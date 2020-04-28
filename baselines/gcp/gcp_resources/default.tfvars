
# gcp_project_id = "<name of the project id to be imported>"

# gcp_region = "<gcp region in which the resources are to be created, applicable for regional resources only>"

# resource_prefix = "<prefix for all the test resources about to be created"

# number_of_resources = "<number of custom roles to be created>"

gcp_project_id = "gcp-project-import-002"

gcp_region = "us-east1"

resource_prefix = "turbot_test_"
# Creates resources with the above prefix. Below are the examples:
# IAM Custom Role: turbot_test_topic_01
# IAM Service Account: turbot-test-sa01
# PubSub Topic: turbot_test_iam_custom_role_01
# Storage Bucket: turbot_test_bucket_01
number_of_resources = 75
