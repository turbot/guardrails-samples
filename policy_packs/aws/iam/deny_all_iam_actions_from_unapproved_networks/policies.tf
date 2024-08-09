# AWS > IAM > Stack
resource "turbot_policy_setting" "aws_iam_stack" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/iamStack"
  value    = "Check: Configured"
  # value    = "Enforce: Configured"
}

# AWS > IAM > Role > Boundary > Policy
resource "turbot_policy_setting" "aws_iam_role_boundary_policy" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/roleBoundaryPolicy"
  # Boundary policy name that will be applied to the IAM role.
  value = "myBoundaryPolicy"
}

# AWS > IAM > Stack > Source
resource "turbot_policy_setting" "aws_iam_stack_source" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-iam#/policy/types/iamStackSource"
  value    = <<EOT
    ### Deny Actions from unapproved CIDRs ###
    resource "aws_iam_policy" "main" {
      # Boundary policy name that will be applied to the IAM role.
      name        = "myBoundaryPolicy"
      path        = "/"
      description = "Guardrails Managed Boundary policy to prevent actions from unapproved CIDRs"
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
                        "0.0.0.0/0"
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
resource "turbot_policy_setting" "aws_iam_role_boundary" {
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
  {%- if $.resource.role_arn and $.resource.role_arn  != $.resource.parent.turbot_iam_role.value -%}

    "Check: Boundary > Policy"
    # "Enforce: Boundary > Policy"

  {%- else -%}

    "Skip"

  {%- endif -%}
EOT
}
