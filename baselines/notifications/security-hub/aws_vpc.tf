output "create_or_use" {
  value = var.enabled_caching == true ? local.create_vpc ? "WARNING: Infrastructure will be deployed on a NEW VPC" : "Infrastructure will be deployed on an existing VPC" : "No caching will be installed"

}

data "aws_vpc" "main_vpc" {
  count = var.enabled_caching ? local.create_vpc ? 0 : 1 : 0
  id    = var.vpc_id
}

data "aws_subnet" "public" {
  count  = var.enabled_caching ? local.create_vpc ? 0 : 1 : 0
  vpc_id = var.vpc_id
  id     = var.public_subnet_id
}

data "aws_subnet" "private" {
  count  = var.enabled_caching ? local.create_vpc ? 0 : 1 : 0
  vpc_id = var.vpc_id
  id     = var.private_subnet_id
}

resource "aws_vpc" "main_vpc" {
  count      = var.enabled_caching ? local.create_vpc ? 1 : 0 : 0
  cidr_block = "192.0.0.0/26"

  tags = {
    "Company" = "Turbot"
    "Product" = "SecurityHubNotifier",
    "Name"    = "turbot-firehose-to-sec-hub-vpc"
  }
}

resource "aws_subnet" "public" {
  count      = var.enabled_caching ? local.create_vpc ? 1 : 0 : 0
  vpc_id     = aws_vpc.main_vpc[0].id
  cidr_block = "192.0.0.16/28"

  tags = {
    "Company" = "Turbot"
    "Product" = "SecurityHubNotifier"
    "Name"    = "turbot-firehose-to-sec-hub-public-subnet"
  }
}

resource "aws_subnet" "private" {
  count      = var.enabled_caching ? local.create_vpc ? 1 : 0 : 0
  vpc_id     = aws_vpc.main_vpc[0].id
  cidr_block = "192.0.0.0/28"

  tags = {
    "Company" = "Turbot"
    "Product" = "SecurityHubNotifier"
    "Name"    = "turbot-firehose-to-sec-hub-private-subnet"
  }
}

resource "aws_internet_gateway" "security_hub_traffic" {
  count  = var.enabled_caching ? local.create_vpc ? 1 : 0 : 0
  vpc_id = local.vpc_id

  tags = {
    "Company" = "Turbot"
    "Product" = "SecurityHubNotifier"
    "Name"    = "turbot-firehose-to-sec-hub-private-igw"
  }
}

resource "aws_nat_gateway" "security_hub_traffic" {
  count         = var.enabled_caching ? local.create_vpc ? 1 : 0 : 0
  depends_on    = [aws_internet_gateway.security_hub_traffic]
  allocation_id = aws_eip.security_hub_traffic[0].id
  subnet_id     = local.public_subnet_id

  tags = {
    "Company" = "Turbot"
    "Product" = "SecurityHubNotifier"
    "Name"    = "turbot-firehose-to-sec-hub-private-nat"
  }
}

resource "aws_eip" "security_hub_traffic" {
  count = var.enabled_caching ? local.create_vpc ? 1 : 0 : 0
  tags = {
    "Company" = "Turbot"
    "Product" = "SecurityHubNotifier"
    "Name"    = "turbot-firehose-to-sec-hub-communication-ip"
  }
}

resource "aws_route_table_association" "public" {
  count          = var.enabled_caching ? local.create_vpc ? 1 : 0 : 0
  subnet_id      = local.public_subnet_id
  route_table_id = aws_route_table.public[0].id
}

resource "aws_route_table_association" "private" {
  count          = var.enabled_caching ? local.create_vpc ? 1 : 0 : 0
  subnet_id      = local.private_subnet_id
  route_table_id = aws_route_table.private[0].id
}

resource "aws_route_table" "private" {
  count  = var.enabled_caching ? local.create_vpc ? 1 : 0 : 0
  vpc_id = local.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.security_hub_traffic[0].id
  }

  tags = {
    "Company" = "Turbot"
    "Product" = "SecurityHubNotifier"
    "Name"    = "turbot-firehose-to-sec-hub-private-route-table"
  }
}

resource "aws_route_table" "public" {
  count  = var.enabled_caching ? local.create_vpc ? 1 : 0 : 0
  vpc_id = local.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.security_hub_traffic[0].id
  }

  tags = {
    "Company" = "Turbot"
    "Product" = "SecurityHubNotifier"
    "Name"    = "turbot-firehose-to-sec-hub-public-route-table"
  }
}

resource "aws_security_group" "allow_memcached_to_lambda" {
  count       = var.enabled_caching ? local.create_vpc ? 1 : 0 : 0
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
    "Product" = "SecurityHubNotifier",
    "Name"    = "turbot-firehose-to-sec-hub-allow-memcached"
  }
}

resource "aws_security_group" "permit_internet" {
  count       = var.enabled_caching ? local.create_vpc ? 1 : 0 : 0
  name        = "turbot-firehose-to-sec-hub-permit-internet"
  description = "Allows communication to the internet"
  vpc_id      = local.vpc_id

  egress {
    description = "Communication to internet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Company" = "Turbot"
    "Product" = "SecurityHubNotifier",
    "Name"    = "turbot-firehose-to-sec-hub-permit-all"
  }
}


# resource "aws_default_security_group" "allow_memcached_to_lambda" {
#   count  = var.enabled_caching ? local.create_vpc ? 1 : 0 : 0
#   vpc_id = local.vpc_id

#   ingress {
#     description = "Communication to memcached"
#     from_port   = 11211
#     to_port     = 11211
#     protocol    = "tcp"
#     cidr_blocks = [local.vpc_cidr_block]
#   }

#   egress {
#     description = "Communication from memcached"
#     from_port   = 11211
#     to_port     = 11211
#     protocol    = "tcp"
#     cidr_blocks = [local.vpc_cidr_block]
#   }

#   tags = {
#     "Company" = "Turbot"
#     "Product" = "SecurityHubNotifier"
#     "Name"    = "turbot-firehose-to-sec-hub-allow-memcached"
#   }
# }
