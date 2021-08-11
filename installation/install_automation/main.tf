provider "aws" {
  region = "us-east-2"
  profile = "default"
  default_tags {   
    tags = var.default_tags
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

variable "vpc_id" {}
variable "inbound_cidr" {}
variable "outbound_cidr" {}
variable "install_domain" {}
variable "default_tags" {}

data "aws_vpc" "turbot_vpc" {
  id = var.vpc_id
}

resource "aws_security_group" "turbot_alb" {
  name        = "turbot_alb"
  description = "Allow inbound web traffic"
  vpc_id      = data.aws_vpc.turbot_vpc.id
}

resource "aws_security_group_rule" "inbound_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = var.inbound_cidr
  security_group_id = aws_security_group.turbot_alb.id
}

resource "aws_security_group_rule" "inbound_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = var.inbound_cidr
  security_group_id = aws_security_group.turbot_alb.id
}

resource "aws_security_group" "turbot_oia" {
  name        = "turbot_oia"
  description = "Allow outbound API traffic"
  vpc_id      = data.aws_vpc.turbot_vpc.id
}

resource "aws_security_group_rule" "outbound_https" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = var.outbound_cidr
  security_group_id = aws_security_group.turbot_oia.id
}

resource "aws_security_group" "turbot_api" {
  name        = "turbot_api"
  description = "Allow connectivity between ALB and API"
  vpc_id      = data.aws_vpc.turbot_vpc.id
}

resource "aws_security_group_rule" "alb_to_api" {
  type                     = "egress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.turbot_api.id
  security_group_id        = aws_security_group.turbot_alb.id
}

resource "aws_security_group_rule" "api_from_alb" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.turbot_api.id
  source_security_group_id = aws_security_group.turbot_alb.id
}

resource "aws_route53_zone" "turbot_hosted_zone" {
  name = var.install_domain
}

output "hosted_zone_nameservers" {
  value = aws_route53_zone.turbot_hosted_zone.name_servers
}

output "oia_sg_id" {
  value = aws_security_group.turbot_oia.id
}

output "api_sg_id" {
  value = aws_security_group.turbot_api.id
}

output "alb_sg_id" {
  value = aws_security_group.turbot_alb.id
}