variable "vpc_id" {
  description = "ID of the existing VPC"
  type        = string
}

variable "sg_tag_key" {
  description = "Optional tag key to filter security groups (case-insensitive)"
  type        = string
}

variable "sg_tag_value" {
  description = "Optional tag value to filter security groups (case-insensitive)"
  type        = string
}

# Discover all security groups in the specified VPC
data "aws_security_groups" "vpc_sgs" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

# Fetch full metadata for each SG (to access tags)
data "aws_security_group" "detailed" {
  for_each = toset(data.aws_security_groups.vpc_sgs.ids)
  id       = each.value
}

locals {
  ingress_rules = [
    {
      cidr        = "10.0.0.0/8"
      port        = 22
      protocol    = "tcp"
      description = "Allow SSH from 10.0.0.0/8"
    },
    {
      cidr        = "172.16.0.0/12"
      port        = 22
      protocol    = "tcp"
      description = "Allow SSH from 172.16.0.0/12"
    },
    {
      cidr        = "192.168.0.0/16"
      port        = 22
      protocol    = "tcp"
      description = "Allow SSH from 192.168.0.0/16"
    },
    {
      cidr        = "10.0.0.0/8"
      port        = 3389
      protocol    = "tcp"
      description = "Allow RDP from 10.0.0.0/8"
    },
    {
      cidr        = "172.16.0.0/12"
      port        = 3389
      protocol    = "tcp"
      description = "Allow RDP from 172.16.0.0/12"
    },
    {
      cidr        = "192.168.0.0/16"
      port        = 3389
      protocol    = "tcp"
      description = "Allow RDP from 192.168.0.0/16"
    }
  ]

  egress_rules = [
    {
      cidr        = "0.0.0.0/0"
      port        = 443
      protocol    = "tcp"
      description = "Temp: Allow outbound HTTPS"
    },
    {
      cidr        = "0.0.0.0/0"
      port        = 80
      protocol    = "tcp"
      description = "Temp: Allow outbound HTTP"
    }
  ]

  lowercase_tag_key   = lower(var.sg_tag_key)
  lowercase_tag_value = lower(var.sg_tag_value)

  selected_sg_ids = [
    for sg in data.aws_security_group.detailed :
    sg.id
    if(
      local.lowercase_tag_key == "" ? true :
      (
        anytrue([
          for k, v in sg.tags :
          lower(k) == local.lowercase_tag_key && lower(v) == local.lowercase_tag_value
        ])
      )
    )
  ]

  expanded_ingress_rules = flatten([
    for sg_id in local.selected_sg_ids : [
      for rule in local.ingress_rules : merge(rule, {
        sg_id = sg_id
      })
    ]
  ])

  expanded_egress_rules = flatten([
    for sg_id in local.selected_sg_ids : [
      for rule in local.egress_rules : merge(rule, {
        sg_id = sg_id
      })
    ]
  ])
}

resource "aws_vpc_security_group_ingress_rule" "internal_access" {
  for_each = {
    for pair in local.expanded_ingress_rules :
    "${pair.sg_id}-${pair.protocol}-${pair.port}-${replace(replace(pair.cidr, ".", "_"), "/", "_")}" => pair
  }

  security_group_id = each.value.sg_id
  description       = each.value.description
  cidr_ipv4         = each.value.cidr
  from_port         = each.value.port
  to_port           = each.value.port
  ip_protocol       = each.value.protocol

  tags = {
    Managedby = "Guardrails"
  }
}

resource "aws_vpc_security_group_egress_rule" "outbound_access" {
  for_each = {
    for pair in local.expanded_egress_rules :
    "${pair.sg_id}-${pair.protocol}-${pair.port}-${replace(replace(pair.cidr, ".", "_"), "/", "_")}" => pair
  }

  security_group_id = each.value.sg_id
  description       = each.value.description
  cidr_ipv4         = each.value.cidr
  from_port         = each.value.port
  to_port           = each.value.port
  ip_protocol       = each.value.protocol

  tags = {
    Managedby = "Guardrails"
  }
}

output "modified_security_groups" {
  description = "IDs of security groups that were modified"
  value       = local.selected_sg_ids
}

output "ingress_rules_created" {
  description = "Details of created ingress rules"
  value = {
    for k, v in aws_vpc_security_group_ingress_rule.internal_access : k => {
      security_group_id = v.security_group_id
      description       = v.description
      cidr_ipv4         = v.cidr_ipv4
      port_range        = "${v.from_port}-${v.to_port}"
    }
  }
}

output "egress_rules_created" {
  description = "Details of created egress rules"
  value = {
    for k, v in aws_vpc_security_group_egress_rule.outbound_access : k => {
      security_group_id = v.security_group_id
      description       = v.description
      cidr_ipv4         = v.cidr_ipv4
      port_range        = "${v.from_port}-${v.to_port}"
    }
  }
}

output "total_rules_created" {
  description = "Total number of security group rules created"
  value       = length(aws_vpc_security_group_ingress_rule.internal_access) + length(aws_vpc_security_group_egress_rule.outbound_access)
}