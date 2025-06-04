variable "vpc_id" {
  description = "ID of the existing VPC"
  type        = string
  default     = ""
}

variable "sg_tag_key" {
  description = "Optional tag key to filter security groups (case-insensitive)"
  type        = string
  default     = ""
}

variable "sg_tag_value" {
  description = "Optional tag value to filter security groups (case-insensitive)"
  type        = string
  default     = ""
}

# Discover all security groups in the specified VPC
# Only run if vpc_id is provided (not empty)
data "aws_security_groups" "vpc_sgs" {
  count = var.vpc_id != "" ? 1 : 0
  
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

# Fetch full metadata for each SG (to access tags)
# Only run if vpc_id is provided (not empty)
data "aws_security_group" "detailed" {
  for_each = var.vpc_id != "" ? toset(data.aws_security_groups.vpc_sgs[0].ids) : toset([])
  id       = each.value
}

locals {
  # Only proceed if vpc_id is provided
  should_create_rules = var.vpc_id != ""
  
  desired_ingress_rules = [
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

  desired_egress_rules = [
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

  # Select security groups based on tag filtering
  selected_sg_ids = local.should_create_rules ? [
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
  ] : []

  # Create ingress rules for each security group
  ingress_rules_to_create = local.should_create_rules ? flatten([
    for sg_id in local.selected_sg_ids : [
      for rule in local.desired_ingress_rules : merge(rule, {
        sg_id = sg_id
        rule_key = "${rule.protocol}-${rule.port}-${rule.port}-${rule.cidr}"
      })
    ]
  ]) : []

  # Create egress rules for each security group  
  egress_rules_to_create = local.should_create_rules ? flatten([
    for sg_id in local.selected_sg_ids : [
      for rule in local.desired_egress_rules : merge(rule, {
        sg_id = sg_id
        rule_key = "${rule.protocol}-${rule.port}-${rule.port}-${rule.cidr}"
      })
    ]
  ]) : []
}

# Create ingress rules
resource "aws_vpc_security_group_ingress_rule" "internal_access" {
  for_each = {
    for rule in local.ingress_rules_to_create :
    "${rule.sg_id}-${rule.protocol}-${rule.port}-${replace(replace(rule.cidr, ".", "_"), "/", "_")}" => rule
  }

  security_group_id = each.value.sg_id
  description       = each.value.description
  cidr_ipv4         = each.value.cidr
  from_port         = each.value.port
  to_port           = each.value.port
  ip_protocol       = each.value.protocol

  tags = {
    Managedby     = "Guardrails"
    TemporaryRule = "true"
    CreatedBy     = "TimeSpecificException"
  }
}

# Create egress rules
resource "aws_vpc_security_group_egress_rule" "outbound_access" {
  for_each = {
    for rule in local.egress_rules_to_create :
    "${rule.sg_id}-${rule.protocol}-${rule.port}-${replace(replace(rule.cidr, ".", "_"), "/", "_")}" => rule
  }

  security_group_id = each.value.sg_id
  description       = each.value.description
  cidr_ipv4         = each.value.cidr
  from_port         = each.value.port
  to_port           = each.value.port
  ip_protocol       = each.value.protocol

  tags = {
    Managedby     = "Guardrails"
    TemporaryRule = "true"
    CreatedBy     = "TimeSpecificException"
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

output "rules_summary" {
  description = "Summary of rule management"
  value = {
    total_security_groups = length(local.selected_sg_ids)
    ingress_rules_created = length(aws_vpc_security_group_ingress_rule.internal_access)
    egress_rules_created = length(aws_vpc_security_group_egress_rule.outbound_access)
    vpc_id_provided = var.vpc_id != ""
    rules_creation_enabled = local.should_create_rules
  }
}