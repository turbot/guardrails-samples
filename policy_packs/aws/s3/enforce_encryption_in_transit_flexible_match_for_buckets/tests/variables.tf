variable "test_prefix" {
  type        = string
  description = "Prefix for test bucket names to avoid collisions"
  default     = "eit-calc-test"
}

variable "aws_region" {
  type        = string
  description = "AWS region for test buckets"
  default     = "us-east-1"
}
