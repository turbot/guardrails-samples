variable "vpc_id" {
  description = "ID of the existing VPC"
  type        = string
}

variable "trusted_cidr_block" {
  description = "CIDR block allowed to access this SG (e.g., office or bastion IP)"
  type        = string
}

resource "aws_security_group" "secure_web_sg" {
  name        = "secure-web-sg"
  description = "Security group for controlled web traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name      = "secure-web-sg"
    Managedby = "Guardrails"
  }
}

# Ingress: HTTPS (443) only from trusted CIDR block
resource "aws_vpc_security_group_ingress_rule" "https_from_trusted" {
  security_group_id = aws_security_group.secure_web_sg.id
  description       = "HTTPS from trusted CIDR"
  cidr_ipv4         = var.trusted_cidr_block
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}

# Egress: HTTPS (443) only
resource "aws_vpc_security_group_egress_rule" "https_outbound" {
  security_group_id = aws_security_group.secure_web_sg.id
  description       = "Allow HTTPS outbound"
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}

# Egress: DNS (UDP 53) to allow name resolution (optional)
resource "aws_vpc_security_group_egress_rule" "dns_udp_outbound" {
  security_group_id = aws_security_group.secure_web_sg.id
  description       = "Allow DNS outbound (UDP)"
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 53
  to_port           = 53
  ip_protocol       = "udp"
}

output "security_group_id" {
  value = aws_security_group.secure_web_sg.id
}