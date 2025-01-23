# AWS > IAM > Stack [Native]
resource "turbot_policy_setting" "aws_iam_stack" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/iamStackNative"
  value    = "Check: Configured"
  # value    = "Enforce: Configured"
}

# AWS > IAM > Stack [Native] > Variables
resource "turbot_policy_setting" "aws_iam_stack_variables" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/iamStackNativeVariables"
  value    = file("./stack/variables.auto.tfvars")
}

# AWS > IAM > Stack [Native] > Source
resource "turbot_policy_setting" "aws_iam_stack_source" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/iamStackNativeSource"

  # Create a stack, using the ./stack/source.tofu
  value    = file("./stack/source.tofu")

  # Destroy all resources in the stack
  # value = "{}"
}

# # AWS > IAM > Stack [Native] > Secret Variables
# resource "turbot_policy_setting" "aws_iam_stack_secret_variables" {
#   resource = turbot_policy_pack.main.id
#   type     = "tmod:@turbot/aws-iam#/policy/types/iamStackNativeSecretVariables"
#   value    = file("./stack/secret-variables.auto.tfvars")
# }

# # AWS > IAM > Stack [Native] > Modifier
# resource "turbot_policy_setting" "aws_iam_stack_modifier" {
#   resource = turbot_policy_pack.main.id
#   type     = "tmod:@turbot/aws-iam#/policy/types/iamStackNativeModifier"
#   value    = <<-EOT
#     # Add your custom OpenTofu HCL here
#   EOT
# }

# # AWS > IAM > Stack [Native] > Timeout
# resource "turbot_policy_setting" "aws_iam_stack_timeout" {
#   resource = turbot_policy_pack.main.id
#   type     = "tmod:@turbot/aws-iam#/policy/types/iamStackNativeTimeout"
#   value    = "3600"  # default is 1800
#  }

# # AWS > IAM > Stack [Native] > Version
# resource "turbot_policy_setting" "aws_iam_stack_version" {
#   resource = turbot_policy_pack.main.id
#   type     = "tmod:@turbot/aws-iam#/policy/types/iamStackNativeVersion"
#   value    = "*"  # default is 1.8.*
#  }

# # AWS > IAM > Stack [Native] > Drift Detection
# resource "turbot_policy_setting" "aws_iam_stack_drift_detection" {
#   resource = turbot_policy_pack.main.id
#   type     = "tmod:@turbot/aws-iam#/policy/types/iamStackNativeDriftDetection"
#   #value    = "Skip"
#   #value    = "Run stack at Drift Detection > Interval"
#   #value    = "Run stack on resource update"
#   value    = "Run stack on resource update and at Drift Detection > Interval"
# }

# # AWS > IAM > Stack [Native] > Drift Detection > Interval
# resource "turbot_policy_setting" "aws_iam_stack_drift_detection_interval" {
#   resource = turbot_policy_pack.main.id
#   type     = "tmod:@turbot/aws-iam#/policy/types/iamStackNativeDriftDetectionInterval"
#   value    = "240"  # default is 1440
#  }
