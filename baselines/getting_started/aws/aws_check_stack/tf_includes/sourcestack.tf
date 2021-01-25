resource "aws_iam_role" "example_role" {
  name = "example_role"
  assume_role_policy = <<-EOF
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Principal": {
            "AWS": "arn:aws:iam::287590803701:root"
          },
          "Action": "sts:AssumeRole",
          "Condition": {
            "StringEquals": {
              "sts:ExternalId": "12345678"
            }
          }
        }
      ]
    }
    EOF
}

resource "aws_iam_policy" "example_policy" {
  name = "example_policy"
  policy = <<-EOF
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Action": [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",,
            "logs:DescribeLogGroups",
            "logs:DescribeLogStreams"
          ],
          "Effect": "Allow",
          "Resource": "*"
        }
      ]
    }
    EOF
}

resource "aws_iam_role_policy_attachment" "example_role_policy_attach" {
  role       = "${aws_iam_role.example_role.name}"
  policy_arn = "${aws_iam_policy.example_policy.arn}"
}