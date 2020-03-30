#### Create the AWS IAM role for Turbot
resource "aws_iam_role" "turbot_service_role" {
  name = var.role_name
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "sts:AssumeRole",
        "Principal" : {
          "AWS" : "arn:aws:iam::${var.turbot_account_id}:root"
        },
        "Effect" : "Allow",
        "Sid" : "",
        "Condition" : {
          "StringEquals" : {
            "sts:ExternalId" : "${var.turbot_external_id}"
          }
        }
      }
    ]
  })
}

# TODO: remove this
provider "aws" {
  region = "us-east-1"
}
# TODO: remove this

#### Attach the AdministratorAccess policy to the Turbot Role
resource "aws_iam_role_policy_attachment" "role_admin_policy" {
  role       = aws_iam_role.turbot_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  count      = var.read_only_access ? 0 : 1
}

#### Attach the ReadOnlyAccess policy to the Turbot Role
resource "aws_iam_role_policy_attachment" "role_readonly_policy" {
  role       = aws_iam_role.turbot_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
  count      = var.read_only_access ? 1 : 0
}

#### Attach the CloudWatchFullAccess policy to the Turbot Role
resource "aws_iam_role_policy_attachment" "role_cloudwatch_admin_policy" {
  role       = aws_iam_role.turbot_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
  count      = var.read_only_access ? 1 : 0
}

#### Attach the CloudWatchEventsFullAccess policy to the Turbot Role
resource "aws_iam_role_policy_attachment" "role_events_admin_policy" {
  role       = aws_iam_role.turbot_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchEventsFullAccess"
  count      = var.read_only_access ? 1 : 0
}

#### Attach the AmazonSNSFullAccess policy to the Turbot Role
resource "aws_iam_role_policy_attachment" "role_sns_admin_policy" {
  role       = aws_iam_role.turbot_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSNSFullAccess"
  count      = var.read_only_access ? 1 : 0
}

#### Create the AWS > Account resource in Turbot
resource "turbot_resource" "account_resource" {
  parent = var.parent_resource
  type   = "tmod:@turbot/aws#/resource/types/account"
  metadata = jsonencode({
    "aws" : {
      "accountId" : "${var.aws_account_id}",
      "partition" : "aws"
    }
  })
  data = jsonencode({
    "Id" : "${var.aws_account_id}"
  })
}

#### Set the credentials (Role, exteranl id) for the account via Turbot policies

# AWS > Account > Turbot IAM Role > External ID
resource "turbot_policy_setting" "turbotIamRoleExternalId" {
  resource = turbot_resource.account_resource.id
  type     = "tmod:@turbot/aws#/policy/types/turbotIamRoleExternalId"
  value    = var.turbot_external_id
}

# AWS > Account > Turbot IAM Role
resource "turbot_policy_setting" "turbotIamRole" {
  resource = turbot_resource.account_resource.id
  type     = "tmod:@turbot/aws#/policy/types/turbotIamRole"
  value    = aws_iam_role.turbot_service_role.arn
}
