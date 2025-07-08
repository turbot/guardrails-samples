locals {
  bastion_host_name_sanitized = replace(var.bastion_host_name, "[^a-zA-Z0-9+=,.@_-]", "-")
  use_public_ipv4_address     = lower(var.public_ipv4_address) == "true"
}
