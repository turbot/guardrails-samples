# AWS > IAM > Stack
resource "turbot_policy_setting" "aws_iam_iam_stack" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/iamStack"
  value    = "Check: Configured"
  # value    = "Enforce: Configured"
}

# AWS > IAM > Role > Boundary > Policy
resource "turbot_policy_setting" "aws_iam_role_boundary_policy_preventative" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/roleBoundaryPolicy"
  value    = "testRole"
}

# AWS > IAM > Stack > Source
resource "turbot_policy_setting" "aws_iam_iam_stack_source" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/iamStackSource"
  value    = <<EOT
    ### Deny Actions from unapproved CIDRs ###
    resource "aws_iam_policy" "main" {
      name        = "testRole"
      path        = "/"
      description = "Turbot Managed Boundary policy to prevent actions from  unapproved CIDRs"
      policy      = jsonencode({
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": "*"
                "Resource": "*",
                "Condition": {
                    "IpAddress": {
                      "aws:SourceIp": [
                        "10.0.0.0/8",
                        "172.16.0.0/12",
                        "192.168.0.0/16",
                        "15.46.12.0/22",
                        "104.29.0.0/20"
                      ]
                    }
                }
            }
        ]
      })
    }
  EOT
}

# AWS > IAM > Role > Boundary
# Skip Boundary for Turbot IAM Role that is used to import the account.
resource "turbot_policy_setting" "ec2_sgr_deny_boundary_preventative" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/aws-iam#/policy/types/roleBoundary"
  template_input = <<EOT
  {
    resource {
      role_arn: get(path: "Arn")
      parent {
        turbot_iam_role: policyValue(uri: "tmod:@turbot/aws#/policy/types/turbotIamRole") {
          value
        }
      }
    }
  }
EOT
  template       = <<EOT
  {%- if $.resource.role_arn  == $.resource.parent.turbot_iam_role.value -%}
    "Skip"
  {%- else -%}
    "Enforce: Boundary > Policy"
  {%- endif -%}
EOT
}
