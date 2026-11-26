data "aws_ssm_parameter" "public_subnet_ids" {
  name        = "/${var.project}/${var.env}/public_subnet_ids"
}

data "aws_route53_zone" "daws88s_zone" {
  name         = "daws88s.shop"
  private_zone = false
}



data "aws_ssm_parameter" "frontend_alb_sg_id" {
  name = "/${var.project}/${var.env}/frontend_alb_sg_id"
}



data "aws_ssm_parameter" "acm_cert_arn" {
  name = "/${var.project}/acm_cert_arn"
}

