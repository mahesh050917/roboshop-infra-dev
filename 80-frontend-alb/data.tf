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

data "aws_ssm_parameter" "redis_sg_id" {
  name = "/${var.project}/${var.env}/redis_sg_id"
}


data "aws_ssm_parameter" "mysql_sg_id" {
  name = "/${var.project}/${var.env}/mysql_sg_id"
}

data "aws_ssm_parameter" "db_private_subnet_ids" {
  name        = "/${var.project}/${var.env}/db_private_subnet_ids"

}

data "aws_ssm_parameter" "private_subnet_ids" {
  name        = "/${var.project}/${var.env}/private_subnet_ids"
}

data "aws_ssm_parameter" "mongodb_sg_id" {
  name = "/${var.project}/${var.env}/mongodb_sg_id"
}

data "aws_route53_zone" "daws88s_zone" {
  name         = "daws88s.shop"
  private_zone = false
}

data "aws_ssm_parameter" "roboshop_password" {
  name = "/${var.project}/vm_password"
}

data "aws_ssm_parameter" "frontend_alb_sg_id" {
  name = "/${var.project}/${var.env}/frontend_alb_sg_id"
}

data "aws_ssm_parameter" "backend_alb_sg_id" {
  name = "/${var.project}/${var.env}/backend_alb_sg_id"
}

data "aws_ssm_parameter" "acm_cert_arn" {
  name        = "/${var.project}/acm_cert_arn"
}