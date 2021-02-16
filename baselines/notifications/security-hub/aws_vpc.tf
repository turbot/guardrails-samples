data "aws_vpc" "main_vpc" {
  count = var.enabled_caching && var.vpc_id == "" ? 0 : 1
  id    = var.vpc_id
}

data "aws_subnet" "main_vpc" {
  count = var.enabled_caching && var.vpc_id == "" ? 0 : 1
  id    = var.vpc_id
}

resource "aws_vpc" "main_vpc" {
  count      = var.enabled_caching && var.vpc_id == "" ? 1 : 0
  cidr_block = "192.0.0.0/28"

  tags = {
    "Company" = "Turbot"
    "Product" = "SecurityHubNotifier",
    "Name"    = "turbot-firehose-to-sec-hub-vpc"
  }
}

resource "aws_subnet" "main_vpc" {
  count      = var.enabled_caching && var.vpc_id == "" ? 1 : 0
  vpc_id     = aws_vpc.main_vpc[0].id
  cidr_block = "192.0.0.0/28"

  tags = {
    "Company" = "Turbot"
    "Product" = "SecurityHubNotifier"
    "Name"    = "turbot-firehose-to-sec-hub-subnet"
  }
}

output "name" {
  value = local.vpc
}

resource "aws_security_group" "allow_memcached_to_lambda" {
  count       = var.enabled_caching && var.vpc_id == "" ? 0 : 1
  name        = "turbot-firehose-to-sec-hub-allow-memcached"
  description = "Allows communication to memcached from Lambda"
  vpc_id      = local.vpc.id

  ingress {
    description = "Communication to memcached"
    from_port   = 11211
    to_port     = 11211
    protocol    = "tcp"
    cidr_blocks = [
      local.vpc.cidr_block
    ]
  }

  egress {
    description = "Communication from memcached"
    from_port   = 11211
    to_port     = 11211
    protocol    = "tcp"
    cidr_blocks = [
      local.vpc.cidr_block
    ]
  }

  tags = {
    "Company" = "Turbot"
    "Product" = "SecurityHubNotifier"
  }
}

resource "aws_default_security_group" "allow_memcached_to_lambda" {
  count  = var.enabled_caching ? 1 : 0
  vpc_id = local.vpc.id

  ingress {
    description = "Communication to memcached"
    from_port   = 11211
    to_port     = 11211
    protocol    = "tcp"
    cidr_blocks = [
      local.vpc.cidr_block
    ]
  }

  egress {
    description = "Communication from memcached"
    from_port   = 11211
    to_port     = 11211
    protocol    = "tcp"
    cidr_blocks = [
      local.vpc.cidr_block
    ]
  }

  tags = {
    "Company" = "Turbot"
    "Product" = "SecurityHubNotifier"
  }
}
