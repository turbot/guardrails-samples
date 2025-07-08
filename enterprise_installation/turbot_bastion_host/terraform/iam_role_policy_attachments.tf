resource "aws_iam_role_policy" "cloudwatch_logging" {
  count = var.cloudwatch_log_group_name != "" ? 1 : 0

  name = "${local.bastion_host_name_sanitized}-cwlogs"
  role = aws_iam_role.bastion_role[0].name
  policy = data.aws_iam_policy_document.cloudwatch_logging[0].json
}

resource "aws_iam_role_policy" "s3_logging" {
  count = var.s3_bucket_with_prefix != "" ? 1 : 0

  name = "${local.bastion_host_name_sanitized}-s3log"
  role = aws_iam_role.bastion_role[0].name
  policy = data.aws_iam_policy_document.s3_logging[0].json
}

resource "aws_iam_role_policy" "kms_decrypt" {
  count = var.kms_encryption_key_arn != "" ? 1 : 0

  name = "${local.bastion_host_name_sanitized}-kms"
  role = aws_iam_role.bastion_role[0].name
  policy = data.aws_iam_policy_document.kms_decrypt[0].json
}

resource "aws_iam_role_policy" "bastion_rds_describe" {
  name = "${var.bastion_host_name}-rds-describe"
  role = aws_iam_role.bastion_role[0].name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "rds:DescribeDBInstances"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ssm_managed_policy" {
  count      = var.alternative_iam_role == "" ? 1 : 0
  role       = aws_iam_role.bastion_role[0].name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
