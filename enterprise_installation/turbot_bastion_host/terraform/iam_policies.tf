
data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "cloudwatch_logging" {
  count = var.cloudwatch_log_group_name != "" ? 1 : 0

  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = [
      "arn:aws:logs:${data.aws_region.current.id}:${data.aws_caller_identity.current.account_id}:log-group:${var.cloudwatch_log_group_name}:*"
    ]
  }
}

data "aws_iam_policy_document" "s3_logging" {
  count = var.s3_bucket_with_prefix != "" ? 1 : 0

  statement {
    effect = "Allow"
    actions = [
      "s3:PutObject"
    ]
    resources = [
      "arn:aws:s3:::${var.s3_bucket_with_prefix}*"
    ]
  }
}

data "aws_iam_policy_document" "kms_decrypt" {
  count = var.kms_encryption_key_arn != "" ? 1 : 0

  statement {
    effect = "Allow"
    actions = [
      "kms:Decrypt",
      "kms:GenerateDataKey"
    ]
    resources = [var.kms_encryption_key_arn]
  }
}
