# AWS > VPC > VPC > Stack [Native]
resource "turbot_policy_setting" "aws_vpc_core_vpc_stack_native" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-vpc-core#/policy/types/vpcStackNative"
  # value    = "Check: Configured"
  value = "Enforce: Configured"
}

# AWS > VPC > VPC > Stack [Native] > Variables (Time-Limited)
# This policy setting provides variables with time-limited expiration
resource "turbot_policy_setting" "aws_vpc_core_vpc_stack_native_variables_with_exceptions" {
  count          = var.enable_time_limited_exceptions ? 1 : 0
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/aws-vpc-core#/policy/types/vpcStackNativeVariables"
  template_input = <<-EOT
    {
      resource {
        vpcId: get(path: "VpcId")
      }
    }
    EOT
  template       = <<-EOT
    {# VPC ID for the security group #}
    vpc_id = "{{ $.resource.vpcId }}"

    {# Add a tag key for the security group #}
    sg_tag_key   = "Environment"

    {# Add a tag value for the security group #}
    sg_tag_value = "Test"

    EOT

  # Set expiration timestamp on the variables
  valid_to_timestamp = timeadd(timestamp(), "${var.exception_duration_hours}h")
}

# AWS > VPC > VPC > Stack [Native] > Variables (No Exceptions - Permanent)
# This policy setting provides empty variables (no exceptions)
resource "turbot_policy_setting" "aws_vpc_core_vpc_stack_native_variables_no_exceptions" {
  count          = var.enable_time_limited_exceptions ? 0 : 1
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/aws-vpc-core#/policy/types/vpcStackNativeVariables"
  template_input = <<-EOT
    {
      resource {
        vpcId: get(path: "VpcId")
      }
    }
    EOT
  template       = <<-EOT
    {# No variables provided - will result in empty stack #}
    
    EOT
}

# AWS > VPC > VPC > Stack [Native] > Source (Always Present)
# This policy setting contains the source code and always exists
resource "turbot_policy_setting" "aws_vpc_core_vpc_stack_native_source" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-vpc-core#/policy/types/vpcStackNativeSource"

  # Always use the same source file - behavior controlled by variables
  value = file("./stack/source.tofu")
}

# AWS > VPC > VPC > Stack [Native] > Secret Variables
resource "turbot_policy_setting" "aws_vpc_core_vpc_stack_native_secret_variables" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-vpc-core#/policy/types/vpcStackNativeSecretVariables"
  value    = file("./stack/secret-variables.auto.tfvars")
}

# AWS > VPC > VPC > Stack [Native] > Modifier
# resource "turbot_policy_setting" "aws_vpc_core_vpc_stack_native_modifier" {
#   resource = turbot_policy_pack.main.id
#   type     = "tmod:@turbot/aws-vpc-core#/policy/types/vpcStackNativeModifier"
#   value    = <<-EOT
#      # Add your custom OpenTofu HCL here
# EOT
# }

# # AWS > VPC > VPC > Stack [Native] > Timeout
# resource "turbot_policy_setting" "aws_vpc_core_vpc_stack_native_timeout" {
#   resource = turbot_policy_pack.main.id
#   type     = "tmod:@turbot/aws-vpc-core#/policy/types/vpcStackNativeTimeout"
#   value    = "3600" # default is 1800
# }

# # AWS > VPC > VPC > Stack [Native] > Version
# resource "turbot_policy_setting" "aws_vpc_core_vpc_stack_native_version" {
#   resource = turbot_policy_pack.main.id
#   type     = "tmod:@turbot/aws-vpc-core#/policy/types/vpcStackNativeVersion"
#   value    = "*" # default is 1.8.*
# }

# # AWS > VPC > VPC > Stack [Native] > Drift Detection
# resource "turbot_policy_setting" "aws_vpc_core_vpc_stack_native_drift_detection" {
#   resource = turbot_policy_pack.main.id
#   type     = "tmod:@turbot/aws-vpc-core#/policy/types/vpcStackNativeDriftDetection"
#   # value    = "Skip"
#   # value    = "Run stack at Drift Detection > Interval"
#   # value    = "Run stack on resource update"
#   value = "Run stack on resource update and at Drift Detection > Interval"
# }

# # AWS > VPC > VPC > Stack [Native] > Drift Detection > Interval
# resource "turbot_policy_setting" "aws_vpc_core_vpc_stack_native_drift_detection_interval" {
#   resource = turbot_policy_pack.main.id
#   type     = "tmod:@turbot/aws-vpc-core#/policy/types/vpcStackNativeDriftDetectionInterval"
#   value    = "240" # default is 1440
# }
