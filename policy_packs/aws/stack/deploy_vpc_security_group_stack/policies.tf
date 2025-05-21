# AWS > VPC > VPC > Stack [Native]
resource "turbot_policy_setting" "aws_vpc_core_vpc_stack_native" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-vpc-core#/policy/types/vpcStackNative"
  value    = "Check: Configured"
  # value    = "Enforce: Configured"
}

# AWS > VPC > VPC > Stack [Native] > Variables
resource "turbot_policy_setting" "aws_vpc_core_vpc_stack_native_variables" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/aws-vpc-core#/policy/types/vpcStackNativeVariables"
  template_input = <<EOT
   {
     resource {
       vpcId: get(path: "VpcId")
     }
   }
   EOT
  template       = <<EOT
   {# VPC ID for the security group #}
   vpc_id = "{{ $.resource.vpcId }}"
   
   {# Add a trusted CIDR block for the security group #}
   trusted_cidr_block = "10.0.0.0/8"
   EOT
}

# AWS > VPC > VPC > Stack [Native] > Source
resource "turbot_policy_setting" "aws_vpc_core_vpc_stack_native_source" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-vpc-core#/policy/types/vpcStackNativeSource"
  value    = file("./stack/source.tofu")
}
