data "aws_ami" "joindevops" {
  most_recent = true
  owners      = ["973714476881"]

  filter {
    name   = "name"
    values = ["Redhat-9-DevOps-Practice"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


data "aws_ssm_parameter" "bastion_sg_id" {
  name = "/${var.project}/${var.env}/bastion_sg_id"
}


data "aws_ssm_parameter" "public_subnet_ids" {
  name        = "/${var.project}/${var.env}/public_subnet_ids"

}

data "aws_ssm_parameter" "catalogue_sg_id" {
  name = "/${var.project}/${var.env}/catalogue_sg_id"
}

data "aws_ssm_parameter" "private_subnet_ids" {
  name        = "/${var.project}/${var.env}/private_subnet_ids"

}

data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project}/${var.env}/vpc_id"
}

data "aws_lb" "backend_alb" {
  name               = "${var.project}-backend-${var.env}-alb"
}

data "aws_route53_zone" "daws88s_zone" {
  name         = "daws88s.shop"
  private_zone = false
}

data"aws_ssm_parameter" "backend_listener_arn" {
  name        = "/${var.project}/${var.env}/backend_listener_arn"

}