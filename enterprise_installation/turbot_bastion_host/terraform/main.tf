provider "aws" {
  region = var.region
}

resource "aws_iam_role" "bastion_role" {
  count = var.alternative_iam_role == "" ? 1 : 0
  name = replace("${var.bastion_host_name}-role", "[^a-zA-Z0-9+=,.@_-]", "-")
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_instance_profile" "bastion_profile" {
  count = var.alternative_iam_role == "" ? 1 : 0
  name  = "${var.bastion_host_name}-profile"
  role  = aws_iam_role.bastion_role[0].name
}

resource "aws_launch_template" "bastion_template" {
  name_prefix   = replace("${var.bastion_host_name}-lt", "[^a-zA-Z0-9()_.-/]", "-")
  image_id      = data.aws_ssm_parameter.ami.value
  instance_type = var.bastion_instance_type
  user_data     = base64encode(templatefile("${path.module}/userdata.sh", {
    stack_name     = var.bastion_host_name
    time_to_live   = var.lifetime_hours
    lifetime_hours = var.lifetime_hours
  }))
  iam_instance_profile {
    name = var.alternative_iam_role != "" ? null : aws_iam_instance_profile.bastion_profile[0].name
  }
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = var.root_volume_size
      volume_type = "gp3"
    }
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = var.bastion_host_name
    }
  }
  network_interfaces {
    device_index                = 0
    subnet_id                   = var.public_subnet_id
    associate_public_ip_address = local.use_public_ipv4_address
  }
}

resource "aws_instance" "bastion" {
  ami                         = data.aws_ssm_parameter.ami.value
  instance_type               = var.bastion_instance_type
  subnet_id                   = var.public_subnet_id
  associate_public_ip_address = local.use_public_ipv4_address
  user_data_base64            = base64encode(templatefile("${path.module}/userdata.sh", {
    stack_name     = var.bastion_host_name
    time_to_live   = var.lifetime_hours
    lifetime_hours = var.lifetime_hours
  }))
  iam_instance_profile        = var.alternative_iam_role != "" ? null : aws_iam_instance_profile.bastion_profile[0].name
  root_block_device {
    volume_size = var.root_volume_size
    volume_type = "gp3"
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }
  tags = {
    Name = var.bastion_host_name
  }
}

data "aws_ssm_parameter" "ami" {
  name = var.latest_ami_ssm_param
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}
