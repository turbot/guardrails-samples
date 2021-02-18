output "create_or_use" {
  value = var.enabled_caching == true ? local.create_vpc ? "WARNING: Infrastructure will be deployed on a NEW VPC" : "Infrastructure will be deployed on an existing VPC" : "No caching will be installed"

}

data "aws_vpc" "main_vpc" {
  count = var.enabled_caching ? local.create_vpc ? 0 : 1 : 0
  id    = var.vpc_id
}

data "aws_subnet" "public_subnet" {
  count  = var.enabled_caching ? local.create_vpc ? 0 : 1 : 0
  vpc_id = var.vpc_id
  id     = var.public_subnet_id
}

data "aws_subnet" "private_subnet" {
  count  = var.enabled_caching ? local.create_vpc ? 0 : 1 : 0
  vpc_id = var.vpc_id
  id     = var.private_subnet_id
}

resource "aws_vpc" "main_vpc" {
  count      = var.enabled_caching ? local.create_vpc ? 1 : 0 : 0
  cidr_block = "192.0.0.0/28"

  tags = {
    "Company" = "Turbot"
    "Product" = "SecurityHubNotifier",
    "Name"    = "turbot-firehose-to-sec-hub-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  count             = var.enabled_caching ? local.create_vpc ? 1 : 0 : 0
  vpc_id            = aws_vpc.main_vpc[0].id
  cidr_block        = "192.0.0.0/28"
  availability_zone = var.aws_availability_zone

  tags = {
    "Company" = "Turbot"
    "Product" = "SecurityHubNotifier"
    "Name"    = "turbot-firehose-to-sec-hub-subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  count             = var.enabled_caching ? local.create_vpc ? 1 : 0 : 0
  vpc_id            = aws_vpc.main_vpc[0].id
  cidr_block        = "192.0.0.0/28"
  availability_zone = var.aws_availability_zone

  tags = {
    "Company" = "Turbot"
    "Product" = "SecurityHubNotifier"
    "Name"    = "turbot-firehose-to-sec-hub-subnet"
  }
}


resource "aws_security_group" "allow_memcached_to_lambda" {
  count       = local.create_vpc ? 0 : 1
  name        = "turbot-firehose-to-sec-hub-allow-memcached"
  description = "Allows communication to memcached from Lambda"
  vpc_id      = local.vpc_id

  ingress {
    description = "Communication to memcached"
    from_port   = 11211
    to_port     = 11211
    protocol    = "tcp"
    cidr_blocks = [local.vpc_cidr_block]
  }

  egress {
    description = "Communication from memcached"
    from_port   = 11211
    to_port     = 11211
    protocol    = "tcp"
    cidr_blocks = [local.vpc_cidr_block]
  }

  tags = {
    "Company" = "Turbot"
    "Product" = "SecurityHubNotifier"
  }
}

resource "aws_default_security_group" "allow_memcached_to_lambda" {
  count  = var.enabled_caching ? local.create_vpc ? 1 : 0 : 0
  vpc_id = local.vpc_id

  ingress {
    description = "Communication to memcached"
    from_port   = 11211
    to_port     = 11211
    protocol    = "tcp"
    cidr_blocks = [local.vpc_cidr_block]
  }

  egress {
    description = "Communication from memcached"
    from_port   = 11211
    to_port     = 11211
    protocol    = "tcp"
    cidr_blocks = [local.vpc_cidr_block]
  }

  tags = {
    "Company" = "Turbot"
    "Product" = "SecurityHubNotifier"
  }
}
