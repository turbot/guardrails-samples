data "aws_vpc" "main_vpc" {
  count = local.create_vpc == 1 ? 0 : 1
  id    = var.vpc_id
}

data "aws_subnet" "main_vpc" {
  count = local.create_vpc == 1 ? 0 : 1
  id    = var.subnet_id
}

resource "aws_vpc" "main_vpc" {
  count      = local.create_vpc
  cidr_block = "192.0.0.0/28"

  tags = {
    "Company" = "Turbot"
    "Product" = "SecurityHubNotifier",
    "Name"    = "turbot-firehose-to-sec-hub-vpc"
  }
}

resource "aws_subnet" "main_vpc" {
  count      = local.create_vpc
  vpc_id     = aws_vpc.main_vpc[0].id
  cidr_block = "192.0.0.0/28"

  tags = {
    "Company" = "Turbot"
    "Product" = "SecurityHubNotifier"
    "Name"    = "turbot-firehose-to-sec-hub-subnet"
  }
}

resource "aws_security_group" "allow_memcached_to_lambda" {
  count       = local.create_vpc == 1 ? 0 : 1
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
  count  = local.create_vpc
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
