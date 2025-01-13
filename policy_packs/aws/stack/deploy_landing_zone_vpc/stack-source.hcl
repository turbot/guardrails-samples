variable "tag_prefix" {
    type        = string
    default     = ""
    description = "A prefix for naming the resources in this stack."
  }

variable "ip_assignments" {
  type        = map
  description = "A map of ip addresses to assign, by account-alias and region"

  default = {
    account-1-us-east-1 = "1.2.3.0/24"
    account-1-us-east-2 = "1.2.4.0/24"
    account-2-us-west-1 = "1.2.5.0/24"
    account-3-eu-east-1 = "1.2.6.0/24",
  }
}

variable "public_subnet_count" {
  type        = number
  description = "The number of public subnets to create."
  default     = 2
}

variable "private_subnet_count" {
  type        = number
  description = "The number of public subnets to create."
  default     = 2
}

variable "max_azs" {
  type        = number
  description = "The max number of AZs."
  default     = 2
}

# Declare the data source
data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_region" "current" {}

data "aws_iam_account_alias" "current" {}


locals {
  # If there is no entry for this account-region in the ip_assignments map, we wont create any resources
  unassigned    = !can(var.ip_assignments["${data.aws_iam_account_alias.current.account_alias}-${data.aws_region.current.name}"])
  total_subnets = var.public_subnet_count + var.private_subnet_count
  newbits       = ceil(log(local.total_subnets, 2))  # Calculate the newbits required for the cidrsubnet function based on number of subnets
  az_count      = var.max_azs > length(data.aws_availability_zones.available.names) ? length(data.aws_availability_zones.available.names) : var.max_azs
  az_list       = slice(data.aws_availability_zones.available.names, 0, local.az_count )
}

# VPC
resource "aws_vpc" "turbot_default" {
  cidr_block            =  lookup(var.ip_assignments, "${data.aws_iam_account_alias.current.account_alias}-${data.aws_region.current.name}")
  instance_tenancy      = "default"
  enable_dns_support    = true
  enable_dns_hostnames  = true

  tags = {
    Name	= "${var.tag_prefix}${data.aws_iam_account_alias.current.account_alias}-${data.aws_region.current.name}"
  }

  count = local.unassigned ? 0 : 1
}

locals {
  my_vpc = one(aws_vpc.turbot_default[*])
}


# Subnets
resource "aws_subnet" "turbot_public" {
  vpc_id            = local.my_vpc.id
  count             = local.unassigned ? 0 : var.public_subnet_count
  availability_zone = local.az_list[count.index % length(local.az_list)]
  cidr_block        = cidrsubnet(local.my_vpc.cidr_block, local.newbits, count.index)

  tags  = {
      Name          =  "${var.tag_prefix}public-${local.az_list[count.index % length(local.az_list)]}-${data.aws_iam_account_alias.current.account_alias}"
  }
}

resource "aws_subnet" "turbot_private" {
  vpc_id            = local.my_vpc.id
  count             = local.unassigned ? 0 :var.private_subnet_count
  availability_zone = local.az_list[count.index % length(local.az_list)]
  cidr_block        = cidrsubnet(local.my_vpc.cidr_block, local.newbits, var.public_subnet_count + count.index )

  tags  = {
      Name          =  "${var.tag_prefix}private-${local.az_list[count.index % length(local.az_list)]}-${data.aws_iam_account_alias.current.account_alias}"
  }
}


#  IGW
resource "aws_internet_gateway" "turbot_igw" {
  vpc_id = local.my_vpc.id
  count  = local.unassigned ? 0 : 1

  tags   = {
      Name =  "${var.tag_prefix}igw-${data.aws_iam_account_alias.current.account_alias}-${data.aws_region.current.name}"
  }
}

# NAT GWs & EIPs
resource "aws_eip" "nat_eip" {
  count = local.unassigned ? 0 : var.public_subnet_count

  tags  = {
    Name =  "${var.tag_prefix}eip-nat-${local.az_list[count.index % length(local.az_list)]}-${data.aws_iam_account_alias.current.account_alias}"
  }
}

resource "aws_nat_gateway" "turbot_nat_gw" {
  allocation_id = aws_eip.nat_eip[count.index].id
  subnet_id     = aws_subnet.turbot_public[count.index].id
  count         = local.unassigned ? 0 : var.public_subnet_count
  depends_on    = [ aws_internet_gateway.turbot_igw ]

  tags  = {
    Name =  "${var.tag_prefix}natgw-${data.aws_availability_zones.available.names[count.index]}-${data.aws_iam_account_alias.current.account_alias}"
  }
}

# Public route table / routes
resource "aws_route_table" "public" {
  vpc_id =  local.my_vpc.id
  count  = local.unassigned ? 0 : 1

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = one(aws_internet_gateway.turbot_igw.*.id)
  }

  tags  = {
    Name =  "${var.tag_prefix}public-rtb-${data.aws_iam_account_alias.current.account_alias}-${data.aws_region.current.name}"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.turbot_public[count.index].id
  route_table_id = one(aws_route_table.public.*.id)
  count          = local.unassigned ? 0 : var.public_subnet_count

}


# Private Route Tables / Routes
resource "aws_route_table" "private" {
  vpc_id = local.my_vpc.id
  count  = local.unassigned ? 0 : var.public_subnet_count

  tags   = {
    Name =  "${var.tag_prefix}private-rtb-${data.aws_availability_zones.available.names[count.index]}-${data.aws_iam_account_alias.current.account_alias}"
  }
}

resource "aws_route" "private_natgw" {
  route_table_id              = aws_route_table.private[count.index].id
  destination_cidr_block      = "0.0.0.0/0"
  nat_gateway_id              = aws_nat_gateway.turbot_nat_gw[count.index].id
  count                       = local.unassigned ? 0 : var.public_subnet_count
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.turbot_private[count.index].id
  route_table_id = aws_route_table.private[count.index % var.public_subnet_count].id
  count          = local.unassigned ? 0 : var.private_subnet_count
}


####### Outputs ###
output "vpc_id" {
  value     = try(local.my_vpc.id, "")
}

output "public_subnets" {
  value = aws_subnet.turbot_public.*.id
}

output "private_subnets" {
  value = aws_subnet.turbot_private.*.id
}