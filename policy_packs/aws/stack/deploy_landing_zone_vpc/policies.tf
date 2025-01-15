# AWS > VPC > Stack [Native]
resource "turbot_policy_setting" "aws_vpc_stack" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-vpc-core#/policy/types/vpcServiceStackNative"
  value    = "Check: Configured"
  # value    = "Enforce: Configured"
}

# AWS > VPC > Stack [Native] > Variables
resource "turbot_policy_setting" "aws_vpc_stack_variables" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-vpc-core#/policy/types/vpcServiceStackNativeVariables"
  value = <<EOT
    tag_prefix           = "guardrails_"
    public_subnet_count  = 2
    private_subnet_count = 2
    max_azs              = 2

    ## map of ip addresses to assign, by account-alias, then region
    ip_assignments = {
        gnb-aaa-us-east-1 = "10.100.8.0/22"
        gnb-aaa-us-west-2 = "10.104.8.0/22"
        gnb-bbb-us-east-1 = "10.108.8.0/22"
        gnb-bbb-us-west-2 = "10.112.8.0/22"
        gnb-ccc-us-east-1 = "10.116.8.0/22"
        gnb-ccc-us-west-2 = "10.120.8.0/22"
        gnb-ddd-us-east-1 = "10.124.8.0/22"
        gnb-ddd-us-east-2 = "10.128.8.0/22"
    }
  EOT
}

#AWS > VPC > Stack [Native] > Source
resource "turbot_policy_setting" "aws_vpc_stack_source" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-vpc-core#/policy/types/vpcServiceStackNativeSource"
  value    = file("./stack/stack-source.hcl")
}
