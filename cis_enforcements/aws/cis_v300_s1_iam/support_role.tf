# AWS > IAM > Stack
resource "turbot_policy_setting" "aws_iam_stack" {
  resource = turbot_smart_folder.aws_cis_v300_s1_iam.id
  type     = "tmod:@turbot/aws-iam#/policy/types/iamStack"
  note     = "AWS CIS v3.0.0 - Controls:  1.17"
  value    = "Check: Configured"
  # value    = "Enforce: Configured"

}

# AWS > IAM > Stack > Source
resource "turbot_policy_setting" "aws_iam_stack_source" {
  resource       = turbot_smart_folder.aws_cis_v300_s1_iam.id
  type           = "tmod:@turbot/aws-iam#/policy/types/iamStackSource"
  note           = "AWS CIS v3.0.0 - Controls:  1.17"
  template_input = <<EOT
  {
    account  {
      Id
      metadata
    }
  }
  EOT
  template       = <<EOT
  |
  resource "aws_iam_role" "aws_support_role" {
    name = "AWSSupportRole"
    managed_policy_arns = [
      "arn:aws:iam::aws:policy/AWSSupportAccess"
    ]
    assume_role_policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = "sts:AssumeRole"
          Effect = "Allow"
          Principal = {
              "AWS": "arn:{{ $.account.metadata.aws.partition }}:::{{ $.account.Id }}:root"
          }
        },
      ]
    })
  }
  EOT
}

# AWS > IAM > Stack > Terraform Version
resource "turbot_policy_setting" "aws_iam_iam_stack_terraform_version" {
  resource = "320670689088314"
  type     = "tmod:@turbot/aws-iam#/policy/types/iamStackTerraformVersion"
  note     = "AWS CIS v3.0.0 - Controls:  1.17"
  # The `jsonencode()` function is not supported in Terraform 0.11.*.  Run with 0.15.* instead.
  value = "0.15.*"
}