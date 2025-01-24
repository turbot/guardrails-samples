variable "trusted_principals" {
  description = "A list of principal ARNs that can assume the role. These wil be added to the trust policy."
  type        = set(string)
}

resource "aws_iam_role" "read_only_role" {
  name = "read_only_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = var.trusted_principals
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "read_only" {
  role       = aws_iam_role.read_only_role.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}